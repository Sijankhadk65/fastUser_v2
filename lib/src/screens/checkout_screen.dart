import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:day_night_time_picker/lib/constants.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:fast_app_v2_1/src/bloc/order_cart_bloc.dart';
import 'package:fast_app_v2_1/src/models/online_order.dart';
import 'package:fast_app_v2_1/src/widgets/app_alert.dart';
import 'package:fast_app_v2_1/src/widgets/changable_displayer.dart';
import 'package:fast_app_v2_1/src/widgets/checkout_cart_list.dart';
import 'package:fast_app_v2_1/src/widgets/delivery_location_selector.dart';
import 'package:fast_app_v2_1/src/widgets/order_bottom_sheet.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlng/latlng.dart';
import 'package:place_picker/entities/entities.dart';
import 'package:place_picker/place_picker.dart';

import 'change_phone_number_dialog.dart';

class CheckoutScreen extends StatefulWidget {
  final Map<String, dynamic> user;

  const CheckoutScreen({
    Key? key,
    required this.user,
  }) : super(key: key);
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  late TextEditingController _phoneNumberController;
  String _newNumber = "";
  late LocationResult _result;

  _changeNewNumber(number) {
    setState(() {
      _newNumber = number;
    });
  }

  @override
  void initState() {
    _phoneNumberController = TextEditingController();
    orderCartBloc.changeUserPhoneNumber(widget.user['phoneNumber'].toString());
    _phoneNumberController.text = widget.user['phoneNumber'].toString();
    orderCartBloc.getCheckoutLocation({});
    super.initState();
  }

