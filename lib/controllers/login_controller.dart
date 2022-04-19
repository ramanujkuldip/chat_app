// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:push_notification_demo/utils/constant.dart';

class LoginController extends GetxController{
  TextEditingController nameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var token;
  var isLoading = false.obs;

  userRegister(){
    FirebaseMessaging.instance.getToken().then((value) {
      token = value;
      isLoading.value = true;
      print('Token111: $token');
      FirebaseFirestore.instance.collection("users").doc(userNameController.text).set({
        "name" : nameController.text,
        "token" : token
      },).then((value) {
        Timer.periodic(const Duration(seconds: 1), (timer) {
          isLoading.value = false;
          print("Success");
          Get.toNamed(ROUTE_USERLIST,arguments: userNameController.text);
          timer.cancel();
        },);
      });
    });
  }


// FirebaseMessaging.instance.getToken().then((value) {
// token = value;
// print('Token111: $token');});
//   FirebaseFirestore.instance.collection("users").doc("20ffb310-03c0-4d09-83db-41090941a587").set(
//       {
//         "token" : token
//       },SetOptions(merge: true));
// getUid();

}