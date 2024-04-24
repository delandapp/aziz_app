import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class navProfil extends StatelessWidget {
  const navProfil({super.key, required this.title, this.icon});
  final String title;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontFamily:
                  GoogleFonts.poppins(fontWeight: FontWeight.w700).fontFamily,
              color: Colors.black,
            ),
          ), 
          Image.asset("assets/images/logo.png", height: MediaQuery.of(context).size.height * 0.08,)
        ],
      ),
    );
    // return ListTile(
    //   title: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       SizedBox(
    //         height: MediaQuery.of(context).size.height * 0.04,
    //       ),
    //       Text(
    //         title,
    //         style: TextStyle(
    //           fontSize: 20,
    //           fontFamily:
    //               GoogleFonts.poppins(fontWeight: FontWeight.w700).fontFamily,
    //           color: Colors.black,
    //         ),
    //       ),
    //     ],
    //   ),
    //   trailing: Image.asset("images/logo.png"),
    // );
  }
}
