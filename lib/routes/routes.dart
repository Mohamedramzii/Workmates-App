// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';
import 'package:work_os/view/screens/Account_profile.dart';
import 'package:work_os/view/screens/Authentication/Forgot_Password.dart';
import 'package:work_os/view/screens/Authentication/Login.dart';
import 'package:work_os/view/screens/Task/add_task_screen.dart';
import 'package:work_os/view/screens/Task/task_details.dart';
import 'package:work_os/view/screens/registered_employee_profile.dart';
import 'package:work_os/view/screens/registered_employees.dart';

import '../view/screens/Authentication/SignUp.dart';
import '../view/screens/home_screen.dart';

class AppRoutes {
  //initial Route
  static const loginScreen = Routes.loginScreen;
  static const homeScreen = Routes.homeScreen;
  //Pages
  static final pages = [
    GetPage(name: Routes.homeScreen, page: () => Home_Screen()),
    GetPage(name: Routes.loginScreen, page: () => Login_Screen()),
    GetPage(name: Routes.signupScreen, page: () => SigUp_Screen()),
    GetPage(
        name: Routes.forgotPasswordScreen, page: () => ForgotPassword_screen()),
    GetPage(name: Routes.addTaskScreen, page: () => Add_Task_Screen()),
    GetPage(name: Routes.registered_Employees_Screen, page: () =>  Registered_Employees_Screen()),
    GetPage(name: Routes.account_profile_Screen, page: () =>  Account_Profile_Screen()),
    // GetPage(name: Routes.registered_Employees_profile_Screen, page: () =>  Registered_Employee_Profile_Screen()),
    // GetPage(name: Routes.task_details_Screen, page: () =>  task_Details()),
  ];
}

class Routes {
  static const homeScreen = '/homeScreen';
  static const loginScreen = '/loginScreen';
  static const signupScreen = '/signupScreen';
  static const forgotPasswordScreen = '/forgotPasswordScreen';
  static const addTaskScreen = '/addTaskScreen';
  static const registered_Employees_Screen = '/registered_Employees_Screen';
  static const registered_Employees_profile_Screen = '/registered_Employees_profile_Screen';
  static const account_profile_Screen = '/account_profile_Screen';
  static const task_details_Screen = '/task_details_Screen';
}
