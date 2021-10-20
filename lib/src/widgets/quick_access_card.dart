import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class QuickAccessCard extends StatelessWidget {
  final String? title, description, assetPath;
  final double? iconSize;
  final Function()? onTap;
  final Color lightColor, darkColor;

  const QuickAccessCard({
    Key? key,
    this.title,
    this.description,
    this.assetPath,
    this.iconSize,
    this.onTap,
    this.lightColor = Colors.lightGreen,
    this.darkColor = Colors.green,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: EdgeInsets.only(
        left: 10,
        right: 5,
        bottom: 10,
      ),
      child: Material(
        elevation: 5,
        shadowColor: Colors.black54,
        borderRadius: BorderRadius.circular(
          5,
        ),
        child: InkWell(
          onTap: onTap,
          splashColor: Colors.orangeAccent,
          borderRadius: BorderRadius.circular(
            5,
          ),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: SvgPicture.asset(
                  assetPath!,
                  height: 40,
                  width: 40,
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    // color: cardColor,
                    gradient: LinearGradient(
                      colors: [lightColor, darkColor],
                    ),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(
                        5,
                      ),
                      bottomRight: Radius.circular(
                        5,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title!,
                        style: GoogleFonts.nunito(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        description!,
                        style: GoogleFonts.nunito(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Colors.white60,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
