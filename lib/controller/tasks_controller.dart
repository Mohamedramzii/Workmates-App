import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:work_os/controller/UserData_Controller.dart';

class Tasks_controller extends GetxController {
  UserData_Controller usercontroller = Get.find();
  TextEditingController taskdate = TextEditingController();
  TextEditingController taskCategory = TextEditingController();
  TextEditingController comment_controller = TextEditingController();
  String? taskTitle, taskDescription, taskid;
  String? selectedtaskcategory;

  bool filterischecked = false;
  bool taskisuploading = false;
  bool tasksloading = false;

  final CollectionReference<Map<String, dynamic>> _taskRef =
      FirebaseFirestore.instance.collection('tasks');
  final String user = FirebaseAuth.instance.currentUser!.uid;

  Stream<QuerySnapshot<Map<String, dynamic>>> tasks =
      FirebaseFirestore.instance.collection('tasks').snapshots();

  @override
  void onClose() {
    taskdate.dispose();
    taskCategory.dispose();
    comment_controller.dispose();
    super.onClose();
  }

//------------------------------------------------------------------

  List<String> tasksCategoryList = [
    'Business',
    'Programming',
    'Information Technlogy',
    'Computer Sciences',
    'HR Cases',
    'Information Systems'
  ];

//--------------------------------------------------------------------
  DateTime? pickedDate;
  Timestamp? deadlineDateTimestamp;
  pickTime(context) async {
    pickedDate = await showDatePicker(
        helpText: 'Choose a Date',
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now().subtract(const Duration(days: 0)),
        lastDate: DateTime(2100));

    if (pickedDate == null) {
      taskdate.text = 'PLEASE CHOOSE A DEADLINE DATE !!';
    } else {
      deadlineDateTimestamp = Timestamp.fromMicrosecondsSinceEpoch(
          pickedDate!.microsecondsSinceEpoch);
      taskdate.text =
          '${pickedDate!.day}-${pickedDate!.month}-${pickedDate!.year}';
    }
    update();
  }

  AddtaskToFireStore() async {
    var taskID = const Uuid().v4();
    taskisuploading = true;
    Timestamp createdAt = Timestamp.now();
    var formattedTaskcreatedatDate = createdAt.toDate();
    var TaskcreatedatDate =
        '${formattedTaskcreatedatDate.day}-${formattedTaskcreatedatDate.month}-${formattedTaskcreatedatDate.year}-';
    await _taskRef.doc(taskID).set({
      'task_id': taskID,
      'taskOwnerImageUrl': usercontroller.userImage,
      'taskOwner': usercontroller.username,
      'taskOwnerJob': usercontroller.companyPosition,
      'uploadedBy': user,
      'task_category': taskCategory.text,
      'task_title': taskTitle,
      'task_description': taskDescription,
      'task_deadline_date': taskdate.text,
      'task_deadline_date_timestamp': deadlineDateTimestamp,
      'task_comments': [],
      'isDone': false,
      'createdAt': TaskcreatedatDate,
    });
    taskisuploading = false;
    update();
  }
}
