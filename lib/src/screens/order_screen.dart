import 'package:fast_app_v2_1/src/widgets/custom_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bloc/order_cart_bloc.dart';
import '../models/order_ref.dart';
import '../widgets/order_ref_card.dart';

class OrderScreen extends StatefulWidget {
  final Map<String, dynamic> user;

  const OrderScreen({Key? key, required this.user}) : super(key: key);
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final _screenOptions = [
    "Open",
    "Close",
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomTabView(
          itemCount: 2,
          tabBuilder: (context, index) => Text(
                _screenOptions[index],
              ),
          pageBuilder: (context, index) {
            return StreamBuilder<List<OrderRef>>(
              stream: orderCartBloc.getOrderRefs(
                widget.user,
                index == 0 ? "open" : "close",
              ),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return const Text("Awaiting Bids.....");
                  case ConnectionState.waiting:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case ConnectionState.active:
                    return snapshot.data!.isEmpty
                        ? Center(
                            child: Text(
                              "No Order have been made yet!",
                              style: GoogleFonts.pacifico(
                                fontSize: 25,
                                color: Colors.orange[600],
                              ),
                            ),
                          )
                        : ListView(
                            shrinkWrap: true,
                            children: snapshot.data!
                                .map((order) => OrderRefCard(
                                          orderRef: order,
                                        )
                                    // :
                                    // Slidable(
                                    //     actionPane: SlidableStrechActionPane(),
                                    //     actionExtentRatio: 0.25,
                                    //     child: Container(
                                    //       color: Colors.white,
                                    //       child:
                                    //     ),
                                    //     secondaryActions: <Widget>[
                                    //       IconSlideAction(
                                    //         caption: 'Delete',
                                    //         color: Colors.red,
                                    //         icon: Icons.delete,
                                    //         onTap: () {
                                    //           orderCartBloc
                                    //               .deleteOrderRef(order.refID);
                                    //         },
                                    //       ),
                                    //     ],
                                    //   ),
                                    )
                                .toList(),
                          );
                  case ConnectionState.done:
                    return Text(snapshot.data.toString());
                }
              },
            );
          }),
    );
  }
}
