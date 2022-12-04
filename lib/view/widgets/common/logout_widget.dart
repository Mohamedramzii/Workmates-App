import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_os/controller/Authentication.dart';

import '../../../utils/size_config.dart';

class Logout_Widget {
  static void logout(BuildContext context) {
    final Authentication_Controller _auth_controller = Get.find();

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.logout_rounded),
                SizedBox(
                  width: getProportionateScreenWidth(8),
                ),
                const Text('Log Out',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            content: const Text('Are you sure you want to logout ?',
                style: TextStyle(fontSize: 20)),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text('cancel',
                          style: TextStyle(color: Colors.black, fontSize: 17))),
                  TextButton(
                      onPressed: () {
                        _auth_controller.Logout();
                      },
                      child: const Text('Logout',
                          style: TextStyle(color: Colors.red, fontSize: 17)))
                ],
              )
            ],
          );
        });
  }
}
