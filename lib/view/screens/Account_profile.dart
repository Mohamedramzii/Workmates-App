import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:work_os/controller/Authentication.dart';
import 'package:work_os/controller/UserData_Controller.dart';
import 'package:work_os/routes/routes.dart';
import 'package:work_os/utils/size_config.dart';
import 'package:work_os/view/screens/Task/loading_filter.dart';
import 'package:work_os/view/widgets/common/logout_widget.dart';

import '../widgets/common/change_dialog.dart';

class Account_Profile_Screen extends GetWidget<UserData_Controller> {
  Account_Profile_Screen({super.key});
  final Authentication_Controller _auth_controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
          size: 25,
        ),
        backgroundColor: Colors.lightGreen,
        elevation: 0,
      ),
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: double.infinity,
            height: getProportionateScreenHeight(270),
            decoration: const BoxDecoration(
                color: Colors.lightGreen,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(100),
                  bottomRight: Radius.circular(100),
                )),
          ),
          Positioned(
            top: 150,
            right: -15,
            left: 5,
            child: SizedBox(
              width: getProportionateScreenWidth(400),
              height: getProportionateScreenHeight(600),
              child: Card(
                margin: EdgeInsets.only(
                    left: getProportionateScreenWidth(10),
                    right: getProportionateScreenWidth(20)),
                elevation: 10,
                child: Column(
                  children: [
                    SizedBox(height: getProportionateScreenHeight(200)),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        // minWidth: getProportionateScreenWidth(290),
                        maxWidth: getProportionateScreenWidth(290),
                      ),
                      child: GetBuilder<UserData_Controller>(
                        builder:(controller)=> Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Row(
                                            children: [
                                              Container(
                                                width:
                                                    getProportionateScreenWidth(
                                                        200),
                                                child: TextField(
                                                  controller: controller
                                                      .username_controller,
                                                  onSubmitted: (value) {
                                                    controller.username_controller
                                                        .text = value;
                                                  },
                                                  decoration: InputDecoration(
                                                      hintText: 'Enter a name',
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                10),
                                                        borderSide:
                                                            const BorderSide(
                                                          color: Colors.green,
                                                        ),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                15),
                                                        borderSide:
                                                            const BorderSide(
                                                          width: 3,
                                                          color: Colors.green,
                                                        ),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                15),
                                                        borderSide:
                                                            const BorderSide(
                                                          color: Colors.red,
                                                        ),
                                                      )),
                                                ),
                                              ),
                                              SizedBox(
                                                width:
                                                    getProportionateScreenWidth(
                                                        10),
                                              ),
                                              GestureDetector(
                                                  onTap: () {
                                                    controller.isInfoChanged.value=true;
                                                    FirebaseFirestore.instance
                                                        .collection('users')
                                                        .doc(controller.user)
                                                        .update({
                                                          'name':controller.username_controller.text
                                                        }); 
                                                    controller.getUserData();
                                                    Get.back();
                                                    controller.username_controller
                                                        .clear();
                                                  
                                                  },
                                                  child: const Icon(Icons.send))
                                            ],
                                          ),
                                        );
                                      });
                                },
                                icon: const Icon(Icons.edit)),
                            Text(
                              controller.username ==null
                                  ? 'Just a user'
                                  : controller.username,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.quicksand(
                                  textStyle: const TextStyle(
                                      fontSize: 35, fontWeight: FontWeight.bold)),
                            ),
                            
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(10)),
                    Text(
                      controller.companyPosition,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.quicksand(
                          textStyle: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(height: getProportionateScreenHeight(10)),
                    Text(
                      'Joined Since:',
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.quicksand(
                          textStyle: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(height: getProportionateScreenHeight(10)),
                    Text(
                      controller.createdAt,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.quicksand(
                          textStyle: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(height: getProportionateScreenHeight(10)),
                    Text(
                      controller.email,
                      style: GoogleFonts.quicksand(
                          textStyle: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(height: getProportionateScreenHeight(10)),
                    Text(
                      '+20 ${controller.phoneNumber}',
                      style: GoogleFonts.quicksand(
                          textStyle: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(-0.85, -1),
            child: SizedBox(
              width: getProportionateScreenWidth(200),
              height: getProportionateScreenHeight(300),
              child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                    topLeft: Radius.circular(50),
                    bottomLeft: Radius.circular(0),
                  ),
                  child: controller.userImage == null
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    content: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: CachedNetworkImage(
                                        imageUrl: controller.userImage!,
                                        placeholder: (context, s) =>
                                            const Center(
                                                child: CircularProgressIndicator
                                                    .adaptive()),
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.all(0),
                                  );
                                });
                          },
                          child: CachedNetworkImage(
                              imageUrl: controller.userImage!,
                              fit: BoxFit.cover),
                        )),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 10,
            child: TextButton(
              onPressed: () {
                Logout_Widget.logout(context);
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                width: getProportionateScreenWidth(70),
                height: getProportionateScreenHeight(30),
                decoration: const BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    )),
                child: Row(
                  children: const [
                    Icon(
                      Icons.logout_rounded,
                      color: Colors.black,
                    ),
                    Text(
                      'Leave',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
