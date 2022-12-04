import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:work_os/utils/size_config.dart';

class Custom_List_Tile extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function() ontap;
  Custom_List_Tile({
    Key? key,
    required this.icon,
    required this.text,
    required this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: getProportionateScreenHeight(25),
          left: getProportionateScreenWidth(17)),
      child: ListTile(
        onTap: ontap,
        leading: Icon(icon, color: Colors.black, size: 30),
        title: Text('   $text',
            style: GoogleFonts.lora(
                textStyle: const TextStyle(
                    fontSize: 25, fontWeight: FontWeight.bold))),
      ),
    );
  }
}
