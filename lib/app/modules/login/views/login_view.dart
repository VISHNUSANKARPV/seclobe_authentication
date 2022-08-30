import 'package:authentication_seclobe/app/modules/signup/views/signup_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);

  final LoginController _loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      key: _loginController.scaffoldKey,
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
                          key: _loginController.globaFormKey,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 25,
                              ),
                              const Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: _loginController.emailController,
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
                                  controller:
                                      _loginController.passwordController,
                                  keyboardType: TextInputType.text,
                                  validator: (val) => val!.length < 6
                                      ? "Password should be more than 6 characters"
                                      : null,
                                  obscureText:
                                      _loginController.hidePassword.value,
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
                                        _loginController.hidePassword.value ==
                                                false
                                            ? _loginController
                                                .hidePassword.value = true
                                            : _loginController
                                                .hidePassword.value = false;
                                      },
                                      color: Colors.teal.withOpacity(0.4),
                                      icon: Icon(
                                        _loginController.hidePassword.value ==
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
                                  final validate =
                                      _loginController.validation();
                                  if (validate == true) {
                                    _loginController.logIn(
                                      email:
                                          _loginController.emailController.text,
                                      password: _loginController
                                          .passwordController.text,
                                    );
                                  }
                                 
                                },
                                child: const Text("Login"),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Dont have an account?",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Get.to(SignupView());
                                    },
                                    child: const Text(
                                      "Register",
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
          Obx(
            () => Visibility(
              visible: _loginController.showLoading.value,
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
          )
        ],
      ),
    );
  }
}
