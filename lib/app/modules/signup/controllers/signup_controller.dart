import 'dart:convert';
import 'dart:developer';

import 'package:authentication_seclobe/app/data/model/user_model.dart';
import 'package:authentication_seclobe/app/data/sevices/auth_services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../home/views/home_view.dart';

class SignupController extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> globaFormKey = GlobalKey<FormState>();
  RxBool hidePassword = true.obs;
  RxBool showLoading = false.obs;

  final TextEditingController userController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController conpasswordController = TextEditingController();

  bool validation() {
    final form = globaFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  clearText() {
    emailController.clear();
    userController.clear();
    passwordController.clear();
    conpasswordController.clear();
  }

  signUp(
      {required String name,
      required String email,
      required String password}) async {
    try {
      showLoading.value = true;
      final response = await AuthService()
          .signUp(userName: name, email: email, password: password);
      if (response.statusCode == 200) {
        showLoading.value = false;
        Get.snackbar(
          " Warning",
          "User already existing ,please enter another account",
          icon: const Icon(Icons.warning, color: Colors.red),
          snackPosition: SnackPosition.BOTTOM,
        );
      } else if (response.statusCode == 201) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          final result = await prefs.setString('user', response.body);
          showLoading.value = false;
          result == true ? Get.offAll( HomeView()) : null;
        } catch (e) {
          showLoading.value = false;
          Get.snackbar(
            " Local error",
            "Account created , please try again later",
            icon: const Icon(Icons.warning, color: Colors.red),
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      } else if (response == 'e') {
        showLoading.value = false;
        Get.snackbar(
          "Server error",
          "can't login right now, please try again later",
          icon: const Icon(Icons.error_outline, color: Colors.red),
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      showLoading.value = false;
      Get.snackbar(
        "Server error",
        "can't login right now, please try again later",
        icon: const Icon(Icons.error_outline, color: Colors.red),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
