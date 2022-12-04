// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:uuid/uuid.dart';

import 'package:work_os/controller/UserData_Controller.dart';
import 'package:work_os/controller/task_details_controller.dart';
import 'package:work_os/controller/tasks_controller.dart';
import 'package:work_os/routes/routes.dart';
import 'package:work_os/utils/size_config.dart';

import 'loading_filter.dart';

class task_Details extends StatelessWidget {
  final UserData_Controller user_Controller = Get.find();
  final Tasks_controller task_Controller = Get.find();

  final String? taskId;
  final String? taskOwner;
  final String? uploadedBy;
  final String? taskOwnerImageUrl;
  final String? taskTitle;
  final String? jobtitle;
  final String? taskDescription;
  bool? isDone;

  final String? deadlineDate;
  final String? createdAtDate;
  final Timestamp taskdeadlineTimestampdate;

  bool isDeadlineDateFinished = false;

  task_Details({
    required this.taskId,
    required this.taskOwner,
    required this.uploadedBy,
    required this.taskTitle,
    required this.jobtitle,
    required this.taskDescription,
    required this.isDone,
    required this.deadlineDate,
    required this.createdAtDate,
    required this.taskdeadlineTimestampdate,
    required this.taskOwnerImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    user_Controller.getUserData();
    var formattedDeadlinedate = taskdeadlineTimestampdate.toDate();
    isDeadlineDateFinished = formattedDeadlinedate.isAfter(DateTime.now());
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: context.theme.backgroundColor,
        title: Text(taskTitle!,
            style: GoogleFonts.playfairDisplay(
                textStyle: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25))),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black,
          size: 30,
        ),
      ),
      body: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(10),
            vertical: getProportionateScreenHeight(5)),
        child: ListView(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(8),
              vertical: getProportionateScreenHeight(10)),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Uploaded by:',
                  style: GoogleFonts.alice(
                      textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  )),
                ),
                user_Controller.user == uploadedBy
                    ? TextButton(
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection('tasks')
                              .doc(taskId)
                              .update({'isDone': true});
                          Get.to(() => Loading_Screen(page: Routes.homeScreen));
                          Fluttertoast.showToast(
                              msg:
                                  'Your task ( $taskTitle ) is selected to be done!');
                        },
                        child: const Text('Tap if Done',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 20,
                            )),
                      )
                    : Container()
              ],
            ),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
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
                                imageUrl: taskOwnerImageUrl!,
                                placeholder: (context, s) => const Center(
                                    child:
                                        CircularProgressIndicator.adaptive()),
                              ),
                            ),
                            contentPadding: const EdgeInsets.all(0),
                          );
                        });
                  },
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey.shade200,
                    backgroundImage: NetworkImage(taskOwnerImageUrl!),
                  ),
                ),
                Column(
                  children: [
                    GetBuilder<UserData_Controller>(
                      builder:(controller)=> ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: getProportionateScreenWidth(250),
                          // maxHeight: getProportionateScreenHeight(250)
                        ),
                        child: Text(
                            controller.isInfoChanged.value==true
                                ? controller.username
                                : taskOwner!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.quicksand(
                                textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 35))),
                      ),
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: getProportionateScreenWidth(300),
                        
                      ),
                      child: Text(jobtitle!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.quicksand(
                              textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25))),
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            Divider(
              indent: getProportionateScreenWidth(100),
              endIndent: getProportionateScreenWidth(100),
            ),
            SizedBox(
              height: getProportionateScreenHeight(8),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(createdAtDate!,
                    style: GoogleFonts.aBeeZee(
                        textStyle: const TextStyle(
                      fontSize: 20,
                      color: Colors.green,
                    ))),
                const Icon(
                  FontAwesomeIcons.arrowRightLong,
                  size: 35,
                ),
                Text(deadlineDate!,
                    style: GoogleFonts.aBeeZee(
                        textStyle: const TextStyle(
                      fontSize: 20,
                      color: Colors.red,
                    ))),
              ],
            ),
            SizedBox(
              height: getProportionateScreenHeight(8),
            ),
            isDeadlineDateFinished
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          //if current date is deadline date so text and its color must change
                          'Still have time',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.aBeeZee(
                              textStyle: const TextStyle(
                            fontSize: 20,
                            color: Colors.green,
                          ))),
                      LottieBuilder.asset(
                        'assets/images/clock.json',
                        width: getProportionateScreenWidth(45),
                        height: getProportionateScreenHeight(45),
                      )
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          //if current date is deadline date so text and its color must change
                          'Time Out',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.aBeeZee(
                              textStyle: const TextStyle(
                            fontSize: 20,
                            color: Colors.red,
                          ))),
                      LottieBuilder.asset(
                        'assets/images/deadline.json',
                        width: getProportionateScreenWidth(45),
                        height: getProportionateScreenHeight(45),
                      )
                    ],
                  ),
            SizedBox(
              height: getProportionateScreenHeight(8),
            ),
            Divider(
              indent: getProportionateScreenWidth(100),
              endIndent: getProportionateScreenWidth(100),
            ),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            Text(
              'Task State:',
              style: GoogleFonts.alice(
                  textStyle: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              )),
            ),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            isDone == true
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('DONE',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.aBeeZee(
                              textStyle: const TextStyle(
                            fontSize: 20,
                            color: Colors.green,
                          ))),
                      const Icon(FontAwesomeIcons.checkDouble,
                          color: Colors.green),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Not Done',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.aBeeZee(
                              textStyle: const TextStyle(
                            fontSize: 20,
                            color: Colors.red,
                          ))),
                      const Icon(
                        FontAwesomeIcons.x,
                        color: Colors.red,
                      )
                    ],
                  ),
            SizedBox(
              height: getProportionateScreenHeight(8),
            ),
            Divider(
              indent: getProportionateScreenWidth(100),
              endIndent: getProportionateScreenWidth(100),
            ),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            Text(
              'Task Description:',
              style: GoogleFonts.alice(
                  textStyle: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              )),
            ),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            Container(
              width: getProportionateScreenWidth(150),
              // height: getProportionateScreenHeight(120),
              padding: const EdgeInsets.all(8),
              color: Colors.grey.shade100,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: getProportionateScreenHeight(300),
                ),
                child: Text(
                  taskDescription!,
                  style: GoogleFonts.aBeeZee(
                      textStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  )),
                ),
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(8),
            ),
            Divider(
              indent: getProportionateScreenWidth(100),
              endIndent: getProportionateScreenWidth(100),
            ),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            GetBuilder<Task_Details_Controller>(
              builder: (controller) => AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: controller.isCommenting
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: TextField(
                                controller: task_Controller.comment_controller,
                                textInputAction: TextInputAction.done,
                                maxLength: 500,
                                maxLines: 6,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey.shade200,
                                  hintText: 'Add a comment...',
                                  hintStyle:
                                      const TextStyle(color: Colors.grey),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                  errorBorder: const OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: getProportionateScreenWidth(5),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                MaterialButton(
                                  onPressed: () async {
                                    if (task_Controller
                                            .comment_controller.text.length <
                                        2) {
                                      Fluttertoast.showToast(
                                          msg:
                                              'comment can\'t be less than two characters');
                                    } else {
                                      final commentID = const Uuid().v4();
                                      await FirebaseFirestore.instance
                                          .collection('tasks')
                                          .doc(taskId)
                                          .update({
                                        'task_comments': FieldValue.arrayUnion([
                                          {
                                            'userID': uploadedBy,
                                            'commentID': commentID,
                                            'commenter':
                                                user_Controller.username,
                                            'commenterJob':
                                                user_Controller.companyPosition,
                                            'commentBody': task_Controller
                                                .comment_controller.text,
                                            'commenterImage':
                                                user_Controller.userImage,
                                            'commentTime': Timestamp.now(),
                                          }
                                        ])
                                      });
                                      task_Controller.comment_controller
                                          .clear();
                                    }
                                  },
                                  color: Colors.green,
                                  child: const Icon(Icons.send),
                                ),
                                MaterialButton(
                                  onPressed: () {
                                    controller.visiblity();
                                  },
                                  color: Colors.white12,
                                  child: const Text(
                                    'Cancel',
                                  ),
                                ),
                              ],
                            )
                          ],
                        )
                      : MaterialButton(
                          onPressed: () {
                            controller.visiblity();
                          },
                          minWidth: getProportionateScreenWidth(150),
                          height: getProportionateScreenHeight(50),
                          color: Colors.green,
                          child: const Text(
                            'Add a comment',
                            style: TextStyle(fontSize: 18),
                          ),
                        )),
            ),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('tasks')
                    .doc(taskId)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (snapshot.data == null) {
                      return Container();
                    }
                  }
                  var commentData = snapshot.data!['task_comments'];

                  // var time=formattedcommentTime
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!['task_comments'].length,
                    itemBuilder: (context, index) {
                      var formattedcommentTime =
                          commentData[index]['commentTime'];
                      // formattedcommentTime=formattedcommentTime
                      return Column(
                        children: [
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.grey.shade200,
                                backgroundImage: NetworkImage(
                                    commentData[index]['commenterImage']),
                              ),
                              SizedBox(
                                width: getProportionateScreenWidth(5),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxWidth:
                                          getProportionateScreenWidth(300),
                                      minWidth:
                                          getProportionateScreenWidth(200),
                                    ),
                                    child: Text(commentData[index]['commenter'],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.quicksand(
                                            textStyle: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20))),
                                  ),
                                  Text(commentData[index]['commenterJob'],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.quicksand(
                                          textStyle: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15))),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(10),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey.shade100,
                              ),
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                    minWidth: getProportionateScreenWidth(50),
                                    maxHeight:
                                        getProportionateScreenHeight(300)),
                                child: Text(
                                  commentData[index]['commentBody'],
                                  style: GoogleFonts.aBeeZee(
                                      textStyle: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black45,
                                  )),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: getProportionateScreenHeight(15),
                      );
                    },
                  );
                })
          ],
        ),
      ),
    );
  }
}
