import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:work_os/controller/Authentication.dart';
import 'package:work_os/controller/UserData_Controller.dart';
import 'package:work_os/utils/size_config.dart';
import 'package:work_os/view/widgets/common/logout_widget.dart';

import '../../routes/routes.dart';
import 'common/Custom_List_Tile.dart';

class Drawer_Details extends StatelessWidget {
  Drawer_Details({super.key});
  final Authentication_Controller _auth_controller = Get.find();
  final UserData_Controller controller = Get.find();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Drawer(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              bottomRight: Radius.circular(350))),
      width: getProportionateScreenWidth(300),
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: CachedNetworkImage(
                    imageUrl: controller.userImage!,
                    width: getProportionateScreenWidth(60),
                    height: getProportionateScreenWidth(60),
                    fit: BoxFit.fill,
                    filterQuality: FilterQuality.high,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GetBuilder<UserData_Controller>(
                      builder:(controller)=> RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          TextSpan(
                              text: 'Hi,',
                              style: GoogleFonts.fasthand(
                                  textStyle: const TextStyle(fontSize: 25))),
                          const TextSpan(text: '  '),
                          TextSpan(
                              // text: _auth_controller.isSignedIn == false
                              //     ? _auth_controller.displayUserName.value
                              //     : controller.username,
                              text: controller.username,
                              style: GoogleFonts.merriweather(
                                  textStyle: const TextStyle(fontSize: 20))),
                        ]),
                      ),
                    ),
                    Text(controller.companyPosition,
                        style: GoogleFonts.merriweather(
                            textStyle: const TextStyle(
                                fontSize: 20, color: Colors.white)))
                  ],
                ),
              ],
            ),
          ),
          Custom_List_Tile(
            icon: Icons.add_task,
            text: 'Add Task',
            ontap: () {
              Get.toNamed(Routes.addTaskScreen);
            },
          ),
          Custom_List_Tile(
            icon: Icons.checklist_outlined,
            text: 'All Tasks',
            ontap: () {
              Get.offAllNamed(Routes.homeScreen);
            },
          ),
          Custom_List_Tile(
            icon: Icons.app_registration,
            text: 'Registered Employees',
            ontap: () {
              Get.toNamed(Routes.registered_Employees_Screen);
            },
          ),
          Custom_List_Tile(
            icon: Icons.settings,
            text: 'My Account',
            ontap: () {
              Get.toNamed(Routes.account_profile_Screen);
            },
          ),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          Divider(
            indent: getProportionateScreenWidth(80),
            endIndent: getProportionateScreenWidth(80),
            color: Colors.black26,
          ),
          Custom_List_Tile(
            icon: Icons.power_settings_new_outlined,
            text: 'Logout',
            ontap: () {
              Logout_Widget.logout(context);
            },
          ),
        ],
      ),
    );
  }
}
