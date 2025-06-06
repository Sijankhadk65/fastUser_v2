import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fast_app_v2_1/src/bloc/order_cart_bloc.dart';
import 'package:fast_app_v2_1/src/models/user.dart';
import 'package:fast_app_v2_1/src/models/user_location.dart';
import 'package:fast_app_v2_1/src/widgets/profile_image_source.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlng/latlng.dart';
import 'package:place_picker/entities/entities.dart';
import 'package:place_picker/place_picker.dart';

import '../bloc/login_bloc.dart';

import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  final String email;

  const ProfileScreen({Key? key, required this.email}) : super(key: key);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late LoginBloc _loginBloc;
  late LocationResult _result;

  @override
  void didChangeDependencies() {
    _loginBloc = Provider.of<LoginBloc>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: StreamBuilder<FastUser>(
          builder: (context, userSnapshot) {
            if (userSnapshot.hasError) {
              return Text("Error:${userSnapshot.error}");
            }
            switch (userSnapshot.connectionState) {
              case ConnectionState.none:
                return const Text("Awaiting Bids");
              case ConnectionState.waiting:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case ConnectionState.active:
                _loginBloc.changeHomeLocation(
                  convertUserLocationToJson(
                    userSnapshot.data!.home!,
                  ),
                );
                _loginBloc.changeOfficeLocation(
                  convertUserLocationToJson(
                    userSnapshot.data!.office!,
                  ),
                );
                return Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(
                        5,
                      ),
                      height: 150,
                      width: 150,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(
                              0,
                              6,
                            ),
                            blurRadius: 10,
                          )
                        ],
                        color: Colors.white,
                      ),
                      child: Stack(
                        children: [
                          userSnapshot.data!.photoURI != null
                              ? CachedNetworkImage(
                                  imageUrl: userSnapshot.data!.photoURI!,
                                  placeholder: (context, msg) => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  errorWidget: (context, msg, _) => Container(),
                                  imageBuilder: (context, imageProvider) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : Container(
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                        "assets/background/profile-alt.png",
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(
                                150,
                              ),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => Provider(
                                    create: (_) => LoginBloc(),
                                    child: ProfileImageSourceDialoge(
                                      email: userSnapshot.data!.email!,
                                    ),
                                    dispose: (context, LoginBloc bloc) =>
                                        bloc.dispose(),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      userSnapshot.data!.name!.toUpperCase(),
                      style: GoogleFonts.oswald(
                        fontSize: 35,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Row(
                      children: [
                        StreamBuilder<String?>(
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text("Error: ${snapshot.error}");
                            }
                            switch (snapshot.connectionState) {
                              case ConnectionState.none:
                                return const Text("Awaiting bids....");
                              case ConnectionState.waiting:
                                return const Center(
                                  child: LinearProgressIndicator(),
                                );
                              case ConnectionState.active:
                                return Container(
                                  padding: const EdgeInsets.only(
                                    right: 15,
                                    left: 12,
                                    top: 8,
                                    bottom: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.orange[300]!.withAlpha(
                                      100,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      20,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.location_on,
                                        color: Colors.orange,
                                      ),
                                      Text(
                                        snapshot.data!,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.orange,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              case ConnectionState.done:
                                return const Text("The task has completed....");
                            }
                          },
                          stream: orderCartBloc.physicalLocation,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              _loginBloc.signOut();
                            },
                            child: Text("Logout"))
                      ],
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Container(
                    //       child: Text(
                    //         userSnapshot.data.email,
                    //         style: GoogleFonts.montserrat(
                    //           fontSize: 13,
                    //           fontWeight: FontWeight.w500,
                    //         ),
                    //       ),
                    //     ),
                    //     Container(
                    //       width: 5,
                    //     ),
                    //     Container(
                    //       child: Text(
                    //         userSnapshot.data.phoneNumber.toString(),
                    //         style: GoogleFonts.montserrat(
                    //           fontSize: 13,
                    //           fontWeight: FontWeight.w500,
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),

                    // Container(
                    //   margin: EdgeInsets.only(
                    //     top: 5,
                    //   ),
                    //   decoration: BoxDecoration(
                    //     border: Border.all(
                    //       color: Colors.orange[800],
                    //       width: 2,
                    //     ),
                    //     borderRadius: BorderRadius.circular(
                    //       5,
                    //     ),
                    //   ),
                    //   child: Material(
                    //     color: Colors.transparent,
                    //     child: InkWell(
                    //       onTap: () {
                    //         FirebaseAuth.instance.signOut();
                    //       },
                    //       child: Padding(
                    //         padding: const EdgeInsets.only(
                    //           left: 10,
                    //           right: 10,
                    //         ),
                    //         child: Text(
                    //           "Logout",
                    //           style: GoogleFonts.nunito(
                    //             color: Colors.orange[800],
                    //             fontWeight: FontWeight.w800,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 10,
                      ),
                      child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(
                          5,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(
                            10,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height: 60,
                                width: 5,
                                margin: const EdgeInsets.only(
                                  right: 5,
                                ),
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Colors.orange,
                                      Colors.white,
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "HOME",
                                      style: GoogleFonts.montserrat(
                                        color: Colors.grey[500],
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    StreamBuilder<Map<String, dynamic>>(
                                      stream: _loginBloc.homeLocation,
                                      builder: (context, snapshot) {
                                        if (snapshot.hasError) {
                                          return Text(
                                              "Error: ${snapshot.error}");
                                        }
                                        switch (snapshot.connectionState) {
                                          case ConnectionState.none:
                                            return const Text(
                                                "Awaiting Bids......");
                                          case ConnectionState.waiting:
                                            return const Center(
                                              child: LinearProgressIndicator(),
                                            );
                                          case ConnectionState.active:
                                            return snapshot.data!['lat'] ==
                                                        null &&
                                                    snapshot.data!['lat'] ==
                                                        null &&
                                                    snapshot.data![
                                                            'physicalLocation'] ==
                                                        null
                                                ? RawMaterialButton(
                                                    onPressed: () async {
                                                      _result =
                                                          await Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              PlacePicker(
                                                                  "AIzaSyATdr7r2cCqiNWcgv9VQSYKf7k50Qzx7IY"),
                                                        ),
                                                      );
                                                      _loginBloc
                                                          .updateUserHomeLocation(
                                                        {
                                                          "lat": _result
                                                              .latLng!.latitude,
                                                          "lang": _result
                                                              .latLng!
                                                              .longitude,
                                                          "physicalLocation":
                                                              _result
                                                                  .formattedAddress,
                                                        },
                                                        userSnapshot
                                                            .data!.email!,
                                                      );
                                                    },
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 10,
                                                      right: 10,
                                                    ),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        5,
                                                      ),
                                                    ),
                                                    child: Text(
                                                      "SELECT A LOCATION",
                                                      style: GoogleFonts.nunito(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                      ),
                                                    ),
                                                    fillColor: Colors.orange,
                                                  )
                                                : Row(
                                                    children: <Widget>[
                                                      Expanded(
                                                        flex: 2,
                                                        child: Text(
                                                          snapshot.data![
                                                                  'physicalLocation']
                                                              .toString()
                                                              .toUpperCase(),
                                                          style: GoogleFonts
                                                              .nunito(
                                                            fontSize: 13,
                                                            color:
                                                                Colors.orange,
                                                            fontWeight:
                                                                FontWeight.w800,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: IconButton(
                                                          icon: Icon(
                                                            EvaIcons
                                                                .edit2Outline,
                                                            color: Colors
                                                                .grey[700],
                                                            size: 18,
                                                          ),
                                                          onPressed: () async {
                                                            _result =
                                                                await Navigator
                                                                    .push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (context) =>
                                                                    PlacePicker(
                                                                        "AIzaSyATdr7r2cCqiNWcgv9VQSYKf7k50Qzx7IY"),
                                                              ),
                                                            );
                                                            _loginBloc
                                                                .updateUserHomeLocation(
                                                              {
                                                                "lat": _result
                                                                    .latLng!
                                                                    .latitude,
                                                                "lang": _result
                                                                    .latLng!
                                                                    .longitude,
                                                                "physicalLocation":
                                                                    _result
                                                                        .formattedAddress,
                                                              },
                                                              userSnapshot
                                                                  .data!.email!,
                                                            );
                                                          },
                                                        ),
                                                      )
                                                    ],
                                                  );
                                          case ConnectionState.done:
                                            return const Text(
                                              "The task has completed",
                                            );
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 60,
                                width: 5,
                                margin: const EdgeInsets.only(
                                  left: 5,
                                  right: 5,
                                ),
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Colors.orange,
                                      Colors.white,
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "OFFICE",
                                      style: GoogleFonts.montserrat(
                                        color: Colors.grey[500],
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: StreamBuilder<
                                              Map<String, dynamic>>(
                                            stream: _loginBloc.officeLocation,
                                            builder: (context, snapshot) {
                                              if (snapshot.hasError) {
                                                return Text(
                                                    "Error: ${snapshot.error}");
                                              }
                                              switch (
                                                  snapshot.connectionState) {
                                                case ConnectionState.none:
                                                  return const Text(
                                                      "Awaiting Bids......");
                                                case ConnectionState.waiting:
                                                  return const Center(
                                                    child:
                                                        LinearProgressIndicator(),
                                                  );
                                                case ConnectionState.active:
                                                  return snapshot.data![
                                                                  'lat'] ==
                                                              null &&
                                                          snapshot.data![
                                                                  'lat'] ==
                                                              null &&
                                                          snapshot.data![
                                                                  'physicalLocation'] ==
                                                              null
                                                      ? RawMaterialButton(
                                                          onPressed: () async {
                                                            _result =
                                                                await Navigator
                                                                    .push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (context) =>
                                                                    PlacePicker(
                                                                        "AIzaSyATdr7r2cCqiNWcgv9VQSYKf7k50Qzx7IY"),
                                                              ),
                                                            );
                                                            _loginBloc
                                                                .updateUserOfficeLocation(
                                                              {
                                                                "lat": _result
                                                                    .latLng!
                                                                    .latitude,
                                                                "lang": _result
                                                                    .latLng!
                                                                    .longitude,
                                                                "physicalLocation":
                                                                    _result
                                                                        .formattedAddress,
                                                              },
                                                              userSnapshot
                                                                  .data!.email!,
                                                            );
                                                          },
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            left: 10,
                                                            right: 10,
                                                          ),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                              5,
                                                            ),
                                                          ),
                                                          child: Text(
                                                            "SELECT A LOCATION",
                                                            style: GoogleFonts
                                                                .nunito(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800,
                                                            ),
                                                          ),
                                                          fillColor:
                                                              Colors.orange,
                                                        )
                                                      : Row(
                                                          children: <Widget>[
                                                            Expanded(
                                                              flex: 4,
                                                              child: Text(
                                                                snapshot.data![
                                                                        'physicalLocation']
                                                                    .toString()
                                                                    .toUpperCase(),
                                                                style:
                                                                    GoogleFonts
                                                                        .nunito(
                                                                  fontSize: 13,
                                                                  color: Colors
                                                                      .orange,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800,
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 1,
                                                              child: IconButton(
                                                                icon: Icon(
                                                                  EvaIcons
                                                                      .edit2Outline,
                                                                  color: Colors
                                                                          .grey[
                                                                      700],
                                                                  size: 18,
                                                                ),
                                                                onPressed:
                                                                    () async {
                                                                  await Navigator
                                                                      .push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          PlacePicker(
                                                                              "AIzaSyATdr7r2cCqiNWcgv9VQSYKf7k50Qzx7IY"),
                                                                    ),
                                                                  );
                                                                  _loginBloc
                                                                      .updateUserOfficeLocation(
                                                                    {
                                                                      "lat": _result
                                                                          .latLng!
                                                                          .latitude,
                                                                      "lang": _result
                                                                          .latLng!
                                                                          .longitude,
                                                                      "physicalLocation":
                                                                          _result
                                                                              .formattedAddress,
                                                                    },
                                                                    userSnapshot
                                                                        .data!
                                                                        .email!,
                                                                  );
                                                                },
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
                    ),
                  ],
                );
              case ConnectionState.done:
                return const Text("The task has completed");
            }
          },
          stream: _loginBloc.getUser(widget.email),
        ),
      ),
    );
  }
}

class ProfileClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromCircle(
      center: Offset(size.height / 2, size.width / 2),
      radius: 150,
    );
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    throw false;
  }
}
