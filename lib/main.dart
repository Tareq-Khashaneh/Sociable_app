import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mime/mime.dart';
import 'package:task_1/bindings/create_poste_binding.dart';
import 'package:task_1/bindings/home_binding.dart';
import 'package:task_1/constants/routes.dart';
import 'package:task_1/core/functions.dart';
import 'package:task_1/view/screens/create_post_screen.dart';
import 'package:task_1/view/screens/home._screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  await FirebaseAppCheck.instance.activate(
    // webRecaptchaSiteKey: 'recaptcha-v3-site-key',

    androidProvider: AndroidProvider.debug,
    appleProvider: AppleProvider.appAttest,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: ScreenRoutes.homeRoute,
      getPages: [
        GetPage(
            name: ScreenRoutes.homeRoute,
            page: () => HomeScreen(),
            binding: HomeBinding()),
        GetPage(
            name: ScreenRoutes.createPostRoute,
            page: () => CreatePostScreen(),
            binding: CreatePostBinding()),
      ],
    );
  }
}
