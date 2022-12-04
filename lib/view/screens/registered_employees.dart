import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:work_os/controller/UserData_Controller.dart';

import 'package:work_os/utils/size_config.dart';
import 'package:work_os/view/screens/registered_employee_profile.dart';

import '../../routes/routes.dart';

class Registered_Employees_Screen extends StatelessWidget {
  Registered_Employees_Screen({super.key});
  final UserData_Controller controller = Get.find();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: context.theme.backgroundColor,
        iconTheme: const IconThemeData(
          color: Colors.black,
          size: 35,
        ),
        // leading: IconButton(
        //     onPressed: () {
        //       Get.toNamed(Routes.homeScreen);
        //     },
        //     icon: const Icon(
        //       Icons.arrow_back_rounded,
        //       color: Colors.black,
        //       size: 34,
        //     )),
        title: Text('Your Workmates',
            style: GoogleFonts.playfairDisplay(
                textStyle: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25))),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: controller.users,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.active) {
            var data = snapshot.data!.docs;
            if (data.isNotEmpty) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return  controller.user == data[index]['id']
                      ? Container()
                      :  GestureDetector(
                          onTap: () async {
                            String user =
                                FirebaseAuth.instance.currentUser!.uid;
                            final DocumentSnapshot userInfo =
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(user)
                                    .get();
                            Timestamp fetchDate = userInfo.get('created_at');
                            var dateformat = fetchDate.toDate();
                            var joinedAt =
                                '${dateformat.day}-${dateformat.month}-${dateformat.year}';
                            Get.to(() => Registered_Employee_Profile_Screen(
                                  name: data[index]['name'],
                                  id: data[index]['id'],
                                  job: data[index]['company_position'],
                                  joinedAt: joinedAt,
                                  email: data[index]['email'],
                                  phoneNumber: data[index]['phone_number'],
                                  imageUrl: data[index]['imageURL'],
                                ));
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: getProportionateScreenHeight(30),
                                horizontal: getProportionateScreenWidth(13)),
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  width: double.infinity,
                                  height: getProportionateScreenHeight(130),
                                  decoration: BoxDecoration(
                                    color: Colors.white70,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: getProportionateScreenHeight(8),
                                        left: getProportionateScreenWidth(70)),
                                    child: Column(
                                      children: [
                                        Text(data[index]['name'],
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.quicksand(
                                                textStyle: const TextStyle(
                                                    fontSize: 25,
                                                    fontWeight:
                                                        FontWeight.bold))),
                                        Text(data[index]['company_position'],
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.quicksand(
                                                textStyle: const TextStyle(
                                                    fontSize: 21,
                                                    fontWeight:
                                                        FontWeight.bold))),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                _sendMail(
                                                    email: data[index]
                                                        ['email']);
                                              },
                                              icon: const Icon(
                                                Icons.mail,
                                                size: 45,
                                              ),
                                            ),
                                            SizedBox(
                                              width:
                                                  getProportionateScreenWidth(
                                                      10),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                _openWhatsapp(
                                                    phoneNumber: data[index]
                                                        ['phone_number']);
                                              },
                                              icon: const Icon(
                                                Icons.whatsapp_outlined,
                                                color: Colors.green,
                                                size: 45,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: -35,
                                  left: -10,
                                  child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 60,
                                      backgroundImage: NetworkImage(
                                          data[index]['imageURL'])),
                                )
                              ],
                            ),
                          ),
                        );
                },
              );
            }
          }
          return const Center(
            child: Text('There are no registered Employees yet',
                style: TextStyle(fontSize: 50)),
          );
        },
      ),
    );
  }

  _openWhatsapp({required phoneNumber}) async {
    String text = 'Hello there..';
    // String phoneNumber = '01091650763';
    String url = 'https://wa.me/$phoneNumber?text=${Uri.encodeFull(text)}';

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw 'Could not launch $url';
    }

    // if (await canLaunchUrl(Uri.parse(url))) {
    //   await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    // }
  }

  _sendMail({required email}) async {
    // String email = 'mohamedramzii224@gmail.com';
    String url = 'mailto:$email';

    await launchUrl(
      Uri.parse(url),
      // mode: LaunchMode.externalApplication,
    );
  }
}
