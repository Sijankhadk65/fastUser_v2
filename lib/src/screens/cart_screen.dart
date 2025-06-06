import 'package:fast_app_v2_1/src/screens/checkout_screen.dart';
import 'package:fast_app_v2_1/src/widgets/app_alert.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../bloc/order_cart_bloc.dart';
import '../models/online_order.dart';
import '../widgets/cart_list.dart';
import '../widgets/custom_tab_bar.dart';

class CartScreen extends StatefulWidget {
  final String? vendor = "";
  final Map<String, dynamic>? user = const {};
  final int? minOrder = 0;
  final int? orderCartLength = 0;
  const CartScreen({
    Key? key,
    vendor,
    minOrder,
    orderCartLength,
    user,
  }) : super(key: key);
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    orderCartBloc.getCartsTotal();
    orderCartBloc.getLocalOrder();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cart",
          style: GoogleFonts.oswald(
            fontSize: 18,
          ),
        ),
      ),
      body: StreamBuilder<List<OnlineOrder?>>(
        stream: orderCartBloc.localOrder,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return const Text("Awating Bids....");
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.active:
              return snapshot.data!.isNotEmpty
                  ? Column(
                      children: <Widget>[
                        Expanded(
                          child: CustomTabView(
                            itemCount: snapshot.data!.length,
                            tabBuilder: (context, index) => Column(
                              children: <Widget>[
                                Text(
                                  snapshot.data![index]!.vendorName.toString(),
                                ),
                                Text(
                                  "Subtotal: Rs.${snapshot.data![index]!.totalPrice}",
                                  style: GoogleFonts.nunito(
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black38,
                                    fontSize: 12,
                                  ),
                                )
                              ],
                            ),
                            pageBuilder: (context, index) => CartList(
                              items: snapshot.data![index]!.items!.toList(),
                              vendor: snapshot.data![index]!.vendor.toString(),
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            AnimatedContainer(
                              duration: const Duration(
                                milliseconds: 300,
                              ),
                              margin: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 15,
                              ),
                              decoration: BoxDecoration(
                                  color: const Color(0xFF11998e),
                                  borderRadius: BorderRadius.circular(
                                    5,
                                  ),
                                  boxShadow: snapshot.data!
                                          .map(
                                            (order) {
                                              return order!.totalPrice! >=
                                                  order.minOrder!;
                                            },
                                          )
                                          .toList()
                                          .contains(
                                            false,
                                          )
                                      ? []
                                      : [
                                          const BoxShadow(
                                            color: Colors.black38,
                                            offset: Offset(
                                              0,
                                              3,
                                            ),
                                            blurRadius: 5,
                                          )
                                        ]),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: snapshot.data!
                                          .map(
                                            (order) {
                                              return order!.totalPrice! >=
                                                  order.minOrder!;
                                            },
                                          )
                                          .toList()
                                          .contains(
                                            false,
                                          )
                                      ? null
                                      : () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => CheckoutScreen(
                                                user: widget.user!,
                                              ),
                                            ),
                                          );
                                        },
                                  borderRadius: BorderRadius.circular(
                                    5,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 25,
                                      vertical: 15,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Next",
                                          style: GoogleFonts.nunito(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w800,
                                            fontSize: 17,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            snapshot.data!
                                    .map(
                                      (order) {
                                        return order!.totalPrice! >=
                                            order.minOrder!;
                                      },
                                    )
                                    .toList()
                                    .contains(
                                      false,
                                    )
                                ? AppAlert(
                                    isCollapsible: false,
                                    priority: "error",
                                    message:
                                        "You have not met the minimum amount to order for ${snapshot.data!.where((order) => order!.totalPrice! < order.minOrder!).map((order) => order!.vendorName)}.",
                                  )
                                : Container(),
                          ],
                        ),
                        // AnimatedContainer(
                        //   duration: Duration(
                        //     milliseconds: 300,
                        //   ),
                        //   height: 65,
                        //   color: snapshot.data
                        //           .map(
                        //             (order) {
                        //               return order.totalPrice >= order.minOrder;
                        //             },
                        //           )
                        //           .toList()
                        //           .contains(
                        //             false,
                        //           )
                        //       ? Colors.red[800]
                        //       : Colors.blue[800],
                        //   child: Material(
                        //     color: Colors.transparent,
                        //     child: InkWell(
                        //       onTap: snapshot.data
                        //               .map(
                        //                 (order) {
                        //                   return order.totalPrice >=
                        //                       order.minOrder;
                        //                 },
                        //               )
                        //               .toList()
                        //               .contains(
                        //                 false,
                        //               )
                        //           ? null
                        //           : () {
                        //               Navigator.push(
                        //                 context,
                        //                 MaterialPageRoute(
                        //                   builder: (_) => CheckoutScreen(
                        //                     user: widget.user,
                        //                   ),
                        //                 ),
                        //               );
                        //             },
                        //       child: Padding(
                        //         padding: const EdgeInsets.all(10.0),
                        //         child: Column(
                        //           children: <Widget>[
                        //             Expanded(
                        //               child: AnimatedContainer(
                        //                 duration: Duration(
                        //                   milliseconds: 300,
                        //                 ),
                        //                 child: Center(
                        //                   child: StreamBuilder(
                        //                     stream: orderCartBloc.cartsTotal,
                        //                     builder: (context, snapshot) {
                        //                       return Text(
                        //                         "Total Cost (Rs.${snapshot.data})",
                        //                         style: GoogleFonts.montserrat(
                        //                           fontWeight: FontWeight.w600,
                        //                           color: Colors.white,
                        //                           fontSize: 18,
                        //                         ),
                        //                       );
                        //                     },
                        //                   ),
                        //                 ),
                        //               ),
                        //             ),
                        //             snapshot.data
                        //                     .map(
                        //                       (order) {
                        //                         return order.totalPrice >=
                        //                             order.minOrder;
                        //                       },
                        //                     )
                        //                     .toList()
                        //                     .contains(false)
                        //                 ? Expanded(
                        //                     child: AnimatedContainer(
                        //                       duration: Duration(
                        //                         milliseconds: 300,
                        //                       ),
                        //                       child: Text(
                        //                         "Minimum Order Not ${snapshot.data.where((order) => order.minOrder > order.totalPrice).toList().map((faultyOrder) => faultyOrder.vendor)} Met !",
                        //                         style: GoogleFonts.montserrat(
                        //                           fontStyle: FontStyle.italic,
                        //                           color: Colors.white38,
                        //                           fontSize: 12,
                        //                         ),
                        //                       ),
                        //                     ),
                        //                   )
                        //                 : Container(),
                        //           ],
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // )
                      ],
                    )
                  : Center(
                      child: Text(
                        "No orders in the cart yet, check the order section if any orders were placed.",
                        style: GoogleFonts.oswald(),
                      ),
                    );
            case ConnectionState.done:
              return const Text("The task has completed");
          }
        },
      ),
    );
  }
}
