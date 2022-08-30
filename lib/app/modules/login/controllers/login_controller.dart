import 'dart:developer';

import 'package:authentication_seclobe/app/modules/home/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/sevices/auth_services/auth_services.dart';

class LoginController extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> globaFormKey = GlobalKey<FormState>();
  RxBool hidePassword = true.obs;
  RxBool showLoading = false.obs;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  clearText() {
    emailController.clear();

    passwordController.clear();
  }

  bool validation() {
    final form = globaFormKey.currentState;
    if (form!.validate()) {
      form.save();

      return true;
    }
    return false;
  }

  logIn({required String email, required String password}) async {
    showLoading.value = true;
    try {
      final response =
          await AuthService().login(email: email, password: password);
      if (response == 'e') {
        showLoading.value = false;
        Get.snackbar(
          "Server error",
          "can't login right now, please try again later",
          icon: const Icon(Icons.error_outline, color: Colors.red),
          snackPosition: SnackPosition.BOTTOM,
        );
      }

      if (response.statusCode == 204) {
        showLoading.value = false;
        Get.snackbar(
          " Warning",
          "User not Found ,please enter existing account",
          icon: const Icon(Icons.warning, color: Colors.red),
          snackPosition: SnackPosition.BOTTOM,
        );
      } else if (response.statusCode == 200) {
        showLoading.value = false;
        Get.snackbar(
          " Warning",
          "wrong password, please enter valid password",
          icon: const Icon(Icons.warning, color: Colors.red),
          snackPosition: SnackPosition.BOTTOM,
        );
      } else if (response.statusCode == 201) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          final result = await prefs.setString('user', response.body);
          showLoading.value = false;
          clearText();
          result == true ? Get.offAll(HomeView()) : null;
        } catch (e) {
          showLoading.value = false;
          Get.snackbar(
            " Local error",
            "Account created , please try again later",
            icon: const Icon(Icons.warning, color: Colors.red),
            snackPosition: SnackPosition.BOTTOM,
          );
        }
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
