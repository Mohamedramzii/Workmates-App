import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:work_os/utils/size_config.dart';
import 'package:work_os/view/widgets/common/Custom_Button.dart';
import 'package:work_os/view/widgets/common/Custom_form_Field.dart';

import '../../../controller/Authentication.dart';
import '../../../utils/form_validations.dart';

class ForgotPassword_screen extends StatelessWidget {
  ForgotPassword_screen({Key? key}) : super(key: key);
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final Authentication_Controller auth_controller = Get.find();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: SizeConfig.orientation == Orientation.portrait
                  ? getProportionateScreenHeight(25)
                  : 0,
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      color: Colors.white,
                      size: 30,
                    ))
              ],
            ),
            Center(
              child: Container(
                // width: size.width * 0.9,
                // height: size.height * 0.8,
                width: getProportionateScreenWidth(350),
                height: SizeConfig.orientation == Orientation.portrait
                    ? getProportionateScreenHeight(620)
                    : getProportionateScreenHeight(720),
                margin: EdgeInsets.only(top: size.height * 0.05),
                decoration: BoxDecoration(
                    color: Colors.grey.shade800.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20)),
                child: Column(children: [
                  SizedBox(
                    height: SizeConfig.orientation == Orientation.portrait
                        ? 0
                        : getProportionateScreenHeight(10),
                  ),
                  LottieBuilder.asset(
                    'assets/images/forgot.json',
                    width: size.width * 0.6,
                    height: size.height * 0.45,
                  ),
                  SizedBox(
                    height: SizeConfig.orientation == Orientation.portrait
                        ? 0
                        : getProportionateScreenHeight(10),
                  ),
                  Text('Reset Password',
                      style: GoogleFonts.aclonica(
                          textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              letterSpacing: 5,
                              fontWeight: FontWeight.bold))),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 35, left: 30, right: 30),
                    child: Form(
                      key: formKey,
                      child: Custom_form_Field(
                        textInputAction: TextInputAction.done,
                        lefticon: const Icon(
                          Icons.email,
                          color: Colors.white,
                          size: 30,
                        ),
                        righticon: const SizedBox(
                          height: 0,
                          width: 0,
                        ),
                        keyboardtype: TextInputType.emailAddress,
                        label: 'Email Address',
                        hintText: 'Enter Your Email Address',
                        obscure: false,
                        onsave: (value) {
                          auth_controller.email = value!.trim();
                        },
                        onvalidate: (value) {
                          if (!RegExp(validationEmail).hasMatch(value!)) {
                            return 'Enter a valid email address';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Custom_Button(
                      width: SizeConfig.orientation == Orientation.portrait
                          ? getProportionateScreenWidth(310)
                          : getProportionateScreenWidth(330),
                      height: SizeConfig.orientation == Orientation.portrait
                          ? getProportionateScreenHeight(55)
                          : getProportionateScreenHeight(85),
                      color: Colors.green,
                      text: 'Reset',
                      fontsize: 30,
                      textcolor: Colors.white,
                      fontWeight: FontWeight.bold,
                      ontap: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          FocusScope.of(context).unfocus();
                          //send email method
                        }
                      })
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
