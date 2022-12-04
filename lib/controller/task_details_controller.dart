import 'package:get/get.dart';

class Task_Details_Controller extends GetxController {
  bool isCommenting = false;

  visiblity() {
    isCommenting = !isCommenting;
    update();
  }

  // refresh() {
  //   update();
  // }

  // getTaskDetails() async {
  //   final DocumentSnapshot taskData = await FirebaseFirestore.instance
  //       .collection('tasks')
  //       .doc(controller.taskid)
  //       .get();
  //   if (taskData == null) {
  //     return;
  //   } else {
  //     bool isDone;
  //     Timestamp? PostcreatedAtTimestamp;
  //     bool isDeadlineDateFinished = false;

  //     controller.taskid = taskData.get('task_id');
  //     controller.taskTitle = taskData.get('task_title');
  //     controller.taskDescription = taskData.get('task_description');
  //     isDone = taskData.get('isDone');
  //     //----------------------------
  //     PostcreatedAtTimestamp = taskData.get('createdAt');
  //     var formattedCreatedAtDate = PostcreatedAtTimestamp!.toDate();
  //     formattedCreatedAtDate =
  //         '${formattedCreatedAtDate.day}-${formattedCreatedAtDate.month}${formattedCreatedAtDate.year}'
  //             as DateTime;
  //     //-------------------------------
  //     //-------------------------------
  //     controller.deadlineDateTimestamp =
  //         taskData.get('task_deadline_date_timestamp');
  //     var formattedDeadlineDate = controller.deadlineDateTimestamp!.toDate();
  //     formattedDeadlineDate =
  //         '${formattedDeadlineDate.day}-${formattedDeadlineDate.month}${formattedDeadlineDate.year}'
  //             as DateTime;
  //     //--------------------------------
  //     controller.taskdate.text = taskData.get('task_deadline_date');
  //     isDeadlineDateFinished = formattedDeadlineDate.isAfter(DateTime.now());
  //   }
  // }
}
