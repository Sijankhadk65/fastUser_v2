import 'package:cached_network_image/cached_network_image.dart';
import 'package:fast_app_v2_1/src/bloc/cart_menu_bloc.dart';
import 'package:fast_app_v2_1/src/models/community_item.dart';
import 'package:fast_app_v2_1/src/resources/ui/fonts_settings.dart';
import 'package:fast_app_v2_1/src/screens/community_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CommunityCard extends StatelessWidget {
  final CommunityItem? communityItem;
  // final double? iconSize;
  final Function()? onTap;
  final Map<String, dynamic>? user;

  const CommunityCard({Key? key, this.onTap, this.communityItem, this.user})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: communityItem!.photoURI.toString(),
      progressIndicatorBuilder: (context, msg, progress) => const Center(
        child: CircularProgressIndicator(),
      ),
      imageBuilder: (context, imageProvider) => Container(
        margin: EdgeInsets.only(
          top: 10,
          bottom: 10,
          left: 15,
          right: 15,
        ),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 10,
              offset: Offset(3, 3),
            )
          ],
          borderRadius: BorderRadius.circular(
            5,
          ),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    5,
                  ),
                ),
                gradient: LinearGradient(
                  colors: [
                    Colors.black,
                    Colors.black.withAlpha(220),
                    Colors.black.withAlpha(190),
                    Colors.black.withAlpha(160),
                    Colors.black.withAlpha(110),
                    Colors.black.withAlpha(80),
                    Colors.black.withAlpha(50),
                    Colors.transparent,
                    Colors.black.withAlpha(50),
                    Colors.black.withAlpha(80),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                left: 10,
                right: 10,
                top: 15,
                bottom: 5,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  communityItem!.title!,
                                  style:
                                      FontSettings.TitleStyleExtraLargeDark(),
                                ),
                              ),
                              Expanded(
                                child: Container(),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          communityItem!.description!,
                          style: FontSettings.DescriptionStyleLargeDark(),
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                              (states) => Colors.white,
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => Provider(
                                  create: (_) => CartMenuBloc(),
                                  child: CommunityDetailScreen(
                                    communityItem: communityItem,
                                    categories: communityItem!.categories,
                                    vendorID: "D3RBhAzYAi4rzHJRTic9",
                                    vendorName: "The 666s Art",
                                    user: user,
                                    minOrder: 200,
                                    shouldSchedule: false,
                                    closingTime: DateTime.now(),
                                    openingTime: DateTime.now(),
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Text(
                            "Visit",
                            style: GoogleFonts.nunito(
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      errorWidget: (context, msg, error) => Container(
        margin: const EdgeInsets.only(
          top: 5,
          bottom: 5,
        ),
        decoration: const BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
      ),
    );
  }
}

class ParallaxDelegate extends FlowDelegate {
  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    return BoxConstraints.tightFor(
      width: constraints.maxWidth,
    );
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    // TODO: implement paintChildren
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }
}
