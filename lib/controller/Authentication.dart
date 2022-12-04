import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:work_os/routes/routes.dart';

class Authentication_Controller extends GetxController {
// Variables for textforms
  String? email, password, name, phonenumber, companyPosition, imageUrl;

  bool isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // @override
  // void onInit() {
  //   displayUserName.value =
  //       (userProfile != null ? userProfile!.displayName : 'User')!;
  //   displayUserPhoto.value =
  //       (userProfile != null ? userProfile!.photoURL : '')!;
  //   displayUserEmail.value =
  //       (userProfile != null ? userProfile!.email : 'User@gmail.com')!;
  //   super.onInit();
  // }

//Variables for firebase
  var _googleSignIn = GoogleSignIn();
  var isSignedIn = false.obs;
  var googleAcc = Rx<GoogleSignInAccount?>(null);
  User? get userProfile => _auth.currentUser;

  var displayUserName = ''.obs;
  var displayUserEmail = ''.obs;
  var displayUserPhoto = ''.obs;

  void googleSignInMethod() async {
    try {
      googleAcc.value = await _googleSignIn.signIn();
      displayUserName.value = googleAcc.value!.displayName!;
      displayUserEmail.value =googleAcc.value!.email;
      displayUserPhoto.value=googleAcc.value!.photoUrl!;
      isSignedIn.value = true;
      
      update();
      Get.offAllNamed(Routes.homeScreen);
    } catch (e) {
      Get.snackbar(
        'Error occured',
        e.toString(),
        snackPosition: SnackPosition.TOP,
      );
    }
  }


//boolean variables
  bool isvisible = false;

//variables  for picking an image
  File? imageFile;
  pickAnImage(ImageSource source) async {
    XFile? PickedFile = await ImagePicker()
        .pickImage(source: source, maxHeight: 1080, maxWidth: 1080);
    if (PickedFile == null) {
      return Get.defaultDialog(
          title: 'Error Occurred',
          middleText: 'Please Upload a beautiful photo of you.');
    }
    imageFile = File(PickedFile.path);
    await _cropImage(imageFile);
    update();
  }

  _cropImage(File? imagefile) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imagefile!.path,
      compressFormat: ImageCompressFormat.png,
      compressQuality: 100,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
    update();
  }

//visible & not visible password METHOD
  PasswordVisibility() {
    isvisible = !isvisible;
    update();
  }

  void SignIn() async {
    isLoading = true;
    try {
      await _auth.signInWithEmailAndPassword(
          email: email!, password: password!);
      update();
      Get.offAllNamed(Routes.homeScreen);
    } on FirebaseAuthException catch (e) {
      String message = '$e';

      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided for that user.';
      }
      Get.defaultDialog(
        title: 'Error Occurred',
        titleStyle: const TextStyle(
            fontSize: 30, fontWeight: FontWeight.bold, color: Colors.red),
        middleText: message,
        middleTextStyle: const TextStyle(fontSize: 18),
        backgroundColor: Colors.grey.shade400,
      );
      isLoading = false;
      // Get.snackbar(
      //   '',
      //   message,
      //   titleText: const Text(
      //     'Error',
      //     style: TextStyle(fontSize: 20, color: Colors.red),
      //   ),
      //   messageText: Text(
      //     message,
      //     style: const TextStyle(fontSize: 17, color: Colors.red),
      //   ),
      //   colorText: Colors.black,
      //   icon: const Icon(
      //     Icons.warning_rounded,
      //     color: Colors.red,
      //     size: 40,
      //   ),
      //   shouldIconPulse: true,
      //   duration: const Duration(seconds: 3),
      //   backgroundColor: Colors.black,
      //   snackPosition: SnackPosition.BOTTOM,
      // );
    }
  }

  void SignUp() async {
    final docRef = FirebaseFirestore.instance.collection('users');
    isLoading = true;
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email!, password: password!)
          .then((value) async {
        final imageRef = FirebaseStorage.instance
            .ref()
            .child('users_Images')
            .child('$name-$companyPosition .jpg');
        await imageRef.putFile(imageFile!);
        imageUrl = await imageRef.getDownloadURL();

        await docRef.doc(value.user!.uid).set({
          'id': value.user!.uid,
          'name': name,
          'email': email,
          'imageURL': imageUrl,
          'phone_number': phonenumber,
          'company_position': companyPosition,
          'created_at': Timestamp.now()
        });
      });

      update();
      Get.offAllNamed(Routes.homeScreen);
    } on FirebaseAuthException catch (e) {
      String message = 'Fields are empty';

      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that username.';
      }
      Get.defaultDialog(
        title: 'Error Occurred',
        titleStyle: const TextStyle(
            fontSize: 30, fontWeight: FontWeight.bold, color: Colors.red),
        middleText: message,
        middleTextStyle: const TextStyle(fontSize: 18),
        backgroundColor: Colors.grey.shade400,
      );
      isLoading = false;
    }
  }

  void Logout() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    isSignedIn.value = false;
    update();
    Get.offAllNamed(Routes.loginScreen);
  }

//   void googleSignInMethod() async {
//     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn().then(
//       (value) async {
//         final docRef = FirebaseFirestore.instance.collection('users');
//         // final imageRef = FirebaseStorage.instance
//         //     .ref()
//         //     .child('google_users_Images')
//         //     .child('$name-$companyPosition .jpg');
//         // await imageRef.putFile(imageFile!);
//         // google_image_url = await imageRef.getDownloadURL();

//         await docRef.doc(userID).set({
//           'id': userID,
//           'name': userName,
//           'email': userEmail,
//           'imageURL': userPhoto,
//           'phone_number': phonenumber ?? 010222222222,
//           'company_position': companyPosition ?? 'Unknown',
//           'created_at': Timestamp.now()
//         });
//       },
//     );

//     Get.offAllNamed(Routes.homeScreen);
// // to make user email appears on firebase authentication identifiers

// // 1-authenticate that user
//     GoogleSignInAuthentication? googleAuth = await googleUser!.authentication;
//     try {
// //2-then get accessToken and idToken of the user
//       final OAuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );

// //3-finally make your simple sign in with user credential
//       await _auth.signInWithCredential(credential);
//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         'Google Registration process is cancelled!',
//         colorText: Colors.black,
//         icon: Icon(
//           Icons.warning_rounded,
//           color: Colors.red,
//           size: 40,
//         ),
//         shouldIconPulse: true,
//         duration: Duration(seconds: 3),
//         backgroundColor: Colors.black,
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     }
// //to store in Local Storage
//     // isSignedIn = true;
//     // _authBox.write(_key, isSignedIn);
//     update();
//   }

//
}
