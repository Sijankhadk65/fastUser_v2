import 'package:fast_app_v2_1/src/bloc/cart_menu_bloc.dart';
import 'package:fast_app_v2_1/src/models/item.dart';
import 'package:fast_app_v2_1/src/models/vendor.dart';
import 'package:fast_app_v2_1/src/widgets/add_to_cart_dialouge.dart';
import 'package:fast_app_v2_1/src/widgets/menu_item_displayer.dart';
import 'package:fast_app_v2_1/src/widgets/source_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FavouriteScren extends StatefulWidget {
  final Map<String, dynamic> user;

  const FavouriteScren({
    Key? key,
    required this.user,
  }) : super(key: key);
  @override
  _FavouriteScrenState createState() => _FavouriteScrenState();
}

class _FavouriteScrenState extends State<FavouriteScren>
    with SingleTickerProviderStateMixin {
  late CartMenuBloc _cartMenuBloc;
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _cartMenuBloc = Provider.of<CartMenuBloc>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        appBar: AppBar(),
        body: Container(
          margin: const EdgeInsets.all(
            10,
          ),
          child: Column(
            children: <Widget>[
              TabBar(
                indicator: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(
                        0,
                        5,
                      ),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(
                    5,
                  ),
                ),
                controller: _tabController,
                tabs: const [
                  Text(
                    "Food",
                  ),
                  Text(
                    "Resturant",
                  )
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    StreamBuilder<List<String>>(
                      stream:
                          _cartMenuBloc.getFavouritesFood(widget.user['email']),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) return Text("${snapshot.error}");
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                            return const Text("Awaiting Bids....");
                          case ConnectionState.waiting:
                            return const Center(
                                child: CircularProgressIndicator());
                          case ConnectionState.active:
                            return snapshot.data!.isEmpty
                                ? GridView.count(
                                    crossAxisCount: 2,
                                    children: snapshot.data!
                                        .map(
                                          (favourite) =>
                                              StreamBuilder<MenuItem>(
                                            stream: _cartMenuBloc
                                                .getMenuItem(favourite),
                                            builder: (context, itemSnapshot) {
                                              if (itemSnapshot.hasError) {
                                                return Text(
                                                    "${itemSnapshot.error}");
                                              }
                                              switch (itemSnapshot
                                                  .connectionState) {
                                                case ConnectionState.none:
                                                  return const Text(
                                                      "Awaiting Bids....");
                                                case ConnectionState.waiting:
                                                  return const Center(
                                                      child:
                                                          CircularProgressIndicator());
                                                case ConnectionState.active:
                                                  return StreamBuilder<int>(
                                                    stream: _cartMenuBloc
                                                        .getVendorMinOrder(
                                                      itemSnapshot.data!.vendor
                                                          .toString(),
                                                    ),
                                                    builder: (context,
                                                        minOrderSnapshot) {
                                                      if (minOrderSnapshot
                                                          .hasError) {
                                                        return Text(
                                                            "${minOrderSnapshot.error}");
                                                      }
                                                      switch (minOrderSnapshot
                                                          .connectionState) {
                                                        case ConnectionState
                                                            .none:
                                                          return const Text(
                                                              "Awaiting Bids....");
                                                        case ConnectionState
                                                            .waiting:
                                                          return const Center(
                                                            child:
                                                                CircularProgressIndicator(),
                                                          );
                                                        case ConnectionState
                                                            .active:
                                                          return MenuItemDisplayer(
                                                            item: itemSnapshot
                                                                .data!,
                                                            isFeatured: snapshot
                                                                .data!
                                                                .contains(
                                                              itemSnapshot
                                                                  .data!.name,
                                                            ),
                                                            onTap: () {
                                                              _cartMenuBloc
                                                                  .toogleFavourite(
                                                                snapshot.data!
                                                                    .contains(
                                                                  itemSnapshot
                                                                      .data!
                                                                      .name,
                                                                ),
                                                                "food",
                                                                widget.user[
                                                                    'email'],
                                                                {
                                                                  "name":
                                                                      itemSnapshot
                                                                          .data!
                                                                          .name,
                                                                  "createdAt":
                                                                      itemSnapshot
                                                                          .data!
                                                                          .createdAt,
                                                                },
                                                              );
                                                            },
                                                            onTapped: () {
                                                              showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) =>
                                                                        AddToCartDialouge(
                                                                  item:
                                                                      itemSnapshot
                                                                          .data,
                                                                  user: widget
                                                                      .user,
                                                                  vendorName:
                                                                      itemSnapshot
                                                                          .data!
                                                                          .vendor!,
                                                                  minOrder:
                                                                      minOrderSnapshot
                                                                          .data!,
                                                                ),
                                                              );
                                                            },
                                                          );
                                                        case ConnectionState
                                                            .done:
                                                          return const Text(
                                                              "The task has complted");
                                                      }
                                                    },
                                                  );
                                                case ConnectionState.done:
                                                  return const Text(
                                                      "The task has complted");
                                              }
                                            },
                                          ),
                                        )
                                        .toList(),
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      SvgPicture.asset(
                                        "assets/svg/smile.svg",
                                        height: 200,
                                        width: 200,
                                      ),
                                      Center(
                                        child: Text(
                                          "Coming Soon!",
                                          style: GoogleFonts.oswald(
                                            fontStyle: FontStyle.italic,
                                            fontSize: 25,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                          case ConnectionState.done:
                            return const Text("The task has complted");
                        }
                      },
                    ),
                    StreamBuilder<List<String>>(
                      stream: _cartMenuBloc.getFavourites(
                          "resturant", widget.user['email']),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                            return const Text('Select lot');
                          case ConnectionState.waiting:
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          case ConnectionState.active:
                            return snapshot.data!.isNotEmpty
                                ? ListView(
                                    shrinkWrap: true,
                                    children: snapshot.data!
                                        .map(
                                          (favourite) => StreamBuilder<Vendor>(
                                            stream: _cartMenuBloc
                                                .getVendor(favourite),
                                            builder: (context, vendorSnapshot) {
                                              if (vendorSnapshot.hasError) {
                                                return Text(
                                                    "${vendorSnapshot.error}");
                                              }
                                              switch (vendorSnapshot
                                                  .connectionState) {
                                                case ConnectionState.none:
                                                  return const Text(
                                                      "Awaiting Bids....");
                                                case ConnectionState.waiting:
                                                  return const Center(
                                                      child:
                                                          CircularProgressIndicator());
                                                case ConnectionState.active:
                                                  return Provider(
                                                    create: (_) =>
                                                        CartMenuBloc(),
                                                    dispose: (context,
                                                            CartMenuBloc
                                                                bloc) =>
                                                        bloc.dispose(),
                                                    child: SourceCard(
                                                      isFeatured: snapshot.data!
                                                          .contains(
                                                        vendorSnapshot
                                                            .data!.name,
                                                      ),
                                                      vendor:
                                                          vendorSnapshot.data!,
                                                      user: widget.user,
                                                      onTap: () {
                                                        _cartMenuBloc
                                                            .toogleFavourite(
                                                          snapshot.data!
                                                              .contains(
                                                            vendorSnapshot
                                                                .data!.name,
                                                          ),
                                                          "resturant",
                                                          widget.user['email'],
                                                          {
                                                            "name":
                                                                vendorSnapshot
                                                                    .data!.name,
                                                          },
                                                        );
                                                      },
                                                    ),
                                                  );
                                                case ConnectionState.done:
                                                  return const Text(
                                                      "The task has complted");
                                              }
                                            },
                                          ),
                                        )
                                        .toList(),
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      SvgPicture.asset(
                                        "assets/svg/smile.svg",
                                        height: 200,
                                        width: 200,
                                      ),
                                      Center(
                                        child: Text(
                                          "Coming Soon!",
                                          style: GoogleFonts.oswald(
                                            fontStyle: FontStyle.italic,
                                            fontSize: 25,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                          case ConnectionState.done:
                            return Text('${snapshot.data} (closed)');
                        }
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
