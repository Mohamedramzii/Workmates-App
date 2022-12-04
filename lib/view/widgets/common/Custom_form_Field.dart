import 'package:flutter/material.dart';

class Custom_form_Field extends StatelessWidget {
  final Icon lefticon;
  final Widget righticon;
  final TextInputType keyboardtype;
  final String label;
  final String hintText;
  final bool obscure;
  final FormFieldSetter<String> onsave;
  final FormFieldValidator<String> onvalidate;
  final TextInputAction textInputAction;

  const Custom_form_Field(
      {Key? key,
      required this.lefticon,
      required this.righticon,
      required this.keyboardtype,
      required this.label,
      required this.hintText,
      required this.obscure,
      required this.onsave,
      required this.onvalidate,
       this.textInputAction=TextInputAction.next})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction:textInputAction,
      keyboardType: keyboardtype,
      obscureText: obscure,
      obscuringCharacter: '*',
      onSaved: onsave,
      validator: onvalidate,
      style: const TextStyle(color: Colors.white, fontSize: 20),
      decoration: InputDecoration(
          label: Text(label,
              style: const TextStyle(fontSize: 20, color: Colors.white)),
          hintText: hintText,
          hintStyle: const TextStyle(fontSize: 20, color: Colors.grey),
          prefixIcon: lefticon,
          suffixIcon: righticon,
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
    );
  }
}
