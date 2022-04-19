// ignore_for_file: unnecessary_overrides
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:push_notification_demo/model/message_model.dart';

class MessageController extends GetxController{
  TextEditingController titleController = TextEditingController();
  TextEditingController msgController = TextEditingController();
  String? notificationTitle="";
  String? notificationBody="";
  List messagesList = List<MessagesModel>.empty(growable: true);


// String? token;
// storeToken()async{
//   FirebaseMessaging.instance.getToken().then((value) {
//     token = value;
//     print('Token111: $token');
//     FirebaseFirestore.instance.collection("users").add({
//       "token" : token
//     }).then((value) => print("Success $value"));
//   });
// }

  @override
  void onInit() {
    super.onInit();
  }


}
class CommonMessageObject {
  static MessagesModel messagesModelObject = MessagesModel();
}