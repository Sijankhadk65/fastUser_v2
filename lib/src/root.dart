import 'package:fast_app_v2_1/src/models/user_location.dart';
import 'package:fast_app_v2_1/src/screens/user_info_screen.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import './bloc/cart_menu_bloc.dart';
import './bloc/login_bloc.dart';
import './screens/home_screen.dart';
import './screens/login_screen.dart';

import 'package:provider/provider.dart';

import 'models/user.dart';

class Root extends StatefulWidget {
  const Root({Key? key}) : super(key: key);

  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  late LoginBloc _bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = Provider.of<LoginBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User>(
        stream: _bloc.currentUserStateStream,
        builder: (context, userSnapshot) {
          if (userSnapshot.hasError && userSnapshot.hasData) {
            return Text('The first Error: ${userSnapshot.error}');
          }
          switch (userSnapshot.connectionState) {
            case ConnectionState.none:
              return const Text('Select lot');
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            case ConnectionState.active:
              return MultiProvider(
                providers: [
                  Provider(
                    create: (_) => LoginBloc(),
                    dispose: (context, LoginBloc bloc) => bloc.dispose(),
                  ),
                  Provider(
                    create: (_) => CartMenuBloc(),
                    dispose: (context, CartMenuBloc bloc) => bloc.dispose(),
                  ),
                ],
                child: userSnapshot.hasData && userSnapshot.data != null
                    ? StreamBuilder<bool>(
                        stream: _bloc.getUserStatus(userSnapshot.data?.email),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Container(
                              height: double.infinity,
                              width: double.infinity,
                              color: Colors.white,
                              child: Center(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/icons/closed.png",
                                    height: 200,
                                    width: 200,
                                  ),
                                  Text(
                                    'Under Maintenance!',
                                    style: GoogleFonts.oswald(
                                      fontSize: 23,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 2,
                                    ),
                                  ),
                                  const Text(
                                    "Contact our instagram\nhandle below for orders:",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Center(
                                    child: InkWell(
                                      onTap: () async {
                                        var url =
                                            'https://www.instagram.com/fast.theapp/';

                                        if (await canLaunch(url)) {
                                          await launch(
                                            url,
                                            universalLinksOnly: true,
                                          );
                                        } else {
                                          throw 'There was a problem to open the url: $url';
                                        }
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "assets/icons/instagram.png",
                                            height: 30,
                                            width: 30,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Fast977",
                                            style: GoogleFonts.oswald(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              letterSpacing: 2,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              )),
                            );
                          }
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                              return const Text("Awaitng Bids....");
                            case ConnectionState.waiting:
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            case ConnectionState.active:
                              return snapshot.data == true
                                  ? StreamBuilder<FastUser>(
                                      stream: _bloc
                                          .getUser(userSnapshot.data!.email!),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasError) {
                                          return Text(
                                              "Errors: ${snapshot.error}");
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
                                            return HomeScreen(
                                              user: {
                                                "name": snapshot.data!.name,
                                                "email": snapshot.data!.email,
                                                "phoneNumber":
                                                    snapshot.data!.phoneNumber,
                                                "home":
                                                    convertUserLocationToJson(
                                                        snapshot.data!.home!),
                                                "office":
                                                    convertUserLocationToJson(
                                                        snapshot.data!.office!),
                                              },
                                            );
                                          case ConnectionState.done:
                                            return const Text(
                                                "The task has completed");
                                        }
                                      },
                                    )
                                  : UserInfoScreen(
                                      user: userSnapshot.data!,
                                    );
                            case ConnectionState.done:
                              return const Text("The task has Completed");
                          }
                        },
                      )
                    : LoginScreen(),
              );
            default:
              return Container();
          }
        },
      ),
    );
  }
}
