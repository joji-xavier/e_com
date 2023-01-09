import 'package:e_com/app/core/widgets/input_field.dart';
import 'package:e_com/app/service/auth_service.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final loginController = Get.lazyPut(() => LoginController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              end: Alignment.center,
              begin: Alignment.bottomCenter,
              colors: [
            Color.fromRGBO(244, 134, 24, 1),
            Colors.white,
          ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          reverse: true,
          child: Obx(
            () => Container(
              margin: EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.12,
                  ),
                  Text(
                    'Welcome',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 35,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '''We helps you connect with your favourite sellers and purchase a variety of products easily and quickly. ''',
                      style: TextStyle(fontSize: 17, color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Form(
                    autovalidateMode: controller.buttonPress.value
                        ? AutovalidateMode.onUserInteraction
                        : AutovalidateMode.disabled,
                    key: controller.loginFormKey,
                    child: Container(
                      width: 376,
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: Column(
                            children: [
//                               Image.asset(
//                                 'assets/images/logo.png',
//                                 height: 150,
//                               ),
                              SizedBox(
                                height: 5,
                              ),
                              Text('please login to continue ',
                                  style: TextStyle(
                                      fontSize: 19, color: Color(0xff372F4B))),
                              SizedBox(
                                height: 15,
                              ),
                              InputField(
                                  maxlength: 10,
                                  isRequired: true,
                                  validator: (value) {
                                    return controller.validateUserName(value!);
                                  },
                                  icon: Icon(
                                    Icons.account_circle,
                                    size: 24,
                                    color: Color(0xff655F74),
                                  ),
                                  isHidden: false,
                                  hint: 'User Name',
                                  controller: controller.userNameController,
                                  readOnly: false,
                                  keyboardType: TextInputType.name),
                              InputField(
                                  isRequired: true,
                                  isHidden: controller.isPasswordVisible.value,
                                  validator: (value) {
                                    return controller.validatePassword(value!);
                                  },
                                  icon: InkWell(
                                    onTap: () {
                                      controller.passwordVisibility();
                                    },
                                    child: controller.isPasswordVisible.value
                                        ? Icon(
                                            Icons.lock_outline,
                                            size: 24,
                                            color: Color(0xff655F74),
                                          )
                                        : Icon(
                                            Icons.lock_open_outlined,
                                            size: 24,
                                            color: Color(0xff655F74),
                                          ),
                                  ),
                                  hint: 'Password',
                                  controller: controller.passwordController,
                                  readOnly: false,
                                  keyboardType: TextInputType.text),
                              SizedBox(
                                height: 15,
                              ),
                              Obx(() => controller.isLoading.value
                                  ? CircularProgressIndicator()
                                  : ElevatedButton(
                                      onPressed: () {
                                        controller.checkLogin(context);
                                      },
                                      child: Text('Login'),
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              side: BorderSide(
                                                  color: Colors.orange)),
                                          backgroundColor: Colors.orange,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 18, vertical: 12),
                                          textStyle: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.normal)),
                                    )),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        AuthService().signIn();
                                      },
                                      child: Row(
                                        children: [
                                          Text(
                                            'Sign in with',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          const Image(
                                              width: 70,
                                              image: AssetImage(
                                                  'assets/images/google.png')),
                                        ],
                                      )),
                                  GestureDetector(
                                      onTap: () {
                                        AuthService().signUp();
                                      },
                                      child: Row(
                                        children: [
                                          Text(
                                            'Sign up with',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          const Image(
                                              width: 70,
                                              image: AssetImage(
                                                  'assets/images/google.png')),
                                        ],
                                      ))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
