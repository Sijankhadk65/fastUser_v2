import 'package:cached_network_image/cached_network_image.dart';
import 'package:fast_app_v2_1/src/bloc/cart_menu_bloc.dart';
import 'package:fast_app_v2_1/src/models/community_item.dart';
import 'package:fast_app_v2_1/src/screens/community_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

@immutable
class CommunityCardParallax extends StatelessWidget {
  final CommunityItem? communityItem;
  // final double? iconSize;
  final Function()? onTap;
  final Map<String, dynamic>? user;

  CommunityCardParallax({Key? key, this.onTap, this.communityItem, this.user})
      : super(key: key);

  final GlobalKey _globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3 / 4,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Stack(
          children: [
            _buildParallaxBackground(context),
            _buildGradient(),
            _buildTitleAndSubtitle(context),
          ],
        ),
      ),
    );
  }

  Widget _buildParallaxBackground(BuildContext context) {
    return Flow(
      delegate: ParallaxDelegate(
        scrollable: Scrollable.of(
          context,
        )!,
        backgroundImageKey: _globalKey,
        listItemContext: context,
      ),
      children: [
        CachedNetworkImage(
          key: _globalKey,
          imageUrl: communityItem!.photoURI!,
          fit: BoxFit.cover,
        ),
      ],
    );
  }

  Widget _buildGradient() {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
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
    );
  }

  Widget _buildTitleAndSubtitle(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 15,
        bottom: 5,
        left: 10,
        right: 10,
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
                          style: GoogleFonts.nunito(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 35,
                          ),
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
                  style: GoogleFonts.nunito(
                    color: Colors.white70,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
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
    );
  }
}

class ParallaxDelegate extends FlowDelegate {
  final ScrollableState scrollable;
  final BuildContext listItemContext;
  final GlobalKey backgroundImageKey;

  ParallaxDelegate({
    required this.scrollable,
    required this.listItemContext,
    required this.backgroundImageKey,
  }) : super(repaint: scrollable.position);

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    return BoxConstraints.tightFor(
      width: constraints.maxWidth,
    );
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    final scrollableBox = scrollable.context.findRenderObject() as RenderBox;
    final listItemBox = listItemContext.findRenderObject() as RenderBox;
    final listItemOffset = listItemBox.localToGlobal(
        listItemBox.size.centerLeft(Offset.zero),
        ancestor: scrollableBox);
    final viewportDimension = scrollable.position.viewportDimension;
    final scrollFraction =
        (listItemOffset.dy / viewportDimension).clamp(0.0, 1.0);
    final verticalAlignment = Alignment(0.0, scrollFraction * 2 - 1);
    final backgroundSize =
        (backgroundImageKey.currentContext!.findRenderObject() as RenderBox)
            .size;
    final listItemSize = context.size;
    final childRect =
        verticalAlignment.inscribe(backgroundSize, Offset.zero & listItemSize);
    context.paintChild(
      0,
      transform: Transform.translate(
        offset: Offset(0.0, childRect.top),
      ).transform,
    );
  }

  @override
  bool shouldRepaint(covariant ParallaxDelegate oldDelegate) {
    return scrollable != oldDelegate.scrollable ||
        listItemContext != oldDelegate.listItemContext ||
        backgroundImageKey != oldDelegate.backgroundImageKey;
  }
}
