import 'package:built_collection/built_collection.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fast_app_v2_1/src/bloc/cart_item_bloc.dart';
import 'package:fast_app_v2_1/src/bloc/cart_menu_bloc.dart';
import 'package:fast_app_v2_1/src/models/community_item.dart';
import 'package:fast_app_v2_1/src/models/item.dart';
import 'package:fast_app_v2_1/src/widgets/add_to_cart_dialouge.dart';
import 'package:fast_app_v2_1/src/widgets/custom_tab_bar.dart';
import 'package:fast_app_v2_1/src/widgets/menu_item_displayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';

class CommunityDetailScreen extends StatefulWidget {
  final CommunityItem? communityItem;
  final String? vendorName, vendorID;
  final DateTime? openingTime, closingTime;
  final int? minOrder;

  final BuiltList<String>? categories;
  final Map<String, dynamic>? user;
  final bool? shouldSchedule, isNight;

  const CommunityDetailScreen({
    Key? key,
    this.communityItem,
    this.isNight,
    this.user,
    this.categories,
    this.vendorName,
    this.vendorID,
    this.openingTime,
    this.minOrder,
    this.shouldSchedule,
    this.closingTime,
  }) : super(
          key: key,
        );

  @override
  _CommunityDetailScreenState createState() => _CommunityDetailScreenState();
}

class _CommunityDetailScreenState extends State<CommunityDetailScreen> {
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
        title: Text(widget.communityItem!.title.toString()),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      tileMode: TileMode.clamp,
                      colors: [
                        Colors.black,
                        Colors.black,
                      ]),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.3), BlendMode.dstOut),
                    image: NetworkImage(
                      widget.communityItem!.photoURI.toString(),
                    ),
                  ),
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(50.0))),
              child: const Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.favorite_border_outlined,
                    color: Colors.white,
                    size: 30.0,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.communityItem!.title.toString(),
                    style: const TextStyle(
                        fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      const Icon(EvaIcons.map, color: Colors.black),
                      Text(
                        widget.communityItem!.city.toString(),
                        style: const TextStyle(
                            color: Color(0xffc4c4c4),
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Description:",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "${widget.communityItem!.description}",
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Products:",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 500,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: CustomTabView(
                              itemCount: widget.categories!.length,
                              tabBuilder: (context, index) =>
                                  Text(widget.categories![index]),
                              pageBuilder: (context, index) =>
                                  StreamBuilder<List<MenuItem>>(
                                stream: _cartMenuBloc.getMenu(
                                  widget.categories![index],
                                  widget.vendorName!,
                                ),
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {
                                    return Text("Error: ${snapshot.error}");
                                  }
                                  switch (snapshot.connectionState) {
                                    case ConnectionState.none:
                                      return const Text("Awaiting Bids....");
                                    case ConnectionState.waiting:
                                      return Center(
                                        child: JumpingDotsProgressIndicator(
                                          fontSize: 100,
                                        ),
                                      );
                                    case ConnectionState.active:
                                      return snapshot.data!.isNotEmpty
                                          ? StreamBuilder<List<String>>(
                                              stream:
                                                  _cartMenuBloc.getFavourites(
                                                      "food",
                                                      widget.user!['email']),
                                              builder:
                                                  (context, favouriteSnapshot) {
                                                if (favouriteSnapshot
                                                    .hasError) {
                                                  return Text(
                                                      "${favouriteSnapshot.error}");
                                                }
                                                switch (favouriteSnapshot
                                                    .connectionState) {
                                                  case ConnectionState.none:
                                                    return const Text(
                                                        "Awaiting Bids...");
                                                  case ConnectionState.waiting:
                                                    return Center(
                                                      child:
                                                          JumpingDotsProgressIndicator(
                                                        fontSize: 20.0,
                                                      ),
                                                    );
                                                  case ConnectionState.active:
                                                    return GridView.count(
                                                      crossAxisCount: 2,
                                                      shrinkWrap: true,
                                                      children: snapshot.data!
                                                          .map<Widget>(
                                                            (f) =>
                                                                MenuItemDisplayer(
                                                              item: f,
                                                              isFeatured:
                                                                  favouriteSnapshot
                                                                      .data!
                                                                      .contains(
                                                                          f.name),
                                                              onTap: () {
                                                                _cartMenuBloc
                                                                    .toogleFavourite(
                                                                  favouriteSnapshot
                                                                      .data!
                                                                      .contains(
                                                                          f.name),
                                                                  "food",
                                                                  widget.user![
                                                                      'email'],
                                                                  {
                                                                    "name":
                                                                        f.name,
                                                                    "createdAt":
                                                                        f.createdAt,
                                                                  },
                                                                );
                                                              },
                                                              onTapped: () {
                                                                showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) =>
                                                                          Provider(
                                                                    create: (_) =>
                                                                        CartItemBloc(),
                                                                    dispose: (context,
                                                                            CartItemBloc
                                                                                bloc) =>
                                                                        bloc.dispose(),
                                                                    child:
                                                                        AddToCartDialouge(
                                                                      openingTime:
                                                                          widget
                                                                              .openingTime,
                                                                      closingTime:
                                                                          widget
                                                                              .closingTime,
                                                                      item: f,
                                                                      user: widget
                                                                          .user,
                                                                      vendorName:
                                                                          widget
                                                                              .vendorName,
                                                                      vendorID:
                                                                          widget
                                                                              .vendorID,
                                                                      minOrder:
                                                                          widget
                                                                              .minOrder,
                                                                      shouldSchedule:
                                                                          widget
                                                                              .shouldSchedule!,
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          )
                                                          .toList(),
                                                    );
                                                  case ConnectionState.done:
                                                    return const Text(
                                                        "The task has completed");
                                                }
                                              },
                                            )
                                          : Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SvgPicture.asset(
                                                    "assets/svg/empty.svg",
                                                    height: 200,
                                                    width: 200,
                                                  ),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                      top: 10,
                                                    ),
                                                    child: Text(
                                                      "",
                                                      style: GoogleFonts
                                                          .montserrat(),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                    case ConnectionState.done:
                                      return Text("The task has completed.");
                                  }
                                },
                              ),
                            ),
                          ),
                          // Expanded(
                          //   child: StreamBuilder<List<String>>(
                          //     stream: _cartMenuBloc.tags,
                          //     builder: (context, snapshot) {
                          //       if (snapshot.hasError)
                          //         return Text("Error: ${snapshot.error}");
                          //       switch (snapshot.connectionState) {
                          //         case ConnectionState.none:
                          //           return Text("Awaiting Bids....");
                          //           break;
                          //         case ConnectionState.waiting:
                          //           return Center(
                          //             child: CircularProgressIndicator(),
                          //           );
                          //           break;
                          //         case ConnectionState.active:
                          //           return CustomTabView(
                          //             itemCount: snapshot.data.length,
                          //             tabBuilder: (context, index) => Text(
                          //                 snapshot.data[index].toUpperCase()),
                          //             pageBuilder: (context, index) =>
                          //                 Provider(
                          //               create: (_) => CartMenuBloc(),
                          //               child: VendorsScreen(
                          //                 tag: snapshot.data[index],
                          //                 user: widget.user,
                          //               ),
                          //             ),
                          //           );
                          //           break;
                          //         case ConnectionState.done:
                          //           return Text("The task has completed");
                          //           break;
                          //       }
                          //       return null;
                          //     },
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
