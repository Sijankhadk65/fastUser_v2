import 'dart:io';
import 'package:fast_app_v2_1/src/bloc/dash_bloc.dart';
import 'package:fast_app_v2_1/src/bloc/search_bloc.dart';
import 'package:fast_app_v2_1/src/models/online_order.dart';
import 'package:fast_app_v2_1/src/widgets/food_search_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import '../bloc/cart_bloc.dart';
import '../bloc/cart_menu_bloc.dart';
import '../bloc/login_bloc.dart';
import '../bloc/order_cart_bloc.dart';
import '../screens/profile_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

import './order_screen.dart';
import 'cart_screen.dart';
import 'dash_screen.dart';

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  if (message.containsKey('data')) {
    final dynamic data = message['data'];
  }
  if (message.containsKey('notification')) {
    final dynamic notification = message['notification'];
  }
}

class HomeScreen extends StatefulWidget {
  final Map<String, dynamic> user;

  const HomeScreen({Key? key, required this.user}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int _currentPageIndex = 0;

  _changeCurrentPage(int page) {
    setState(() {
      _currentPageIndex = page;
    });
  }

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  _configureLocalNotification() {
    var _initializationSettings = const InitializationSettings();
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _flutterLocalNotificationsPlugin.initialize(
      _initializationSettings,
      onSelectNotification: (value) {
        return Future.value(value);
      },
    );
  }

  _configureFCM() {
    if (Platform.isIOS) {
      _firebaseMessaging.requestPermission();
    }
    // _firebaseMessaging.configure(
    //   onMessage: (Map<String, dynamic> message) async {
    //     // _sendNotification();
    //   },
    //   // onBackgroundMessage: myBackgroundMessageHandler,
    //   onLaunch: (Map<String, dynamic> message) async {
    //     // _sendNotification();
    //   },
    //   onResume: (Map<String, dynamic> message) async {
    //     // _sendNotification();
    //   },
    // );
  }

  Future _sendNotification() async {
    // var androidDetails = new AndroidNotificationDetails(
    //     "Channel ID", "iCAN BMTS", "This is our channel",
    //     playSound: true, importance: Importance.max);
    // var iSODetails = new IOSNotificationDetails();
    var generalNotificationDetails = const NotificationDetails();

    await _flutterLocalNotificationsPlugin.show(
        0, "Task", "You created a Task", generalNotificationDetails,
        payload: "Task");
  }

  late PageController _pageController;
  late CartMenuBloc _cartMenuBloc;

  @override
  void initState() {
    super.initState();
    _configureLocalNotification();
    _configureFCM();

    _pageController = PageController();
  }

  @override
  void didChangeDependencies() {
    _cartMenuBloc = Provider.of<CartMenuBloc>(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    orderCartBloc.getCurrentLocation();
    orderCartBloc.getLocalOrder();
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const <Widget>[
            Text(
              "FAST",
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              EvaIcons.search,
              color: Colors.orange[500],
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MultiProvider(
                    providers: [
                      Provider(
                        create: (_) => SearchBloc(),
                        dispose: (context, SearchBloc bloc) => bloc.dispose(),
                      ),
                      Provider(
                        create: (_) => CartMenuBloc(),
                        dispose: (context, CartMenuBloc bloc) => bloc.dispose(),
                      ),
                    ],
                    child: FoodSearchDelegate(
                      user: widget.user,
                    ),
                  ),
                ),
              );
            },
          ),
          Stack(
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.shopping_basket,
                  color: Colors.orange[500],
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CartScreen(
                      user: widget.user,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 5,
                right: 3,
                child: StreamBuilder<List<OnlineOrder?>>(
                  stream: orderCartBloc.localOrder,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    }
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return const Text("AW");
                      case ConnectionState.waiting:
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      case ConnectionState.active:
                        return SizedBox(
                          width: 20,
                          height: 20,
                          child: Material(
                            elevation: 10,
                            color: Colors.white,
                            type: MaterialType.circle,
                            child: Center(
                              child: Text(
                                !snapshot.data!.isEmpty
                                    ? snapshot.data!
                                        .map((order) => order!.cartLength)
                                        .toList()
                                        .reduce(
                                          (value, element) =>
                                              double.parse(value.toString()) +
                                              double.parse(
                                                element.toString(),
                                              ),
                                        )
                                        .toString()
                                    : "0",
                                style: GoogleFonts.oswald(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        );
                      case ConnectionState.done:
                        return const Text("TC");
                    }
                  },
                ),
              ),
            ],
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            _changeCurrentPage(value);
            _pageController.animateToPage(
              value,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
          currentIndex: _currentPageIndex,
          selectedIconTheme: const IconThemeData(
            color: Colors.orange,
          ),
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(
                EvaIcons.homeOutline,
              ),
              title: Text(
                "HOME",
                style: GoogleFonts.nunito(
                  color: Colors.orange,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: const Icon(
                EvaIcons.shoppingBagOutline,
              ),
              title: Text(
                "ORDERS",
                style: GoogleFonts.nunito(
                  color: Colors.orange,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: const Icon(
                EvaIcons.personOutline,
              ),
              title: Text(
                "PROFILE",
                style: GoogleFonts.nunito(
                  color: Colors.orange,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ]),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: [
                MultiProvider(
                  providers: [
                    Provider(
                      create: (_) => CartMenuBloc(),
                    ),
                    Provider(
                      create: (_) => DashBloc(),
                    )
                  ],
                  child: DashScreen(
                    user: widget.user,
                  ),
                ),
                Provider(
                  create: (_) => CartBloc(),
                  dispose: (context, CartBloc bloc) => bloc.dispose(),
                  child: OrderScreen(user: widget.user),
                ),
                Provider(
                  create: (_) => LoginBloc(),
                  dispose: (context, LoginBloc bloc) => bloc.dispose(),
                  child: ProfileScreen(
                    email: widget.user['email'],
                  ),
                )
              ],
            ),
          ),
          // Positioned(
          //   child:
          // ),
        ],
      ),
    );
  }
}
