import 'dart:developer';

import 'package:authentication_seclobe/app/modules/home/views/home_view.dart';
import 'package:authentication_seclobe/app/modules/login/views/login_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/wrapper_controller.dart';

class WrapperView extends GetView<WrapperController> {
  WrapperView({Key? key}) : super(key: key);

  final WrapperController wrapperController = Get.put(WrapperController());
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: wrapperController.checkingAuth(),
      builder: ((context, dynamic snapshot) {
        if (snapshot == null) {
          return const CircularProgressIndicator();
        } else if (snapshot.data == true) {
          return  HomeView();
        }
        return LoginView();
      }),
    );
  }
}
