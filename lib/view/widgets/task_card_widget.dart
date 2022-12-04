import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:work_os/routes/routes.dart';
import 'package:work_os/utils/size_config.dart';

import '../screens/Task/task_details.dart';

class Task_Card_widget extends StatelessWidget {
  final String title;
  final String taskowner;
  final String taskownerjob;
  final String description;
  final String id;
  final String uploadedby;
  final String taskOwnerImageUrl;
  final bool isDone;
  String createdAt;
  final String taskdeadlinedate;
  final Timestamp taskdeadlineTimestampdate;
  Task_Card_widget({
    Key? key,
    required this.title,
    required this.description,
    required this.id,
    required this.uploadedby,
    required this.isDone,
    required this.taskowner,
    required this.taskownerjob,
    required this.createdAt,
    required this.taskdeadlinedate,
    required this.taskdeadlineTimestampdate,
    required this.taskOwnerImageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Card(
      elevation: 10,
      margin: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(10),
          vertical: getProportionateScreenHeight(10)),
      child: ListTile(
        onTap: () {
          Get.to(() => task_Details(
                taskId: id,
                taskOwner: taskowner,
                uploadedBy: uploadedby,
                taskTitle: title,
                jobtitle: taskownerjob,
                taskDescription: description,
                isDone: isDone,
                deadlineDate: taskdeadlinedate,
                createdAtDate: createdAt,
                taskdeadlineTimestampdate: taskdeadlineTimestampdate,
                taskOwnerImageUrl: taskOwnerImageUrl,
              ));
        },
        onLongPress: () {
          Get.defaultDialog(
              title: '',
              content: const Text(
                  'You are going to delete your task,\n Are you sure?',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20)),
              textCancel: 'No',
              onCancel: () {
                Get.offAndToNamed(Routes.homeScreen);
              },
              cancelTextColor: Colors.black,
              textConfirm: 'Yes Delete',
              onConfirm: () {
                final currentUser = FirebaseAuth.instance.currentUser!.uid;
                if (currentUser == uploadedby) {
                  FirebaseFirestore.instance
                      .collection('tasks')
                      .doc(id)
                      .delete();
                } else {
                  Fluttertoast.showToast(
                      msg: 'Sorry,you don\'t have access to delete this task',
                      fontSize: 20);
                }

                Get.back();
              },
              confirmTextColor: Colors.black,
              buttonColor: Colors.red,
              contentPadding: const EdgeInsetsDirectional.all(20));
        },
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        leading: Container(
          padding: EdgeInsets.only(
            right: getProportionateScreenWidth(15),
          ),
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(width: getProportionateScreenWidth(1)),
            ),
          ),
          child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 30,
              child: isDone
                  ? Image.asset('assets/images/check.png')
                  : Image.asset('assets/images/wait.png')),
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 25),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: getProportionateScreenHeight(15),
            ),
            Text(
              description,
              style: const TextStyle(fontSize: 20, color: Colors.grey),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios_rounded),
      ),
    );
  }
}
