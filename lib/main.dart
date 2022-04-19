// ignore_for_file: avoid_print, unnecessary_new, unnecessary_string_interpolations
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'login.dart';
import 'page/pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: GetMaterialApp(
      getPages: AppPages.pages,
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
      scrollBehavior: const ScrollBehavior(
          androidOverscrollIndicator: AndroidOverscrollIndicator.glow),)
    );
  }
}

//'https://pushnotificationdemo-139f8-default-rtdb.firebaseio.com/' //firebase url Maxthon
