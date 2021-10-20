import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fast_app_v2_1/src/bloc/bakeries_bloc.dart';
import 'package:fast_app_v2_1/src/bloc/cart_item_bloc.dart';
import 'package:fast_app_v2_1/src/bloc/cart_menu_bloc.dart';
import 'package:fast_app_v2_1/src/bloc/dash_bloc.dart';
import 'package:fast_app_v2_1/src/bloc/liquor_bloc.dart';
import 'package:fast_app_v2_1/src/bloc/offers_bloc.dart';
import 'package:fast_app_v2_1/src/models/carousel_item.dart';
import 'package:fast_app_v2_1/src/models/community_item.dart';
import 'package:fast_app_v2_1/src/models/item.dart';
import 'package:fast_app_v2_1/src/screens/bakeries_screen.dart';
import 'package:fast_app_v2_1/src/screens/coming_soon_screen.dart';
import 'package:fast_app_v2_1/src/screens/favourites_screen.dart';
import 'package:fast_app_v2_1/src/screens/liquor_screen.dart';
import 'package:fast_app_v2_1/src/screens/offers_screen.dart';
import 'package:fast_app_v2_1/src/screens/quick_access_screen.dart';
import 'package:fast_app_v2_1/src/screens/vendor_list_screen.dart';
import 'package:fast_app_v2_1/src/widgets/add_to_cart_dialouge.dart';
import 'package:fast_app_v2_1/src/widgets/categories_card.dart';
import 'package:fast_app_v2_1/src/widgets/community_card.dart';
import 'package:fast_app_v2_1/src/widgets/quick_access_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DashScreen extends StatefulWidget {
  final Map<String, dynamic> user;

  const DashScreen({Key? key, required this.user}) : super(key: key);
  @override
  _DashScreenState createState() => _DashScreenState();
}

class _DashScreenState extends State<DashScreen> {
  late DashBloc _dashBloc;
  late CartMenuBloc _cartMenuBloc;

