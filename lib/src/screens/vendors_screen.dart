import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../bloc/cart_menu_bloc.dart';
import '../models/vendor.dart';
import '../widgets/source_card.dart';
import 'package:provider/provider.dart';

class VendorsScreen extends StatefulWidget {
  final String tag;
  final Map<String, dynamic>? user;

  const VendorsScreen({Key? key, required this.tag, this.user})
      : super(key: key);
  @override
  _VendorsScreenState createState() => _VendorsScreenState();
}

class _VendorsScreenState extends State<VendorsScreen> {
  late CartMenuBloc _cartMenuBloc;

  @override
  void didChangeDependencies() {
    _cartMenuBloc = Provider.of<CartMenuBloc>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _cartMenuBloc.getVendors(widget.tag);
    return StreamBuilder<List<Vendor>>(
      stream: _cartMenuBloc.vendors,
      builder: (context, snapshot) {
        if (snapshot.hasError) return Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return const Text('Select lot');
          case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case ConnectionState.active:
            return snapshot.data!.isNotEmpty
                ? StreamBuilder<List<String>>(
                    stream: _cartMenuBloc.getFavourites(
                      "resturant",
                      widget.user!['email'],
                    ),
                    builder: (context, favouriteSnapshot) {
                      if (favouriteSnapshot.hasError) {
                        return Text("${favouriteSnapshot.error}");
                      }
                      switch (favouriteSnapshot.connectionState) {
                        case ConnectionState.none:
                          return const Text("Awaiting bids...");
                        case ConnectionState.waiting:
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        case ConnectionState.active:
                          return ListView(
                            shrinkWrap: true,
                            children: snapshot.data!
                                .map<Widget>(
                                  (vendor) => Provider(
                                    create: (_) => CartMenuBloc(),
                                    dispose: (context, CartMenuBloc bloc) =>
                                        bloc.dispose(),
                                    child: SourceCard(
                                      isFeatured:
                                          favouriteSnapshot.data!.contains(
                                        vendor.name,
                                      ),
                                      vendor: vendor,
                                      user: widget.user!,
                                      onTap: () {
                                        _cartMenuBloc.toogleFavourite(
                                          favouriteSnapshot.data!.contains(
                                            vendor.name,
                                          ),
                                          "resturant",
                                          widget.user!['email'],
                                          {
                                            "name": vendor.name,
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                )
                                .toList(),
                          );
                        case ConnectionState.done:
                          return Text("The Task has complted");
                      }
                    },
                  )
                : Center(
                    child: Text(
                      "No Vendors Found.",
                      style: GoogleFonts.oswald(
                        color: Colors.orange[800],
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  );
          case ConnectionState.done:
            return Text('${snapshot.data} (closed)');
        }
      },
    );
  }
}
