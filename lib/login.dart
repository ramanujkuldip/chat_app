// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, prefer_const_constructors, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:push_notification_demo/controllers/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var loginController = Get.put(LoginController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F7F8),
      body: Obx(()=> Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Login",
                style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 5,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.7),
                        blurRadius: 5,
                        offset: Offset(5, 3)
                      )]
                ),
              ),
              const SizedBox(height: 30,),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.blueGrey.shade100
                ),
                child: TextField(
                  controller: loginController.userNameController,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "User name",
                      contentPadding: EdgeInsets.only(left: 15)),
                ),
              ),
              const SizedBox(height: 15,),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.blueGrey.shade100
                ),
                child: TextField(
                  controller: loginController.nameController,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter your name",
                      contentPadding: EdgeInsets.only(left: 15)),
                ),
              ),
              const SizedBox(height: 20,),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(150, 40),
                      primary: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      )
                  ),
                  onPressed: () async {
                    loginController.userRegister();
                  },
                  child: loginController.isLoading.value == true
                      ? SizedBox(
                        height: 25,
                        width: 25,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      )
                      : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Login",style: TextStyle(color: Colors.white.withOpacity(0.7)),),
                      Icon(Icons.arrow_right_alt_outlined,size: 40,)
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }


}
