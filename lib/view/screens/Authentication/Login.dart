import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:work_os/controller/Authentication.dart';
import 'package:work_os/utils/size_config.dart';

import '../../../controller/backgroundController.dart';
import '../../../routes/routes.dart';
import '../../../utils/form_validations.dart';
import '../../widgets/common/Custom_Button.dart';
import '../../widgets/common/Custom_form_Field.dart';

class Login_Screen extends StatelessWidget {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final Authentication_Controller auth_controller = Get.find();
  Login_Screen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      body: GetBuilder<AnimationBackground_Controller>(
        builder: (controller) => Stack(
          children: [
            Center(
              child: Image.asset('assets/images/login2.jpg',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  alignment: FractionalOffset(controller.animation.value, 0)),
            ),
            ListView(children: [
              Container(
                width: size.width * 0.95,
                height: size.height * 0.90,
                margin: EdgeInsets.only(
                    left: size.width * 0.04,
                    right: size.width * 0.04,
                    top: size.height * 0.05),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.transparent.withOpacity(0.6)),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: size.width * 0.05,
                      top: size.height * 0.06,
                      right: size.width * 0.05),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Login',
                            style: GoogleFonts.aclonica(
                                textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 40,
                                    letterSpacing: 5,
                                    fontWeight: FontWeight.bold))),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Don\'t have an account?',
                                style: GoogleFonts.alegreyaSans(
                                    textStyle: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 23,
                                        letterSpacing: 5,
                                        fontWeight: FontWeight.bold))),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.signupScreen);
                              },
                              child: Text('SignUp',
                                  style: GoogleFonts.alegreyaSans(
                                      textStyle: const TextStyle(
                                          color: Colors.green,
                                          fontSize: 23,
                                          letterSpacing: 3,
                                          // decoration: TextDecoration.underline,
                                          fontWeight: FontWeight.bold))),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.08,
                        ),
                        Form(
                          key: formkey,
                          child: Column(
                            children: [
                              Custom_form_Field(
                                // ignore: prefer_const_constructors
                                lefticon: Icon(
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
                                  if (!RegExp(validationEmail)
                                      .hasMatch(value!)) {
                                    return 'Enter a valid email address';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: size.height * 0.05,
                              ),
                              GetBuilder<Authentication_Controller>(
                                builder: (authController) => Custom_form_Field(
                                  lefticon: const Icon(
                                    Icons.lock,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  righticon: IconButton(
                                    color: Colors.white,
                                    icon: authController.isvisible == true
                                        ? const Icon(Icons.visibility)
                                        : const Icon(Icons.visibility_off),
                                    onPressed: () {
                                      authController.PasswordVisibility();
                                    },
                                  ),
                                  keyboardtype: TextInputType.emailAddress,
                                  label: 'Password',
                                  hintText: 'Enter Your Password',
                                  obscure: authController.isvisible == true
                                      ? false
                                      : true,
                                  onsave: (value) {
                                    authController.password = value!.trim();
                                  },
                                  onvalidate: (value) {
                                    if (value!.length < 8) {
                                      return 'Password must be at least 8 characters';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.006,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.toNamed(Routes.forgotPasswordScreen);
                                    },
                                    child: Text('Forgot Password?',
                                        textAlign: TextAlign.end,
                                        style: GoogleFonts.alegreyaSans(
                                            textStyle: const TextStyle(
                                                color: Colors.green,
                                                fontSize: 20,
                                                decoration:
                                                    TextDecoration.underline,
                                                letterSpacing: 2,
                                                fontWeight: FontWeight.bold))),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: size.height * 0.07,
                              ),
                              auth_controller.isLoading
                                  ? Container(
                                      width: getProportionateScreenWidth(70),
                                      height: getProportionateScreenHeight(50),
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.green),
                                      child: const Center(
                                          child: CircularProgressIndicator(
                                        color: Colors.black,
                                      )),
                                    )
                                  : Custom_Button(
                                      width: SizeConfig.orientation ==
                                              Orientation.portrait
                                          ? getProportionateScreenWidth(220)
                                          : 0,
                                      height: SizeConfig.orientation ==
                                              Orientation.portrait
                                          ? getProportionateScreenHeight(65)
                                          : 0,
                                      color: Colors.green,
                                      text: 'Start Working..',
                                      fontsize: 25,
                                      fontWeight: FontWeight.bold,
                                      textcolor: Colors.black,
                                      ontap: () {
                                        if (formkey.currentState!.validate()) {
                                          formkey.currentState!.save();
                                          FocusScope.of(context).unfocus();
                                          //SignIn
                                          auth_controller.SignIn();
                                        }
                                      },
                                    ),
                              SizedBox(
                                height: size.height * 0.04,
                              ),
                              Text('Or continue with',
                                  style: GoogleFonts.aclonica(
                                      textStyle: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          letterSpacing: 5,
                                          fontWeight: FontWeight.bold))),
                              SizedBox(
                                height: size.height * 0.03,
                              ),
                              GestureDetector(
                                onTap: (){
                                  // auth_controller.googleSignInMethod();
                                },
                                child: Container(
                                  width: 70,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: Colors.transparent.withOpacity(0.3),
                                  ),
                                  child: Image.asset(
                                    'assets/images/google.png',
                                    width: 50,
                                    height: 30,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }
}
