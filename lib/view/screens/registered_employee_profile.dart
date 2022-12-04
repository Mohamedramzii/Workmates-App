import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:work_os/controller/UserData_Controller.dart';
import 'package:work_os/utils/size_config.dart';

class Registered_Employee_Profile_Screen extends GetView<UserData_Controller> {
  final String name;
  final String id;
  final String job;
  final String joinedAt;
  final String email;
  final String phoneNumber;
  final String imageUrl;

  Registered_Employee_Profile_Screen(
      {super.key,
      required this.name,
      required this.id,
      required this.job,
      required this.joinedAt,
      required this.email,
      required this.phoneNumber,
      required this.imageUrl});

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
        children: [
          Container(
            width: double.infinity,
            height: getProportionateScreenHeight(300),
            decoration: const BoxDecoration(
                color: Colors.lightGreen,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(100),
                  bottomRight: Radius.circular(100),
                )),
          ),
          Align(
            alignment: const Alignment(0, -0.3),
            child: Column(
              children: [
                SizedBox(
                  height: getProportionateScreenHeight(80),
                ),
                Container(
                  width: getProportionateScreenWidth(300),
                  height: getProportionateScreenHeight(450),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: GestureDetector(
                    onTap:(){
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
                                imageUrl: imageUrl,
                                placeholder: (context, s) => const Center(
                                    child:
                                        CircularProgressIndicator.adaptive()),
                              ),
                            ),
                            contentPadding: const EdgeInsets.all(0),
                          );
                        });
                    },
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: CachedNetworkImage(
                          placeholder: (ctx, name) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          imageUrl: imageUrl,
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth:getProportionateScreenWidth(250),
                  ),
                  child: Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.quicksand(
                        textStyle: const TextStyle(
                            fontSize: 35, fontWeight: FontWeight.bold)),
                  ),
                ),
                Text(
                  job,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.quicksand(
                      textStyle: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold)),
                ),
                Text(
                  'Joined Since:',
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.quicksand(
                      textStyle: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                Text(
                  joinedAt,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.quicksand(
                      textStyle: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          _sendMail(email: email);
                        },
                        icon: const Icon(
                          Icons.mail,
                          size: 40,
                          color: Colors.blue,
                        )),
                    SizedBox(
                      width: getProportionateScreenWidth(15),
                    ),
                    IconButton(
                        onPressed: () {
                          _openWhatsapp(phoneNumber: phoneNumber);
                        },
                        icon: const Icon(
                          Icons.whatsapp,
                          size: 40,
                          color: Colors.green,
                        )),
                    SizedBox(
                      width: getProportionateScreenWidth(15),
                    ),
                    IconButton(
                        onPressed: () {
                          _callsomeone(phoneNumber: phoneNumber);
                        },
                        icon: const Icon(
                          Icons.call,
                          size: 40,
                          color: Colors.purple,
                        )),
                  ],
                ),
              ],
            ),
          ),
        ],
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

  _callsomeone({required phoneNumber}) async {
    // String phoneNumber = '01091650763';
    var url = 'tel:/$phoneNumber';
    await launchUrl(Uri.parse(url));
  }
}
