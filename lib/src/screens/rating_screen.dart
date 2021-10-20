import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import '../bloc/ratings_bloc.dart';
import '../models/rating.dart';
import 'package:provider/provider.dart';

class RatingScreen extends StatefulWidget {
  final Map<String, dynamic> user;
  final String vendorName;

  const RatingScreen({
    Key? key,
    required this.user,
    required this.vendorName,
  }) : super(key: key);
  @override
  _RatingScreenState createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  late RatingsBloc _ratingsBloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _ratingsBloc = Provider.of<RatingsBloc>(context);
    _ratingsBloc.changeSavingStatus(false);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _ratingsBloc.getRatings(widget.vendorName);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ratings"),
      ),
      body: Container(
        margin: const EdgeInsets.only(
          left: 10,
          right: 10,
          top: 5,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: StreamBuilder<double>(
                    stream: _ratingsBloc.ratingValue,
                    builder: (context, snapshot) {
                      return RatingBar.builder(
                        initialRating: 0,
                        minRating: 0,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: _ratingsBloc.changeRatingValue,
                      );
                    },
                  ),
                ),
                StreamBuilder<bool>(
                  initialData: false,
                  stream: _ratingsBloc.isSaving,
                  builder: (context, snapshot) {
                    return Builder(builder: (context) {
                      return snapshot.data!
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : StreamBuilder<bool>(
                              stream: _ratingsBloc.canSubmitRating(),
                              builder: (context, snapshot) {
                                return RawMaterialButton(
                                  fillColor: snapshot.hasData
                                      ? Colors.orange[800]
                                      : Colors.grey,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  onPressed: snapshot.hasData
                                      ? () {
                                          _ratingsBloc.changeSavingStatus(
                                            true,
                                          );
                                          _ratingsBloc
                                              .saveRating(
                                                widget.vendorName,
                                                widget.user,
                                              )
                                              .whenComplete(
                                                () => _ratingsBloc
                                                    .changeSavingStatus(
                                                  false,
                                                ),
                                              );
                                        }
                                      : () {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content:
                                                  Text("Please add a comment!"),
                                            ),
                                          );
                                        },
                                  elevation: snapshot.hasData ? 10 : 5,
                                  disabledElevation: 0,
                                  child: Text(
                                    "Submit",
                                    style: GoogleFonts.nunito(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              },
                            );
                    });
                  },
                ),
              ],
            ),
            StreamBuilder<String>(
              stream: _ratingsBloc.ratingComment,
              builder: (context, snapshot) {
                return Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Comment",
                        style: GoogleFonts.montserrat(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        padding: const EdgeInsets.all(5),
                        child: Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(
                            5,
                          ),
                          child: TextField(
                            maxLines: 5,
                            onChanged: (value) {
                              _ratingsBloc.changeRatingComment(value);
                            },
                            style: GoogleFonts.nunito(),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 10, left: 5, right: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Customer Comments:",
                      style: GoogleFonts.montserrat(
                        fontSize: 17,
                        color: Colors.black45,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Divider(),
                    StreamBuilder<List<Rating>>(
                      stream: _ratingsBloc.ratings,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text("Error: ${snapshot.error}");
                        }
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                            return const Text("Awaiting Bids....");
                          case ConnectionState.waiting:
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          case ConnectionState.active:
                            return ListView(
                              shrinkWrap: true,
                              children: snapshot.data!
                                  .map(
                                    (rating) => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              rating.user!.name!.toUpperCase(),
                                              style: GoogleFonts.oswald(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                              width: 5,
                                            ),
                                            Text(
                                              "(${rating.rating.toString()})",
                                              style: GoogleFonts.nunito(
                                                fontSize: 11,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(rating.comment!),
                                        const Divider(),
                                      ],
                                    ),
                                  )
                                  .toList(),
                            );
                          case ConnectionState.done:
                            return const Text("The task has been completed.");
                        }
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
