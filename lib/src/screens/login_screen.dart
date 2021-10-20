// import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../bloc/login_bloc.dart';
import '../widgets/social_login_button.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginBloc _loginBloc;

  @override
  void didChangeDependencies() {
    _loginBloc = Provider.of<LoginBloc>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              SizedBox.fromSize(
                size: const Size.fromHeight(50),
              ),
              Center(
                child: Material(
                  elevation: 10,
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(10),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      height: 300,
                      width: 300,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/logo/logo.png"))),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 20),
                child: Column(
                  children: <Widget>[
                    Text("Welcome to FAST!",
                        style: GoogleFonts.montserrat(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF0a373a))),
                    Text(
                      "Let's get you Started.",
                      style: GoogleFonts.montserrat(
                          color: const Color(0x80789f8a),
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: Column(
                  children: <Widget>[
                    SocialLoginButton(
                      onPressed: () {
                        _loginBloc.signInWithGoogle();
                      },
                      asset: "assets/svg/google.svg",
                      name: "Google",
                    ),
                  ],
                ),
              ),
              // FutureBuilder(
              //   future: _loginBloc.isAppleSignInAvailable(),
              //   builder: (context, snapshot) {
              //     if (snapshot.data == true) {
              //       // return AppleSignInButton(
              //       //   onPressed: () {
              //       //     _loginBloc.signInWithApple();
              //       //   },
              //       // );
              //     } else {
              //       return Container();
              //     }
              //   },
              // ),
              const Spacer(),
              Text(
                "*By signing in you agree to all the terms and conditions set for using the app.*",
                style:
                    GoogleFonts.montserrat(fontSize: 10, color: Colors.black12),
              )
            ],
          ),
        ),
      ),
    );
  }
}
