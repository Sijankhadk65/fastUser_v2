import 'package:fast_app_v2_1/src/widgets/progress_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../bloc/order_cart_bloc.dart';
import '../models/online_order.dart';
import '../widgets/cart_list.dart';
import '../widgets/custom_tab_bar.dart';

class OrderDetailScreen extends StatefulWidget {
  final String orderRef;

  const OrderDetailScreen({
    Key? key,
    required this.orderRef,
  }) : super(key: key);

  @override
  _OrderDetailScreenState createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    orderCartBloc.getOrders(widget.orderRef);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your Order",
          style: GoogleFonts.oswald(
            fontSize: 15,
          ),
        ),
      ),
      body: StreamBuilder<List<OnlineOrder>>(
        stream: orderCartBloc.liveOrders,
        builder: (context, snapshot) {
          if (snapshot.hasError) return Text("Error: ${snapshot.error}");
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return const Text("Awaiting Bids....");
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.active:
              return Column(
                children: <Widget>[
                  Expanded(
                    child: CustomTabView(
                      itemCount: snapshot.data!.length,
                      tabBuilder: (context, index) => Column(
                        children: <Widget>[
                          Text(
                            snapshot.data![index].vendorName!,
                          ),
                          Text(
                            "Subtotal: Rs.${snapshot.data![index].totalPrice}",
                            style: GoogleFonts.nunito(
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.normal,
                              color: Colors.black38,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      pageBuilder: (context, index) => Column(
                        children: <Widget>[
                          ProgressWidget(
                            status: snapshot.data![index].status!.toList(),
                          ),
                          CartList(
                            job: "history",
                            items: snapshot.data![index].items!.toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            case ConnectionState.done:
              return const Text("The task has completed.");
          }
        },
      ),
    );
  }
}
