// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:work_os/controller/tasks_controller.dart';
import 'package:work_os/routes/routes.dart';
import 'package:work_os/utils/size_config.dart';
import 'package:work_os/view/screens/Task/loading_filter.dart';
import 'package:work_os/view/widgets/task_card_widget.dart';

import '../widgets/Drawer_details.dart';

class Home_Screen extends GetWidget<Tasks_controller> {
  Home_Screen({Key? key}) : super(key: key);
  // final Tasks_controller  = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer_Details(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: context.theme.scaffoldBackgroundColor,
        // leading: Builder(
        //   builder: (ctx) => IconButton(
        //       onPressed: () {
        //         Scaffold.of(ctx).openDrawer();
        //       },
        //       icon: const Icon(Icons.menu, color: Colors.black)),
        // ),
        title: Text(
          'Tasks',
          style: GoogleFonts.playfairDisplay(
              textStyle: const TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 25)),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                controller.filterischecked;
                Get.defaultDialog(
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () {
                                Get.to(() => Loading_Screen(
                                      page: Routes.homeScreen,
                                    ));
                              },
                              child: Text(
                                'Ok',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                              )),
                          GetBuilder<Tasks_controller>(
                            builder: (controller) => TextButton(
                                onPressed: () {
                                  controller.selectedtaskcategory = null;
                                  Get.to(() => Loading_Screen(
                                        page: Routes.homeScreen,
                                      ));
                                },
                                child: Text(
                                  'Cancel Filters',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.red),
                                )),
                          ),
                        ],
                      )
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
                        itemCount: controller.tasksCategoryList.length,
                        itemBuilder: (context, index) {
                          return GetBuilder<Tasks_controller>(
                            builder: (_) => InkWell(
                              onTap: () {
                                controller.selectedtaskcategory =
                                    controller.tasksCategoryList[index];
                              },
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: getProportionateScreenWidth(7),
                                  ),
                                  const Icon(Icons.check_circle,
                                      color: Colors.green, size: 30),
                                  SizedBox(
                                    width: getProportionateScreenWidth(7),
                                  ),
                                  Text(controller.tasksCategoryList[index],
                                      style: GoogleFonts.aleo(
                                          textStyle: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold))),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: getProportionateScreenHeight(10),
                          );
                        },
                      ),
                    ));
              },
              icon: const Icon(
                Icons.filter_list,
                color: Colors.black,
              ))
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('tasks')
            // .orderBy('createdAt')
            .where('task_category', isEqualTo: controller.selectedtaskcategory)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(
                    color: Colors.green,
                  ),
                  Text('Please wait...'),
                ],
              ),
            );
          } else {
            var taskData = snapshot.data!.docs;
            if (taskData.isNotEmpty) {
              return ListView.builder(
                itemCount: taskData.length,
                itemBuilder: (context, index) {
                  return Task_Card_widget(
                    title: taskData[index]['task_title'],
                    description: taskData[index]['task_description'],
                    id: taskData[index]['task_id'],
                    uploadedby: taskData[index]['uploadedBy'],
                    taskOwnerImageUrl: taskData[index]['taskOwnerImageUrl'],
                    isDone: taskData[index]['isDone'],
                    taskowner: taskData[index]['taskOwner'],
                    taskownerjob: taskData[index]['taskOwnerJob'],
                    createdAt: taskData[index]['createdAt'],
                    taskdeadlinedate: taskData[index]['task_deadline_date'],
                    taskdeadlineTimestampdate: taskData[index]
                        ['task_deadline_date_timestamp'],
                  );
                },
              );
            }
          }
          return const Center(
            child:
                Text('There are no tasks yet', style: TextStyle(fontSize: 40)),
          );
        },
      ),
    );
  }
}
