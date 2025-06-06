import 'package:fast_app_v2_1/src/bloc/cart_menu_bloc.dart';
import 'package:fast_app_v2_1/src/screens/vendors_screen.dart';
import 'package:fast_app_v2_1/src/widgets/custom_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VendorListScreen extends StatefulWidget {
  final Map<String, dynamic> user;

  const VendorListScreen({Key? key, required this.user}) : super(key: key);
  @override
  _VendorListScreenState createState() => _VendorListScreenState();
}

class _VendorListScreenState extends State<VendorListScreen> {
  late CartMenuBloc _cartMenuBloc;
  @override
  void didChangeDependencies() {
    _cartMenuBloc = Provider.of<CartMenuBloc>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _cartMenuBloc.getTags();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vendors"),
      ),
      body: Container(
        margin: const EdgeInsets.only(
          top: 10,
          left: 10,
          right: 10,
        ),
        child: Material(
          elevation: 10,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(5),
            topRight: Radius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: StreamBuilder<List<String>>(
                    stream: _cartMenuBloc.tags,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text("Error: ${snapshot.error}");
                      }
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          return const Text("Awaiting Bids....");
                        case ConnectionState.waiting:
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        case ConnectionState.active:
                          return CustomTabView(
                            itemCount: snapshot.data!.length,
                            tabBuilder: (context, index) => Text(
                              snapshot.data![index].toUpperCase(),
                            ),
                            pageBuilder: (context, index) => Provider(
                              create: (_) => CartMenuBloc(),
                              child: VendorsScreen(
                                tag: snapshot.data![index],
                                user: widget.user,
                              ),
                            ),
                          );
                        case ConnectionState.done:
                          return const Text("The task has completed");
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
