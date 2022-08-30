import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  final HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
        body: Obx(() => Stack(
              children: [
                Center(
                  child: Container(
                  decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.9),
                                offset: const Offset(0, 10),
                                blurRadius: 20)
                          ],
                        ),
                    height: 200,
                    width: 280,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          homeController.userModel.value?.name ??
                              'Coudn\'t find',
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w800),
                        ),
                        Text(
                          homeController.userModel.value?.email ??
                              'Coudn\'t find',
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w800),
                        ),
                        TextButton(
                            onPressed: () {
                              homeController.logOut();
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.red.shade400),
                            ),
                            child: const Text(
                              "Logout",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ))
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: homeController.showLoading.value,
                  child: const SizedBox(
                    height: double.maxFinite,
                    width: double.maxFinite,
                    child: ColoredBox(
                      color: Colors.black38,
                      child: Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 8,
                          color: Colors.teal,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )));
  }
}
