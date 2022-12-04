import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserData_Controller extends GetxController {
  String username = '';
  String companyPosition = '';
  String createdAt = '';
  String email = '';
  String? userImage;
  String phoneNumber = '';

  RxBool isInfoChanged=false.obs;

  TextEditingController username_controller=TextEditingController();
  // bool? isCurrentUser;
  Stream<QuerySnapshot<Map<String, dynamic>>> users =
      FirebaseFirestore.instance.collection('users').snapshots();
  bool isloading = false;

  String user = FirebaseAuth.instance.currentUser!.uid;

  UserData_Controller() {
    getUserData();
  }

  void getUserData() async {
    isloading = true;
    try {
      final DocumentSnapshot userInfo =
          await FirebaseFirestore.instance.collection('users').doc(user).get();
      if (userInfo == null) {
        return;
      } else {
        username = userInfo.get('name');
        companyPosition = userInfo.get('company_position');
        userImage = userInfo.get('imageURL');
        email = userInfo.get('email');
        phoneNumber = userInfo.get('phone_number');
        Timestamp joinedAt = userInfo.get('created_at');
        var dateformat = joinedAt.toDate();
        createdAt = '${dateformat.day}-${dateformat.month}-${dateformat.year}';

        
        update();
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isloading = false;
    }
    update();
  }
}
