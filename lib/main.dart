import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:work_os/bindings/main_binding.dart';
import 'package:work_os/routes/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final Future<FirebaseApp> _appinitialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _appinitialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MaterialApp(
              home: Scaffold(
                body: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(),
                    Text('Loading',style:TextStyle(fontSize: 25))
                  ],
                )),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset('assets/images/deadline.json'),
                  const Text('An Error is occurred',style:TextStyle(fontSize: 25,color: Colors.red)),
                ],
              ),
            );
          } else {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Work OS',
              theme: ThemeData(
                // primarySwatch: Colors.transparent,
                backgroundColor: Colors.grey.shade300,
              ),
              initialRoute: FirebaseAuth.instance.currentUser != null
                  ? AppRoutes.homeScreen
                  : AppRoutes.loginScreen,
              getPages: AppRoutes.pages,
              initialBinding: binding(),
            );
          }
        });
  }
}
