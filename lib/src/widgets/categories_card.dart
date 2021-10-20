import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoriesCard extends StatelessWidget {
  final String? category, assetPath, message;
  final Function()? onTap;

  const CategoriesCard({
    Key? key,
    this.category,
    this.assetPath,
    this.message,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 10,
        right: 10,
        top: 5,
        bottom: 10,
      ),
      child: Material(
        elevation: 5,
        shadowColor: Colors.black45,
        borderRadius: BorderRadius.circular(
          5,
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(
            5,
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              top: 5,
              bottom: 5,
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  assetPath!,
                  height: 40,
                  width: 40,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        category!,
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w800,
                          fontSize: 17,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          message!,
                          style: GoogleFonts.nunito(
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                            color: Colors.black45,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
    // Container(
    //   margin: EdgeInsets.only(
    //     top: 5,
    //     left: 5,
    //     right: 5,
    //     bottom: 15,
    //   ),
    //   child:
    //   Stack(
    //     children: [
    //       Container(
    //         decoration: BoxDecoration(
    //           color: Colors.white,
    //           image: DecorationImage(
    //             image: AssetImage(assetPath!),
    //             fit: BoxFit.cover,
    //           ),
    //           borderRadius: BorderRadius.circular(
    //             5,
    //           ),
    //           boxShadow: [
    //             BoxShadow(
    //               color: Colors.black12,
    //               blurRadius: 5,
    //               offset: Offset(
    //                 0,
    //                 5,
    //               ),
    //             )
    //           ],
    //         ),
    //       ),
    //       Container(
    //         decoration: BoxDecoration(
    //             borderRadius: BorderRadius.circular(
    //               5,
    //             ),
    //             color: Colors.white),
    //         child: Material(
    //           color: Colors.transparent,
    //           child: InkWell(
    //             onTap: onTap,
    //             borderRadius: BorderRadius.circular(
    //               13,
    //             ),
    //             splashColor: Colors.orange[300],
    //             child: Padding(
    //               padding: EdgeInsets.only(
    //                 left: 15,
    //                 right: 15,
    //                 top: 8,
    //                 bottom: 8,
    //               ),
    //               child: Row(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   CircleAvatar(
    //                     backgroundColor: Colors.orangeAccent,
    //                     backgroundImage: AssetImage(assetPath!),
    //                     radius: 30.0,
    //                   ),
    //                   // Icon(Icons.build_circle),
    //                   SizedBox(
    //                     width: 10,
    //                   ),
    //                   Expanded(
    //                     child: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       mainAxisAlignment: MainAxisAlignment.start,
    //                       children: <Widget>[
    //                         Text(
    //                           category!,
    //                           style: GoogleFonts.nunito(
    //                             fontWeight: FontWeight.w800,
    //                             color: Colors.black,
    //                             fontSize: 16,
    //                           ),
    //                           overflow: TextOverflow.ellipsis,
    //                         ),
    //                         Text(
    //                           message!,
    //                           overflow: TextOverflow.ellipsis,
    //                           style: GoogleFonts.montserrat(
    //                             fontSize:
    //                                 MediaQuery.of(context).size.height < 1080
    //                                     ? 8
    //                                     : 11,
    //                             fontWeight: FontWeight.w600,
    //                             color: Colors.black.withAlpha(
    //                               200,
    //                             ),
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }
}