  @override
  void didChangeDependencies() {
    _dashBloc = Provider.of<DashBloc>(context);
    _cartMenuBloc = Provider.of<CartMenuBloc>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _cartMenuBloc.getTags();
    _dashBloc.getFeaturedVendor();
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(
              top: 15,
              bottom: 5,
            ),
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              childAspectRatio: 16 / 6,
              children: <Widget>[
                CategoriesCard(
                  assetPath: "assets/svg/cafe.svg",
                  category: "Restaurants",
                  message: "A curated list of resturants near you.",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Provider(
                          create: (_) => CartMenuBloc(),
                          child: VendorListScreen(
                            user: widget.user,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                CategoriesCard(
                  assetPath: "assets/svg/bakery-shop.svg",
                  category: "Cakes and Bakeries",
                  message: "A selection of the best bakeries for you.",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MultiProvider(
                          providers: [
                            Provider(
                              create: (_) => BakeriesBloc(),
                            ),
                            Provider(
                              create: (_) => CartMenuBloc(),
                            ),
                          ],
                          child: BakeriesScreen(
                            user: widget.user,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                CategoriesCard(
                  assetPath: "assets/svg/liquor.svg",
                  category: "Liquors",
                  message: "Satisfy your thirst the FAST way.",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MultiProvider(
                          providers: [
                            Provider(
                              create: (_) => LiquorBloc(),
                            ),
                            Provider(
                              create: (_) => CartMenuBloc(),
                            ),
                          ],
                          child: LiquorScreen(
                            user: widget.user,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                CategoriesCard(
                  assetPath: "assets/svg/supermarket.svg",
                  category: "Groceries",
                  message: "Your one stop for all your groceries.",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ComingSoon(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          StreamBuilder<List<CarouselItem>>(
            stream: _dashBloc.getCarouselItems(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text("Error:${snapshot.error}"));
              }
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return const Text("Awaiting Bids....");
                case ConnectionState.waiting:
                  return const Center(
                    child: Center(child: CircularProgressIndicator()),
                  );
                case ConnectionState.active:
                  return CarouselSlider.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index1, index2) =>
                        CachedNetworkImage(
                      imageUrl: snapshot.data![index1].photoURI.toString(),
                      progressIndicatorBuilder: (context, msg, progress) =>
                          const Center(
                        child: CircularProgressIndicator(),
                      ),
                      imageBuilder: (context, imageProvider) => Container(
                        margin: EdgeInsets.only(
                          bottom: 5,
                          left: 10,
                          right: 10,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            5,
                          ),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(
                              5,
                            ),
                            onTap: snapshot.data![index1].isInteractive!
                                ? () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => Provider(
                                        create: (_) => CartItemBloc(),
                                        child: StreamBuilder<MenuItem>(
                                          stream: _cartMenuBloc.getMenuItem(
                                              snapshot.data![index1].itemCode!),
                                          builder: (context, itemSnapshot) {
                                            if (itemSnapshot.hasError) {
                                              return Center(
                                                child: Text(
                                                    "Error:${itemSnapshot.error}"),
                                              );
                                            }
                                            switch (
                                                itemSnapshot.connectionState) {
                                              case ConnectionState.none:
                                                return const Text(
                                                    "awaiting bids....");
                                              case ConnectionState.waiting:
                                                return const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              case ConnectionState.active:
                                                return AddToCartDialouge(
                                                  item: itemSnapshot.data,
                                                  minOrder: snapshot
                                                      .data![index1].minOrder!,
                                                  vendorName: snapshot
                                                      .data![index1]
                                                      .vendorName!,
                                                  user: widget.user,
                                                );
                                              case ConnectionState.done:
                                                return const Text(
                                                  "The task has completed",
                                                );
                                            }
                                          },
                                        ),
                                      ),
                                    );
                                  }
                                : () {},
                          ),
                        ),
                      ),
                      errorWidget: (context, msg, error) => Container(
                        margin: const EdgeInsets.only(
                          top: 5,
                          bottom: 5,
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                      ),
                    ),
                    options: CarouselOptions(
                      aspectRatio: 16 / 9,
                      viewportFraction: 1,
                      initialPage: 0,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                    ),
                  );
                case ConnectionState.done:
                  return const Text("The task has completed");
              }
            },
          ),
          Container(
            height: 80,
            width: double.infinity,
            margin: EdgeInsets.only(
              top: 10,
              bottom: 10,
            ),
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(
                bottom: 5,
              ),
              shrinkWrap: true,
              children: <Widget>[
                QuickAccessCard(
                  title: "Most Searched",
                  description: "All the popular resturants",
                  assetPath: "assets/svg/food-delivery.svg",
                  lightColor: Color(0xFFffa8cf),
                  darkColor: Color(0xFFD76E9B),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Provider(
                          create: (_) => CartMenuBloc(),
                          child: FavouriteScren(
                            user: widget.user,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                QuickAccessCard(
                  title: "Favourites",
                  description:
                      "Your favourite resturants and food all in one place",
                  assetPath: "assets/svg/wishlist.svg",
                  lightColor: Color(0xFFfd747f),
                  darkColor: Color(0xFFD53A4B),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Provider(
                          create: (_) => CartMenuBloc(),
                          child: FavouriteScren(
                            user: widget.user,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                QuickAccessCard(
                  title: "Veg Food",
                  description: "Vegeterians don't worry we got you covered.",
                  assetPath: "assets/svg/diet.svg",
                  lightColor: Color(0xFF89c947),
                  darkColor: Color(0xFF618F13),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Provider(
                          create: (_) => CartMenuBloc(),
                          child: QuickAccessScreen(
                            type: "veg",
                            user: widget.user,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                QuickAccessCard(
                  title: "Halal Food",
                  description:
                      "A curated list of resturant and food that are halal certified.",
                  assetPath: "assets/svg/halal.svg",
                  lightColor: Color(0xFF6ed5a1),
                  darkColor: Color(0xFF469B6D),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Provider(
                          create: (_) => CartMenuBloc(),
                          child: QuickAccessScreen(
                            type: "halal",
                            user: widget.user,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                QuickAccessCard(
                  title: "Offers",
                  description: "Checkout these offers that we have for you.",
                  assetPath: "assets/svg/discount.svg",
                  lightColor: Color(0xFFdd636e),
                  darkColor: Color(0xFFB5293A),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Provider(
                          create: (_) => OffersBloc(),
                          child: OffersScreen(),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.orange,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  child: Text(
                    "The Community",
                    style: GoogleFonts.nunito(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                StreamBuilder<List<CommunityItem>>(
                  stream: _dashBloc.getCommunityItems(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text("Error:${snapshot.error}"));
                    }
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return const Text("Awaiting Bids....");
                      case ConnectionState.waiting:
                        return const Center(
                          child: Center(child: CircularProgressIndicator()),
                        );
                      case ConnectionState.active:
                        return CarouselSlider.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index1, index2) =>
                              CachedNetworkImage(
                            imageUrl:
                                snapshot.data![index1].photoURI.toString(),
                            progressIndicatorBuilder:
                                (context, msg, progress) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            imageBuilder: (context, imageProvider) => Container(
                              margin: EdgeInsets.only(
                                bottom: 10,
                                left: 15,
                                right: 15,
                              ),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black54,
                                    blurRadius: 10,
                                    offset: Offset(3, 3),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(
                                  5,
                                ),
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  Container(
                                    height: 170,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(
                                          5,
                                        ),
                                        bottomRight: Radius.circular(
                                          5,
                                        ),
                                      ),
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.black,
                                          Colors.black.withAlpha(220),
                                          Colors.black.withAlpha(190),
                                          Colors.black.withAlpha(160),
                                          Colors.black.withAlpha(110),
                                          Colors.black.withAlpha(80),
                                          Colors.black.withAlpha(50),
                                          Colors.transparent,
                                        ],
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 5,
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                snapshot.data![index1].title!,
                                                style: GoogleFonts.nunito(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 25,
                                                ),
                                              ),
                                              Text(
                                                snapshot
                                                    .data![index1].description!,
                                                style: GoogleFonts.nunito(
                                                  color: Colors.white70,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 15,
                                                ),
                                                maxLines: 4,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              ElevatedButton(
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateColor
                                                          .resolveWith(
                                                    (states) => Colors.white,
                                                  ),
                                                ),
                                                onPressed: () {},
                                                child: Text(
                                                  "Visit",
                                                  style: GoogleFonts.nunito(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            errorWidget: (context, msg, error) => Container(
                              margin: const EdgeInsets.only(
                                top: 5,
                                bottom: 5,
                              ),
                              decoration: const BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                            ),
                          ),
                          options: CarouselOptions(
                            height: 450,
                            viewportFraction: 1,
                            initialPage: 0,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 3),
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            scrollDirection: Axis.horizontal,
                          ),
                        );
                      case ConnectionState.done:
                        return const Text("The task has completed");
                    }
                  },
                ),
              ],
            ),
          ),

          StreamBuilder<List<CommunityItem>>(
              stream: _dashBloc.getCommunityItems(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return const Text("Awaiting Bids....");
                  case ConnectionState.waiting:
                    return const Center(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  default:
                    break;
                }
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    height: 120,
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          height: 150,
                          margin: const EdgeInsets.only(),
                          child: CommunityCard(
                            title: snapshot.data![index].title!,
                            communityItem: snapshot.data![index],
                            description: "The provide awesome thing",
                            assetPath: snapshot.data![index].photoURI!,
                            user: widget.user,
                          ),
                        );
                      },
                    ),
                  ),
                );
              }),

          // Container(
          //   margin: EdgeInsets.only(
          //     top: 10,
          //   ),
          //   decoration: BoxDecoration(
          //     gradient: LinearGradient(
          //       begin: Alignment.topLeft,
          //       end: Alignment.bottomRight,
          //       colors: [
          //         Colors.orange[300],
          //         Colors.orange[900],
          //       ],
          //     ),
          //   ),
          //   child: StreamBuilder<Vendor>(
          //     stream: _dashBloc.featuredVendor,
          //     builder: (context, featuredVendorSnapshot) {
          //       if (featuredVendorSnapshot.hasError)
          //         return Text("Error: ${featuredVendorSnapshot.error}");
          //       switch (featuredVendorSnapshot.connectionState) {
          //         case ConnectionState.none:
          //           return Text("Awaiting Bids...");
          //           break;
          //         case ConnectionState.waiting:
          //           return Center(
          //             child: CircularProgressIndicator(),
          //           );
          //           break;
          //         case ConnectionState.active:
          //           return Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Container(
          //                 decoration: BoxDecoration(
          //                   gradient: LinearGradient(
          //                     begin: Alignment.topLeft,
          //                     end: Alignment.bottomRight,
          //                     colors: [
          //                       Colors.white.withAlpha(
          //                         100,
          //                       ),
          //                       Colors.white.withAlpha(
          //                         50,
          //                       ),
          //                       Colors.white.withAlpha(
          //                         20,
          //                       ),
          //                     ],
          //                   ),
          //                   borderRadius: BorderRadius.only(
          //                     bottomLeft: Radius.circular(
          //                       55,
          //                     ),
          //                   ),
          //                 ),
          //                 padding: EdgeInsets.all(
          //                   20,
          //                 ),
          //                 child: Row(
          //                   children: [
          //                     Column(
          //                       crossAxisAlignment: CrossAxisAlignment.start,
          //                       children: [
          //                         Container(
          //                           margin: EdgeInsets.only(
          //                             left: 25,
          //                           ),
          //                           child: Text(
          //                             "Pick of the week!",
          //                             style: GoogleFonts.oswald(
          //                               fontSize: 15,
          //                               color: Colors.orange,
          //                               fontStyle: FontStyle.italic,
          //                             ),
          //                           ),
          //                         ),
          //                         Container(
          //                           margin: EdgeInsets.only(
          //                             left: 15,
          //                           ),
          //                           child: Text(
          //                             featuredVendorSnapshot.data.name
          //                                 .toUpperCase(),
          //                             style: GoogleFonts.oswald(
          //                               fontSize: 25,
          //                               fontWeight: FontWeight.w700,
          //                               color: Colors.white,
          //                               fontStyle: FontStyle.italic,
          //                             ),
          //                           ),
          //                         ),
          //                         Container(
          //                           margin: EdgeInsets.only(
          //                             left: 15,
          //                           ),
          //                           child: Material(
          //                             // elevation: 10,
          //                             color: Colors.orange[300],
          //                             borderRadius: BorderRadius.circular(
          //                               5,
          //                             ),
          //                             child: Padding(
          //                               padding: EdgeInsets.symmetric(
          //                                 horizontal: 10,
          //                                 vertical: 5,
          //                               ),
          //                               child: Text(
          //                                 "Rating: ${featuredVendorSnapshot.data.averageRating}",
          //                                 style: GoogleFonts.nunito(
          //                                   color: Colors.white,
          //                                   fontWeight: FontWeight.w800,
          //                                 ),
          //                               ),
          //                             ),
          //                           ),
          //                         )
          //                       ],
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //               StreamBuilder<List<MenuItem>>(
          //                 stream: _dashBloc.getFeaturedMenuItems(
          //                   featuredVendorSnapshot.data.id,
          //                 ),
          //                 builder: (context, snapshot) {
          //                   if (snapshot.hasError)
          //                     return Text("Error: ${snapshot.error}");
          //                   switch (snapshot.connectionState) {
          //                     case ConnectionState.none:
          //                       return Text("Awaiting Bids...");
          //                       break;
          //                     case ConnectionState.waiting:
          //                       return Center(
          //                         child: CircularProgressIndicator(),
          //                       );
          //                       break;
          //                     case ConnectionState.active:
          //                       return SizedBox(
          //                         height: 230,
          //                         child: ListView(
          //                           padding: EdgeInsets.only(
          //                             left: 10,
          //                             top: 10,
          //                             bottom: 15,
          //                           ),
          //                           scrollDirection: Axis.horizontal,
          //                           shrinkWrap: true,
          //                           children: snapshot.data
          //                               .map(
          //                                 (item) => FeaturedItemCard(
          //                                   item: item,
          //                                   minOrder: featuredVendorSnapshot
          //                                       .data.minOrder,
          //                                   vendorName: featuredVendorSnapshot
          //                                       .data.name,
          //                                   user: widget.user,
          //                                   addToCart: () => showDialog(
          //                                     context: context,
          //                                     builder: (context) => Provider(
          //                                       create: (_) => CartItemBloc(),
          //                                       dispose: (context,
          //                                               CartItemBloc bloc) =>
          //                                           bloc.dispose(),
          //                                       child: AddToCartDialouge(
          //                                         item: item,
          //                                         minOrder:
          //                                             featuredVendorSnapshot
          //                                                 .data.minOrder,
          //                                         vendorName:
          //                                             featuredVendorSnapshot
          //                                                 .data.name,
          //                                         user: widget.user,
          //                                       ),
          //                                     ),
          //                                   ),
          //                                 ),
          //                               )
          //                               .toList(),
          //                         ),
          //                       );
          //                       break;
          //                     case ConnectionState.done:
          //                       return Container();
          //                       break;
          //                   }
          //                   return Container();
          //                 },
          //               ),
          //             ],
          //           );
          //           break;
          //         case ConnectionState.done:
          //           return Text("The task has completed");
          //           break;
          //       }
          //       return Container();
          //     },
          //   ),
          // )
        ],
      ),
    );
  }
}
