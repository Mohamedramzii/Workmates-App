import 'package:get/get.dart';
import 'package:work_os/controller/Authentication.dart';
import 'package:work_os/controller/UserData_Controller.dart';
import 'package:work_os/controller/tasks_controller.dart';
import 'package:work_os/controller/backgroundController.dart';
import 'package:work_os/controller/task_details_controller.dart';

class binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AnimationBackground_Controller(), fenix: true);
    Get.lazyPut(() => Authentication_Controller(), fenix: true);
    Get.lazyPut(() => Tasks_controller(), fenix: true);
    Get.lazyPut(() => Task_Details_Controller(), fenix: true);
    Get.lazyPut(() => UserData_Controller(), fenix: true);
  }
}
