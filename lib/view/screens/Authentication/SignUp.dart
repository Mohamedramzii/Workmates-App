import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../controller/Authentication.dart';
import '../../../controller/backgroundController.dart';
import '../../../routes/routes.dart';
import '../../../utils/form_validations.dart';
import '../../../utils/size_config.dart';
import '../../widgets/common/Custom_Button.dart';
import '../../widgets/common/Custom_form_Field.dart';

class SigUp_Screen extends StatelessWidget {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final Authentication_Controller auth_controller = Get.find();

  SigUp_Screen({Key? key}) : super(key: key);

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
              child: Image.asset(
                'assets/images/login2.jpg',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                alignment: FractionalOffset(controller.animation.value, 0),
              ),
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
                        Text('SignUP',
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
                            Text('Already have an account?',
                                style: GoogleFonts.alegreyaSans(
                                    textStyle: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 23,
                                        letterSpacing: 5,
                                        fontWeight: FontWeight.bold))),
                            GestureDetector(
                              onTap: () {
                                Get.offNamed(Routes.loginScreen);
                              },
                              child: Text('Login',
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
                              Row(
                                children: [
                                  Flexible(
                                    child: Custom_form_Field(
                                      lefticon: const Icon(
                                        Icons.person,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                      righticon: const SizedBox(
                                        height: 0,
                                        width: 0,
                                      ),
                                      keyboardtype: TextInputType.text,
                                      label: 'Username',
                                      hintText: 'Enter Your username',
                                      obscure: false,
                                      onsave: (value) {
                                        auth_controller.name = value!.trim();
                                      },
                                      onvalidate: (value) {
                                        if (value!.length < 3) {
                                          return 'Enter a valid username';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: getProportionateScreenWidth(5),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: const Text(
                                                  'Add your image using:'),
                                              content: GetBuilder<
                                                  Authentication_Controller>(
                                                builder: (controller) => Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    // const Divider(
                                                    //   color: Colors.black,
                                                    // ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        controller.pickAnImage(
                                                            ImageSource.camera);
                                                        Get.back();
                                                      },
                                                      child: Row(
                                                        children: [
                                                          const Icon(
                                                            Icons
                                                                .camera_alt_rounded,
                                                            color: Colors.green,
                                                          ),
                                                          SizedBox(
                                                            width:
                                                                getProportionateScreenWidth(
                                                                    8),
                                                          ),
                                                          const Text(
                                                            'Camera',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .green,
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          getProportionateScreenHeight(
                                                              13),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        controller.pickAnImage(
                                                            ImageSource
                                                                .gallery);
                                                        Get.back();
                                                      },
                                                      child: Row(
                                                        children: [
                                                          const Icon(
                                                            Icons.image_rounded,
                                                            color: Colors.green,
                                                          ),
                                                          SizedBox(
                                                            width:
                                                                getProportionateScreenWidth(
                                                                    8),
                                                          ),
                                                          const Text(
                                                            'Gallery',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .green,
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          });
                                    },
                                    child: Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          Container(
                                            width:
                                                getProportionateScreenWidth(80),
                                            height:
                                                getProportionateScreenHeight(
                                                    80),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                  color: Colors.green,
                                                  width: 3),
                                            ),
                                            child: auth_controller.imageFile ==
                                                    null
                                                ? Image.asset(
                                                    'assets/images/man.png',
                                                    fit: BoxFit.cover,
                                                  )
                                                : ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    child: Image.file(
                                                      auth_controller
                                                          .imageFile!,
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                          ),
                                          Positioned(
                                            right: -6,
                                            top: -10,
                                            child: Container(
                                              alignment: Alignment.center,
                                              width:
                                                  getProportionateScreenWidth(
                                                      25),
                                              height:
                                                  getProportionateScreenHeight(
                                                      25),
                                              decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50)),
                                              child: Icon(
                                                auth_controller.imageFile ==
                                                        null
                                                    ? Icons.add_a_photo
                                                    : Icons.edit,
                                                color: Colors.green,
                                              ),
                                            ),
                                          )
                                        ]),
                                  ),
                                  SizedBox(
                                    width: getProportionateScreenWidth(4),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: size.height * 0.04,
                              ),
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
                                height: size.height * 0.04,
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
                                  keyboardtype: TextInputType.visiblePassword,
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
                                height: size.height * 0.04,
                              ),
                              Custom_form_Field(
                                lefticon: const Icon(
                                  Icons.work,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                righticon: const SizedBox(
                                  height: 0,
                                  width: 0,
                                ),
                                keyboardtype: TextInputType.text,
                                label: 'Company Position',
                                hintText: 'Enter Your Company Position',
                                obscure: false,
                                onsave: (value) {
                                  auth_controller.companyPosition =
                                      value!.trim();
                                },
                                onvalidate: (value) {
                                  if (value!.length < 2) {
                                    return 'Enter a valid company position';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: size.height * 0.04,
                              ),
                              Custom_form_Field(
                                textInputAction: TextInputAction.done,
                                lefticon: const Icon(
                                  Icons.phone_android_rounded,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                righticon: const SizedBox(
                                  height: 0,
                                  width: 0,
                                ),
                                keyboardtype: TextInputType.phone,
                                label: 'Phone Number',
                                hintText: 'Enter Your Phone Number',
                                obscure: false,
                                onsave: (value) {
                                  auth_controller.phonenumber = value!.trim();
                                },
                                onvalidate: (value) {
                                  if (value!.length < 2) {
                                    return 'Enter a valid phone number';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: size.height * 0.03,
                              ),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                child: auth_controller.isLoading
                                    ? Container(
                                        width: getProportionateScreenWidth(70),
                                        height:
                                            getProportionateScreenHeight(50),
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
                                          if (auth_controller.imageFile ==
                                              null) {
                                            return Get.defaultDialog(
                                                title: 'Error Occurred',
                                                middleText:
                                                    'Please Upload a beautiful photo of you.');
                                          }
                                          if (formkey.currentState!
                                              .validate()) {
                                            formkey.currentState!.save();
                                            FocusScope.of(context).unfocus();

                                            //SignIn
                                            auth_controller.SignUp();
                                          }
                                        },
                                      ),
                              ),
                              SizedBox(
                                height: size.height * 0.04,
                              ),
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
