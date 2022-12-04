import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:work_os/controller/tasks_controller.dart';
import 'package:work_os/routes/routes.dart';
import 'package:work_os/utils/size_config.dart';
import 'package:work_os/view/widgets/common/Custom_Button.dart';

import '../../widgets/common/Custom_Text_Form_for_TaskScreen.dart';

class Add_Task_Screen extends GetView<Tasks_controller> {
  Add_Task_Screen({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Tasks_controller controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        margin: EdgeInsets.symmetric(
            vertical: getProportionateScreenHeight(50),
            horizontal: getProportionateScreenWidth(10)),
        child: SingleChildScrollView(
          child: Card(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Column(
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            Get.offAllNamed(Routes.homeScreen);
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            size: 30,
                          )),
                      SizedBox(
                        width: getProportionateScreenWidth(110),
                      ),
                      Text(
                        'Add Task',
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                            decoration: TextDecoration.underline),
                      ),
                    ],
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        GetBuilder<Tasks_controller>(
                          builder: (controller) => GestureDetector(
                            onTap: () {
                              Get.defaultDialog(
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: const Text(
                                          'Close',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black),
                                        ))
                                  ],
                                  radius: 30,
                                  title: 'Select what you want to see',
                                  titleStyle: GoogleFonts.playfairDisplay(
                                      textStyle: const TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 23)),
                                  content: SizedBox(
                                    width: getProportionateScreenWidth(250),
                                    height: getProportionateScreenHeight(290),
                                    child: ListView.separated(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount:
                                          controller.tasksCategoryList.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            controller.taskCategory.text =
                                                controller
                                                    .tasksCategoryList[index];
                                            Get.back();
                                          },
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width:
                                                    getProportionateScreenWidth(
                                                        7),
                                              ),
                                              const Icon(Icons.check_circle,
                                                  color: Colors.green,
                                                  size: 30),
                                              SizedBox(
                                                width:
                                                    getProportionateScreenWidth(
                                                        7),
                                              ),
                                              Text(
                                                  controller
                                                      .tasksCategoryList[index],
                                                  style: GoogleFonts.aleo(
                                                      textStyle:
                                                          const TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))),
                                            ],
                                          ),
                                        );
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return SizedBox(
                                          height:
                                              getProportionateScreenHeight(10),
                                        );
                                      },
                                    ),
                                  ));
                            },
                            child: Custom_Text_Form_for_TaskScreen(
                              controller: controller.taskCategory,
                              enabled: false,
                              textInputAction: TextInputAction.next,
                              text: 'Task Category',
                              hintText: 'Choose your task\'s category',
                              // maxlength: 100,
                              // maxlines: 1,
                              onsave: (String? newValue) {
                                controller.taskCategory.text = newValue!.trim();
                              },
                              onvalidate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Task category field is required*';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        Custom_Text_Form_for_TaskScreen(
                          textInputAction: TextInputAction.next,
                          text: 'Task Title',
                          hintText: 'Add title for your task',
                          maxlength: 100,
                          maxlines: 1,
                          onsave: (String? newValue) {
                            controller.taskTitle = newValue!.trim();
                          },
                          onvalidate: (String? value) {
                            if (value!.isEmpty) {
                              return 'Task title field is required*';
                            }
                            return null;
                          },
                        ),
                        Custom_Text_Form_for_TaskScreen(
                          textInputAction: TextInputAction.next,
                          text: 'Task Description',
                          hintText: 'Add description for your task',
                          maxlength: 1000,
                          maxlines: 5,
                          onsave: (String? newValue) {
                            controller.taskDescription = newValue!.trim();
                          },
                          onvalidate: (String? value) {
                            if (value!.isEmpty) {
                              return 'Task description field is required*';
                            }
                            return null;
                          },
                        ),
                        GetBuilder<Tasks_controller>(
                          builder: (controller) => GestureDetector(
                            onTap: () {
                              controller.pickTime(context);
                            },
                            child: Custom_Text_Form_for_TaskScreen(
                              controller: controller.taskdate,
                              enabled: false,
                              textInputAction: TextInputAction.send,
                              text: 'Deadline Date',
                              hintText: 'Add a deadline date for your task',
                              // maxlength: 100,
                              // maxlines: 1,
                              onsave: (String? newValue) {
                                controller.taskdate.text = newValue!.trim();
                              },
                              onvalidate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Task deadline date field is required*';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        controller.taskisuploading
                            ? Container(
                                width: getProportionateScreenWidth(70),
                                height: getProportionateScreenHeight(50),
                                margin: const EdgeInsets.all(10),
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.green),
                                child: const Center(
                                    child: CircularProgressIndicator(
                                  color: Colors.black,
                                )),
                              )
                            : Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: getProportionateScreenHeight(20)),
                                child: Custom_Button(
                                    width: getProportionateScreenWidth(140),
                                    height: getProportionateScreenHeight(60),
                                    color: Colors.green,
                                    text: 'Add Task',
                                    fontsize: 20,
                                    textcolor: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    ontap: () {
                                      if (controller
                                              .taskCategory.text.isEmpty ||
                                          controller.taskTitle!=null ||
                                          controller.taskDescription!=null ||
                                          controller.taskdate.text.isEmpty) {
                                        return Fluttertoast.showToast(
                                          msg: 'All Fields are required',
                                          toastLength: Toast.LENGTH_LONG,
                                          fontSize: 30,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.black,
                                          gravity: ToastGravity.SNACKBAR
                                        );
                                      }
                                      if (_formKey.currentState!.validate()) {
                                        _formKey.currentState!.save();
                                        FocusScope.of(context).unfocus();
                                        //upload to firestore
                                        controller.AddtaskToFireStore();
                                      }
                                      Get.offAllNamed(Routes.homeScreen);
                                      // controller.getTasksFromFirestore();
                                    }),
                              )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
