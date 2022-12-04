import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Custom_Text_Form_for_TaskScreen extends StatelessWidget {
  final String text;
  final String hintText;
  final FormFieldSetter<String> onsave;
  final FormFieldValidator<String> onvalidate;
  final int? maxlength;
  final int? maxlines;
  final TextInputAction textInputAction;
  final bool enabled;
  TextEditingController? controller;
  Custom_Text_Form_for_TaskScreen(
      {super.key,
      required this.text,
      required this.hintText,
      required this.onsave,
      required this.onvalidate,
      this.maxlength,
      this.maxlines,
      required this.textInputAction,
      this.enabled = true,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text,
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(fontSize: 20)),
              ),
            ),
          ),
          TextFormField(
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
            controller: controller,
            textInputAction: textInputAction,
            enabled: enabled,
            maxLines: maxlines,
            maxLength: maxlength,
            onSaved: onsave,
            validator: onvalidate,
            decoration: InputDecoration(
                hintText: hintText,
                hintStyle: const TextStyle(color: Colors.black45),
                filled: true,
                fillColor: Colors.grey.shade200,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Colors.white,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    width: 3,
                    color: Colors.white,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: Colors.red,
                  ),
                )),
          )
        ],
      ),
    );
  }
}
