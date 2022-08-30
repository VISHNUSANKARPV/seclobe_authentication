import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  SignupView({Key? key}) : super(key: key);

  final SignupController _signupController = Get.put(SignupController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            vertical: 30, horizontal: 20),
                        margin: const EdgeInsets.symmetric(
                            vertical: 85, horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.9),
                                offset: const Offset(0, 10),
                                blurRadius: 20)
                          ],
                        ),
                        child: Form(
                          key: _signupController.globaFormKey,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 25,
                              ),
                              const Text(
                                "Sign Up",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: _signupController.userController,
                                keyboardType: TextInputType.emailAddress,
                                validator: (val) => val!.length <= 4
                                    ? "username should be more than 6 characters"
                                    : null,
                                decoration: InputDecoration(
                                  hintText: "Username",
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black.withOpacity(0.2),
                                    ),
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.account_circle,
                                    color: Colors.teal,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: _signupController.emailController,
                                keyboardType: TextInputType.emailAddress,
                                validator: (val) => !val!.contains("@gmail.com")
                                    ? "Email Id should be Valid"
                                    : null,
                                decoration: InputDecoration(
                                  hintText: "Email Address",
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black.withOpacity(0.2),
                                    ),
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.email,
                                    color: Colors.teal,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Obx(
                                () => TextFormField(
                                  controller: _signupController.passwordController,
                                  keyboardType: TextInputType.text,
                                  validator: (val) => val!.length < 6
                                      ? "Password should be more than 6 characters"
                                      : null,
                                  obscureText: _signupController.hidePassword.value,
                                  decoration: InputDecoration(
                                    hintText: "Password",
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black.withOpacity(0.2),
                                      ),
                                    ),
                                    prefixIcon: const Icon(
                                      Icons.lock,
                                      color: Colors.teal,
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        _signupController.hidePassword.value ==
                                                false
                                            ? _signupController.hidePassword.value =
                                                true
                                            : _signupController.hidePassword.value =
                                                false;
                                      },
                                      color: Colors.teal.withOpacity(0.4),
                                      icon: Icon(
                                        _signupController.hidePassword.value ==
                                                true
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Obx(
                                () => TextFormField(
                                  controller:
                                      _signupController.conpasswordController,
                                  keyboardType: TextInputType.text,
                                  validator: (val) => val !=
                                          _signupController.passwordController.text
                                      ? "Password is not match"
                                      : null,
                                  obscureText: _signupController.hidePassword.value,
                                  decoration: InputDecoration(
                                    hintText: "Confirm Password",
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black.withOpacity(0.2),
                                      ),
                                    ),
                                    prefixIcon: const Icon(
                                      Icons.verified,
                                      color: Colors.teal,
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        _signupController.hidePassword.value ==
                                                false
                                            ? _signupController.hidePassword.value =
                                                true
                                            : _signupController.hidePassword.value =
                                                false;
                                      },
                                      color: Colors.teal.withOpacity(0.4),
                                      icon: Icon(
                                        _signupController.hidePassword.value ==
                                                true
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 80, vertical: 12),
                                    shape: const StadiumBorder(),
                                    primary: Colors.white,
                                    elevation: 2,
                                    backgroundColor: Colors.teal),
                                onPressed: () {
                                  final validate = _signupController.validation();
                                  if (validate == true) {
                                    _signupController.signUp
                                    (
                                      name: _signupController.userController.text,
                                      email: _signupController.emailController.text,
                                      password:
                                          _signupController.passwordController.text,
                                    );
                                  }
                                },
                                child: const Text("Sign Up"),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Already have an account?",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: const Text(
                                      "Login",
                                      style: TextStyle(
                                          color: Colors.teal,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
              Obx(() => Visibility(
              visible: _signupController.showLoading.value,
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
              )))
        ],
      ),
    );
  }
}
