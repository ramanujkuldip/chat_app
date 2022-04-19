// ignore_for_file: unnecessary_new, must_be_immutable, prefer_typing_uninitialized_variables, avoid_print, avoid_function_literals_in_foreach_calls, unnecessary_brace_in_string_interps
import 'dart:async';
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:push_notification_demo/controllers/message_controller.dart';
import 'model/message_model.dart';
import 'notification.dart';

class SendMsg extends StatefulWidget {
  var token;
  var name;
  var senderId;
  var recieverId;
  SendMsg({this.token,this.name,this.senderId,this.recieverId,Key? key,}) : super(key: key);

  @override
  State<SendMsg> createState() => _SendMsgState();
}

class _SendMsgState extends State<SendMsg> {

  var messageController = Get.put(MessageController());
  final databaseref = FirebaseDatabase.instance.ref().child("messageList");
  late DatabaseReference databaseReference;

  @override
  void initState() {
    databaseReference = databaseref;
    final firebaseMessaging = FCM();
    firebaseMessaging.setNotifications();
    firebaseMessaging.bodyCtlr.stream.listen(_changeBody);
    firebaseMessaging.titleCtlr.stream.listen(_changeTitle);
    super.initState();
  }

  // getData() async {
  //   QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("messagesList").doc(widget.recieverId)
  //       .collection(widget.senderId).get();
  //   var docs = snapshot.docs;
  //   docs.forEach((element) {
  //     var data = MessagesModel(
  //       messages: element.get("message"),
  //       recieverId: element.get("recieverId"),
  //       senderId: element.get("senderId"),
  //     );
  //     messageController.messagesList.add(data);
  //   });
  // }

  _changeBody(String msg) => setState(() => messageController.notificationBody = msg);
  _changeTitle(String msg) => setState(() => messageController.notificationTitle = msg);

  @override
  Widget build(BuildContext context) {
    fetchData();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: InkWell(
            onTap: () {
              setState(() {
              });
            },
            child: Text("${widget.name}")),
        centerTitle: true,
        foregroundColor: Colors.black,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
              Expanded(
                child: ListView.builder(
                  itemCount: messageController.messagesList.length,
                  itemBuilder: (context, index) {
                  return Text(messageController.messagesList[index].messages);
                },),
              ),
          // Align(
          //   alignment: Alignment.bottomLeft,
          //   child: Container(
          //     margin: const EdgeInsets.only(left: 15,bottom: 20),
          //     padding: const EdgeInsets.all(10),
          //     decoration: BoxDecoration(
          //       color: Colors.green.withOpacity(0.3),
          //       borderRadius: BorderRadius.circular(30),
          //     ),
          //     child: Text(messageController.notificationTitle.toString()),
          //   ),
          // ),
          const SizedBox(height: 15,)
        ],
      ),
      bottomNavigationBar: ListTile(
        title: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.blueGrey.shade100
          ),
          child: TextField(
            controller: messageController.titleController,
            decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 15)),
          ),
        ),
        trailing: CircleAvatar(
          radius: 25.0,
          backgroundColor: Colors.blue,
          child: IconButton(
            color: Colors.white,
            onPressed: () {
              setState(() {
                sendFcmMessage(messageController.titleController.text,messageController.msgController.text,widget.token);
                // FirebaseFirestore.instance.collection("messagesList").doc(widget.senderId).collection(widget.recieverId).add({
                //   "message" : messageController.titleController.text,
                //   "senderId": widget.senderId,
                //   "recieverId": widget.recieverId,
                // }).then((value){
                //   print("Success");
                // });
                FirebaseDatabase.instance.ref().child("messageList").push().set({
                  "message" : messageController.titleController.text,
                  "senderId": widget.senderId,
                  "recieverId": widget.recieverId,
                });
                messageController.titleController.clear();
              });
            },
            tooltip: 'Increment',
            icon: const Icon(Icons.send,size: 20),
          ),
        ),
      ),
    );
  }

  static Future<bool> sendFcmMessage(String title, String body, token) async {
    try {
      var url = Uri.parse('https://fcm.googleapis.com/fcm/send');
      var header = {
        "Content-Type": "application/json",
        "Authorization": "key=AAAAWfEZb-s:APA91bEVoK9aakFRBJauxd756cQ-z5hKNAu1JQxr6dyrVya6Fa8lKWRrgwaP1MrFmU5twM7lAt5PcYN1zFrzAZg0TVdRalFodg9_MsbWXj8dJ7tamsDFPxx_gJcOQIw5sfyT1bj07coi",
      };

      var request = {
        "notification": {
          "title": title,
          "body": body,
          "sound": "default",
          "color": "#990000",
        },
        "priority": "high",
        "to": token,
      };

      var client = new Client();
      await client.post(url, headers: header, body: json.encode(request));

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  fetchData() async {
    final url = Uri.parse('https://pushnotificationdemo-139f8-default-rtdb.firebaseio.com/messageList.json');
    var client = new Client();
    final response = await client.get(url);
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    data.forEach((key, value) {
      final resData = MessagesModel(
        messages: value['message'],
        senderId: value['senderId'],
        recieverId: value['recieverId']
      );
      messageController.messagesList.add(resData);
    });
  }
}
