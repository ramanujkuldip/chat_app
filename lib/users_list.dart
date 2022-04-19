// ignore_for_file: avoid_function_literals_in_foreach_calls, avoid_print, prefer_typing_uninitialized_variables

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:push_notification_demo/controllers/user_list_controller.dart';
import 'package:push_notification_demo/send_msg.dart';

import 'controllers/message_controller.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {

  var userListController = Get.put(UserListController());
  var messageController = Get.put(MessageController());

@override
  void initState() {
    userListController.getUserInfo();
    refresh();
  super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: const Text("Users List"),
          centerTitle: true,
          foregroundColor: Colors.black,
          elevation: 0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
      ),
      body: userListController.uid.isNotEmpty
          ? ListView.builder(
          itemCount: userListController.uid.length,
          itemBuilder: (context, index) {
            if(userListController.uid.isNotEmpty){
              return Container(
                margin: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.blue.shade100
                ),
                child: ListTile(
                  title: Text("${userListController.uid[index].userName}"),
                  onTap: () async {
                    var snapshot = await  FirebaseFirestore.instance.collection("users").doc(userListController.uid[index].userName).get();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SendMsg(
                      senderId: userListController.senderId,
                      recieverId: userListController.uid[index].userName,
                      name: snapshot.get("name"),
                      token: snapshot.get("token"),
                    )));
                  },
                ),
              );
            }else{
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        )
          : const Center(child: CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {});
          },
        tooltip: 'Increment',
        child: const Icon(Icons.send),
      ),
    );
  }

  refresh(){
  Timer.periodic(const Duration(seconds: 1), (timer) {
    setState(() {
      userListController.isLoading.value = false;
    });
    timer.cancel();
  },);
  }
}

