import 'dart:convert';
import 'dart:developer';

import 'package:authentication_seclobe/app/data/model/user_model.dart';
import 'package:authentication_seclobe/app/modules/wrapper/views/wrapper_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  RxBool showLoading = false.obs;
  final Rx<UserModel?> userModel = (UserModel()).obs;
  HomeController() {
    displayData();
  }
  displayData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final result = prefs.getString('user');
    userModel.value = UserModel.fromJson(jsonDecode(result!));
  }

  logOut() async {
    showLoading.value = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final result = await prefs.remove('user');
    if (result) {
      showLoading.value = false;
      Get.offAll(WrapperView());
    } else {
      showLoading.value = false;
      Get.snackbar(
        " Error",
        "please try again later",
        icon: const Icon(Icons.warning, color: Colors.red),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