  @override
  void dispose() {
    orderCartBloc.changePromoCodesMessage({});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    orderCartBloc.getLocalOrder();
    orderCartBloc.getCartsTotal();
    orderCartBloc.getDeliveryCharge();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Checkout"),
      ),
      body: StreamBuilder<bool>(
        stream: orderCartBloc.checkedOut,
        builder: (context, snapshot) {
          return snapshot.data == true
              ? Center(
                  child: Column(
                    children: <Widget>[
                      const Expanded(
                        flex: 4,
                        child: FlareActor(
                          "assets/flare/check.flr",
                          animation: "check",
                          alignment: Alignment.center,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text(
                        "Your Order has been placed, go to the order section to check it out.",
                        style: GoogleFonts.oswald(),
                      ),
                      RawMaterialButton(
                        onPressed: () {
                          showBottomSheet(
                            context: context,
                            builder: (context) => OrderBottomSheet(),
                          );
                        },
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            5,
                          ),
                        ),
                        child: Text(
                          "Look at your orders",
                          style: GoogleFonts.nunito(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        fillColor: Colors.orange[800],
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(),
                      ),
                    ],
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "${widget.user['name']}",
                            style: GoogleFonts.montserrat(
                              fontSize: 23,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          StreamBuilder<String>(
                            stream: orderCartBloc.userPhoneNumber,
                            builder: (context, snapshot) {
                              return ChangableDisplayer(
                                primaryText: snapshot.data.toString(),
                                secondaryText: " ( change phone number ) ",
                                displayChanger: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) =>
                                        ChangePhoneNumberDialog(
                                      phoneNumberController:
                                          _phoneNumberController,
                                      onPhoneNumberChanged: _changeNewNumber,
                                      onChangePressed: () {
                                        orderCartBloc
                                            .changeUserPhoneNumber(_newNumber);
                                        Navigator.pop(context);
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                          StreamBuilder<bool>(
                            initialData: false,
                            stream: orderCartBloc.isScheduled,
                            builder: (context, snapshot) {
                              return snapshot.data!
                                  ? StreamBuilder<String>(
                                      initialData: "",
                                      stream: orderCartBloc.scheduledTime,
                                      builder: (context, snapshot) {
                                        DateTime date =
                                            DateTime.parse(snapshot.data!);
                                        return ChangableDisplayer(
                                          primaryText:
                                              "${date.year}/${date.month}/${date.day} at ${date.hour}:${date.minute}",
                                          secondaryText:
                                              "( change date or time )",
                                          displayChanger: () {
                                            // Navigator.push(
                                            //   context,
                                            //   showPicker(
                                            //     value: TimeOfDay.now(),
                                            //     onChange: (value) {
                                            //       DateTime _time = DateTime.now();
                                            //       orderCartBloc
                                            //           .changeScheduledTime(
                                            //         "${_time.year}-T${}",
                                            //       );
                                            //     },
                                            //     minuteInterval:
                                            //         MinuteInterval.FIVE,
                                            //     disableHour: false,
                                            //     disableMinute: false,
                                            //     minMinute: 7,
                                            //     maxMinute: 56,
                                            //   ),
                                            // );
                                            // DatePicker.showDateTimePicker(
                                            //     context,
                                            //     showTitleActions: true,
                                            //     minTime: DateTime(2018, 3, 5),
                                            //     maxTime: DateTime(2019, 6, 7),
                                            //     onChanged: (date) {
                                            //   orderCartBloc.changeScheduledTime(
                                            //     date.toIso8601String(),
                                            //   );
                                            // }, onConfirm: (date) {
                                            //   orderCartBloc
                                            //       .changeSchedulingStatus(true);
                                            // },
                                            //     currentTime: DateTime.now(),
                                            //     locale: LocaleType.en);
                                          },
                                        );
                                      },
                                    )
                                  : RawMaterialButton(
                                      onPressed: () {
                                        // Navigator.push(
                                        //   context,
                                        //   showPicker(
                                        //     value: TimeOfDay.now(),
                                        //     onChange: (value) {
                                        //       orderCartBloc.changeScheduledTime(
                                        //         date.toIso8601String(),
                                        //       );
                                        //     },
                                        //     minuteInterval: MinuteInterval.FIVE,
                                        //     disableHour: false,
                                        //     disableMinute: false,
                                        //     minMinute: 7,
                                        //     maxMinute: 56,
                                        //   ),
                                        // );
                                        // DatePicker.showDateTimePicker(
                                        //   context,
                                        //   showTitleActions: true,
                                        //   minTime: DateTime(2018, 3, 5),
                                        //   maxTime: DateTime(2019, 6, 7),
                                        //   onChanged: (date) {
                                        //     orderCartBloc.changeScheduledTime(
                                        //       date.toIso8601String(),
                                        //     );
                                        //   },
                                        //   onConfirm: (date) {
                                        //     orderCartBloc
                                        //         .changeSchedulingStatus(true);
                                        //   },
                                        //   currentTime: DateTime.now(),
                                        //   locale: LocaleType.en,
                                        // );
                                      },
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          5,
                                        ),
                                      ),
                                      padding: const EdgeInsets.only(
                                        left: 5,
                                        right: 5,
                                      ),
                                      child: Text(
                                        "Schedule for later",
                                        style: GoogleFonts.nunito(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      fillColor: Colors.orange[800],
                                    );
                            },
                          ),
                          DeliveryLocationSelector(
                            user: widget.user,
                            setCheckoutLocation:
                                orderCartBloc.getCheckoutLocation,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: StreamBuilder<List<OnlineOrder?>>(
                        stream: orderCartBloc.localOrder,
                        builder: (context, snapshot) {
                          return snapshot.hasData
                              ? Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: CheckoutCartList(
                                    orders: snapshot.data!.toList(),
                                  ),
                                )
                              : const Text("No data");
                        },
                      ),
                    ),
                    // This is for applying promo code.
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(
                                right: 10,
                              ),
                              child: Material(
                                elevation: 5,
                                borderRadius: BorderRadius.circular(
                                  5,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 10,
                                    right: 10,
                                  ),
                                  child: StreamBuilder<String>(
                                      stream: orderCartBloc.promoCode,
                                      builder: (context, snapshot) {
                                        return TextField(
                                          onChanged:
                                              orderCartBloc.changePromoCode,
                                          decoration: InputDecoration(
                                            hintText:
                                                "Enter the promo code here...",
                                            hintStyle: GoogleFonts.nunito(
                                              fontStyle: FontStyle.italic,
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              ),
                            ),
                          ),
                          RawMaterialButton(
                            fillColor: Colors.blue[800],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                5,
                              ),
                            ),
                            onPressed: () {
                              orderCartBloc
                                  .applyPromoCode(widget.user['email']);
                            },
                            child: Text(
                              "Apply Code",
                              style: GoogleFonts.nunito(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          // StreamBuilder<bool>(
                          //   stream: orderCartBloc.promoCodeIsUsed,
                          //   builder: (context, snapshot) {
                          //     if (snapshot.hasError)
                          //       return Text("Error: ${snapshot.error}");
                          //     switch (snapshot.connectionState) {
                          //       case ConnectionState.none:
                          //         return Text("Awaiting bids....");
                          //         break;
                          //       case ConnectionState.waiting:
                          //         return Center(
                          //             child: CircularProgressIndicator());
                          //         break;
                          //       case ConnectionState.active:
                          //         return RawMaterialButton(
                          //           fillColor: snapshot.data
                          //               ? Colors.grey
                          //               : Colors.blue[800],
                          //           shape: RoundedRectangleBorder(
                          //             borderRadius: BorderRadius.circular(
                          //               5,
                          //             ),
                          //           ),
                          //           onPressed: () {
                          //             orderCartBloc.applyPromoCode(
                          //                 widget.user['email']);
                          //           },
                          //           child: Text(
                          //             "Apply Code",
                          //             style: GoogleFonts.nunito(
                          //               color: Colors.black26,
                          //             ),
                          //           ),
                          //         );
                          //         break;
                          //       case ConnectionState.done:
                          //         return Text("The task has completed");
                          //         break;
                          //     }
                          //   },
                          // ),
                        ],
                      ),
                    ),
                    StreamBuilder<Map<String, dynamic>>(
                      initialData: const {},
                      stream: orderCartBloc.promoCodeMessage,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text(
                            "Error:${snapshot.error}",
                          );
                        }
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                            return const Text("Awaiting Bids....");
                          case ConnectionState.waiting:
                            return const Center(
                              child: LinearProgressIndicator(),
                            );
                          case ConnectionState.active:
                            return snapshot.hasData
                                ? AppAlert(
                                    message: snapshot.data!['message']!,
                                    priority: snapshot.data!['priority'],
                                    onCollapse: () {
                                      orderCartBloc.changePromoCodesMessage({});
                                    },
                                  )
                                : Container();
                          case ConnectionState.done:
                            return const Text("The task has completed.");
                        }
                      },
                    ),
                    // This is for displaying if the code is applied or not.
                    // StreamBuilder<bool>(
                    //   stream: orderCartBloc.promoCodeIsUsed,
                    //   builder: (context, snapshot) {
                    //     if (snapshot.hasError)
                    //       return Text("Error: ${snapshot.error}");
                    //     switch (snapshot.connectionState) {
                    //       case ConnectionState.none:
                    //         return Text("Awaiting Bids...");
                    //         break;
                    //       case ConnectionState.waiting:
                    //         return Center(
                    //           child: CircularProgressIndicator(),
                    //         );
                    //         break;
                    //       case ConnectionState.active:
                    //         return snapshot.data
                    //             ? Text(
                    //                 "You have used a promo code!",
                    //                 style: GoogleFonts.nunito(
                    //                   color: Colors.green,
                    //                   fontStyle: FontStyle.italic,
                    //                   fontWeight: FontWeight.bold,
                    //                 ),
                    //               )
                    //             : Container();
                    //         break;
                    //       case ConnectionState.done:
                    //         return Text("The task has completed");
                    //         break;
                    //     }
                    //     return null;
                    //   },
                    // ),

                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF6A8C),
                        borderRadius: BorderRadius.circular(
                          5,
                        ),
                      ),
                      margin: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () async {
                            _result = await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => PlacePicker(
                                    "AIzaSyATdr7r2cCqiNWcgv9VQSYKf7k50Qzx7IY"),
                              ),
                            );
                            // await Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => PlacePicker(
                            //       apiKey:
                            //           "AIzaSyATdr7r2cCqiNWcgv9VQSYKf7k50Qzx7IY",
                            //       onPlacePicked: (result) {
                            //         setState(
                            //           () {
                            //             _result = result;
                            //           },
                            //         );
                            //         Navigator.of(context).pop();
                            //       },
                            //       useCurrentLocation: true,
                            //       initialPosition: ,
                            //     ),
                            //   ),
                            // );
                            orderCartBloc.getCheckoutLocation(
                              {
                                "coordinates": {
                                  "lat": _result.latLng!.latitude,
                                  "lang": _result.latLng!.longitude,
                                },
                                "physicalLocation": _result.formattedAddress,
                              },
                            );
                            orderCartBloc.getDeliveryCharge();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 10,
                            ),
                            child: Column(
                              children: [
                                StreamBuilder<String?>(
                                  stream:
                                      orderCartBloc.checkoutPhysicalLocation,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) {
                                      return Text("Error: ${snapshot.error}");
                                    }
                                    switch (snapshot.connectionState) {
                                      case ConnectionState.none:
                                        return const Text("Awaiting Bids...");
                                      case ConnectionState.waiting:
                                        return const Center(
                                          child: LinearProgressIndicator(),
                                        );
                                      case ConnectionState.active:
                                        return Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Delivery Address",
                                                    style: GoogleFonts.nunito(
                                                      fontSize: 25,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Text(
                                                    snapshot.data.toString(),
                                                    style: GoogleFonts.nunito(
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                      case ConnectionState.done:
                                        return const Text(
                                            "The task has completed");
                                    }
                                  },
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                    bottom: 10,
                                  ),
                                  child: const DottedLine(
                                    dashColor: Colors.white24,
                                    lineThickness: 2,
                                    dashRadius: 5,
                                  ),
                                ),
                                StreamBuilder<double>(
                                  stream: orderCartBloc.cartsTotal,
                                  builder: (context, totalAmount) {
                                    if (totalAmount.hasError) {
                                      return Text(
                                          "Error: ${totalAmount.error}");
                                    }
                                    switch (totalAmount.connectionState) {
                                      case ConnectionState.none:
                                        return const Text("Awaiting bids....");
                                      case ConnectionState.waiting:
                                        return const LinearProgressIndicator();
                                      case ConnectionState.active:
                                        return StreamBuilder<double>(
                                          stream: orderCartBloc.deliveryCharge,
                                          builder: (context, snapshot) {
                                            if (snapshot.hasError) {
                                              return (Text(
                                                  "Error: ${snapshot.error}"));
                                            }
                                            switch (snapshot.connectionState) {
                                              case ConnectionState.none:
                                                return const Text(
                                                    "Awaiting bids....");
                                              case ConnectionState.waiting:
                                                return const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              case ConnectionState.active:
                                                return Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            "Delivery Charge",
                                                            style: GoogleFonts
                                                                .nunito(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800,
                                                              fontSize: 16,
                                                              color:
                                                                  const Color(
                                                                0xFFAB304C,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          "Rs.${snapshot.data!.toStringAsFixed(2)}",
                                                          style: GoogleFonts
                                                              .nunito(
                                                            fontWeight:
                                                                FontWeight.w800,
                                                            // fontSize: 18,
                                                            color: const Color(
                                                              0xFFAB304C,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: Text(
                                                            "Total",
                                                            style: GoogleFonts
                                                                .nunito(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800,
                                                              fontSize: 16,
                                                              color:
                                                                  const Color(
                                                                0xFFAB304C,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          "Rs.${double.parse((snapshot.data! + totalAmount.data!).toStringAsFixed(2))}",
                                                          style: GoogleFonts
                                                              .nunito(
                                                            fontWeight:
                                                                FontWeight.w800,
                                                            // fontSize: 18,
                                                            color: const Color(
                                                              0xFFAB304C,
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                );
                                              case ConnectionState.done:
                                                return const Text(
                                                    "The task has completed.");
                                            }
                                          },
                                        );
                                      case ConnectionState.done:
                                        return const Text(
                                            "The task has completed");
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF11998e),
                        borderRadius: BorderRadius.circular(
                          5,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black38,
                            offset: Offset(
                              0,
                              5,
                            ),
                            blurRadius: 5,
                          )
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            orderCartBloc.changeTransactionStatus(true);
                            orderCartBloc
                                .saveOrder(
                              widget.user,
                            )
                                .whenComplete(
                              () {
                                orderCartBloc.changeTransactionStatus(false);
                                orderCartBloc.changeCheckoutStatus(true);
                              },
                            );
                          },
                          child: Center(
                            child: StreamBuilder<bool>(
                              initialData: false,
                              stream: orderCartBloc.transactionStatus,
                              builder: (context, snapshot) {
                                return snapshot.data!
                                    ? const CircularProgressIndicator(
                                        backgroundColor: Colors.green,
                                      )
                                    : Text(
                                        "Check Out!",
                                        style: GoogleFonts.oswald(
                                          color: Colors.white,
                                          fontSize: 25,
                                        ),
                                      );
                              },
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                );
        },
      ),
    );
  }
}
