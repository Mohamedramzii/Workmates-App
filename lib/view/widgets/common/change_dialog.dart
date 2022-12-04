import 'package:flutter/material.dart';

class Change_something_dialog {
  static void change_dialog(
      {required BuildContext context,
      required TextEditingController controller,
      required String hinttext,
      required IconData icon,
      required Function() icononpressed}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Row(
              children: [
                Container(
                  width: 300,
                  child: TextField(
                    controller: controller,
                    onSubmitted: (value) {
                      controller.text = value;
                    },
                    decoration: InputDecoration(
                        hintText: hinttext,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.green,
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
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      icononpressed;
                    },
                    child: Icon(icon))
              ],
            ),
          );
        });
  }
}
