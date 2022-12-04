import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Custom_Button extends StatelessWidget {
  final double width;
  final double height;
  final double fontsize;
  final Color color;
  final Color textcolor;
  final String text;
  final FontWeight fontWeight;
  final Function() ontap;

  const Custom_Button({
    Key? key,
    required this.width,
    required this.height,
    required this.color,
    required this.text,
    required this.fontsize,
    required this.textcolor,
    required this.fontWeight, required this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(15), color: color),
        child: Text(text,
            style: GoogleFonts.aclonica(
                textStyle: TextStyle(
                    color: textcolor,
                    fontSize: fontsize,
                    letterSpacing: 5,
                    fontWeight: FontWeight.bold))),
      ),
    );
  }
}
