import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fast_app_v2_1/src/bloc/login_bloc.dart';
import 'package:fast_app_v2_1/src/widgets/input_field.dart';
import 'package:fast_app_v2_1/src/widgets/location_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlng/latlng.dart';
import 'package:place_picker/entities/entities.dart';
import 'package:place_picker/widgets/place_picker.dart';

import 'package:provider/provider.dart';

class UserInfoScreen extends StatefulWidget {
  final User user;

  const UserInfoScreen({Key? key, required this.user}) : super(key: key);
  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  LoginBloc? _loginBloc;
  LocationResult? _result;
  FocusNode? _textFocusNode;
  // TextEditingController _nameController, _phoneNumberController;
  // PageController _pageController;
  // int _currentIndex = 0;

  @override
  void initState() {
    // _pageController = PageController();
    // _nameController = TextEditingController();
    // _phoneNumberController = TextEditingController();
    super.initState();
    _textFocusNode = FocusNode();
  }

  @override
  void didChangeDependencies() {
    _loginBloc = Provider.of<LoginBloc>(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _textFocusNode!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // SvgPicture.asset(
            //   "assets/svg/info_form.svg",
            //   height: 200,
            // ),
            Container(
              margin: const EdgeInsets.only(
                top: 15,
              ),
              child: Text(
                "User's Information",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                ),
              ),
            ),
            StreamBuilder<String>(
              stream: _loginBloc!.name,
              builder: (context, snapshot) {
                return InputField(
                  onChanged: _loginBloc!.changeName,
                  label: "Name",
                  hint: "John Doe",
                  // autoFoucs: true,
                  onSubmitted: (value) => _textFocusNode!.requestFocus(),
                );
              },
            ),
            StreamBuilder<String>(
              stream: _loginBloc!.phoneNumber,
              builder: (context, snapshot) {
                return InputField(
                  onChanged: _loginBloc!.changePhoneNumber,
                  label: "Phone Number",
                  hint: "98-XXX-XXX-XX",
                  keyboardType: TextInputType.number,
                  focusNode: _textFocusNode,
                );
              },
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(
                  5,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 150,
                      child: Stack(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(
                                  5,
                                ),
                                topRight: Radius.circular(
                                  5,
                                ),
                              ),
                              image: DecorationImage(
                                image: AssetImage(
                                  "assets/background/location.jpg",
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                                // gradient: LinearGradient(
                                //   begin: Alignment.topCenter,
                                //   end: Alignment.bottomCenter,
                                //   colors: [
                                //     Colors.transparent,
                                //     Colors.orange[300],
                                //   ],
                                // ),
                                ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            child: Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Pick a location !",
                                      style: GoogleFonts.montserrat(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      "These saved locations can be later used for delivery.",
                                      style: GoogleFonts.nunito(
                                          color: Colors.white60,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 13),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              StreamBuilder<Map<String, dynamic>>(
                                stream: _loginBloc!.homeLocation,
                                initialData: {},
                                builder: (context, snapshot) {
                                  return LocationPicker(
                                    title: "Home",
                                    location:
                                        snapshot.data!['physicalLocation'],
                                    icon: EvaIcons.homeOutline,
                                    onTap: () async {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PlacePicker(
                                              "AIzaSyATdr7r2cCqiNWcgv9VQSYKf7k50Qzx7IY"),
                                        ),
                                      );
                                      _loginBloc!.changeHomeLocation(
                                        {
                                          "lat": _result!.latLng!.latitude,
                                          "lang": _result!.latLng!.longitude,
                                          "physicalLocation":
                                              _result!.formattedAddress,
                                        },
                                      );
                                    },
                                  );
                                },
                              ),
                              _result == null ? const Divider() : Container(),
                              StreamBuilder<Map<String, dynamic>>(
                                stream: _loginBloc!.officeLocation,
                                initialData: {},
                                builder: (context, snapshot) {
                                  return LocationPicker(
                                    location:
                                        snapshot.data!['physicalLocation'],
                                    title: "Office",
                                    icon: EvaIcons.linkedinOutline,
                                    onTap: () async {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PlacePicker(
                                              "AIzaSyATdr7r2cCqiNWcgv9VQSYKf7k50Qzx7IY"),
                                        ),
                                      );
                                      _loginBloc!.changeOfficeLocation(
                                        {
                                          "lat": _result!.latLng!.latitude,
                                          "lang": _result!.latLng!.longitude,
                                          "physicalLocation":
                                              _result!.formattedAddress,
                                        },
                                      );
                                    },
                                  );
                                },
                              ),
                              Text(
                                "* These can be saved later too *",
                                style: GoogleFonts.nunito(
                                  color: Colors.black12,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Expanded(
            //   child: Container(),
            // ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: StreamBuilder<bool>(
                      stream: _loginBloc!.canSubmitData,
                      builder: (context, snapshot) {
                        return RawMaterialButton(
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                          ),
                          onPressed: snapshot.hasData
                              ? () => _loginBloc!.saveUser(widget.user)
                              : null,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              5,
                            ),
                          ),
                          fillColor: Colors.orange[800],
                          child: Text(
                            "Save Info",
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
