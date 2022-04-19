// ignore_for_file: avoid_function_literals_in_foreach_calls, avoid_print, prefer_typing_uninitialized_variables

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:push_notification_demo/model/user_list_model.dart';

class UserListController extends GetxController{
  List? docs;
  List uid = List<UserListModel>.empty(growable: true);
  var isLoading = false.obs;
  var senderId;

  @override
  void onInit() {
    senderId = Get.arguments;
    super.onInit();
  }

  Future getUserInfo() async {
    isLoading = true.obs;
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('users').get();
    docs = snapshot.docs;
    docs!.forEach((doc){
        var data = UserListModel(userName: doc.id);
        uid.add(data);
    });
  }
}