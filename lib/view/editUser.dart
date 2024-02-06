// ignore_for_file: file_names, use_build_context_synchronously, must_be_immutable, unrelated_type_equality_checks

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:get/get.dart';
import 'package:welcom/controller/archivecontroller.dart';
import 'package:welcom/view/archivePage.dart';
import 'package:welcom/model/sqlitedb2.dart';

class Editarchive extends GetView<ArchiveController> {
  Editarchive({super.key});
  SqlDB sqldb = SqlDB();
  GlobalKey<FormState> formstate = GlobalKey();

  TextEditingController textEditingController = TextEditingController();
  TextEditingController userEditingController = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  TextEditingController passEditingController = TextEditingController();
  ArchiveController archiveController = Get.put(ArchiveController());

  @override
  Widget build(BuildContext context) {
    textEditingController.text = Get.arguments['email'];
    userEditingController.text = Get.arguments['username'];
    passEditingController.text = Get.arguments['pass'];
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height - 30,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  FadeInUp(
                      duration: const Duration(milliseconds: 1000),
                      child: const Text(
                        "Edit User",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  FadeInUp(
                      duration: const Duration(milliseconds: 1200),
                      child: Text(
                        "Edit your information",
                        style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                      )),
                ],
              ),
              Form(
                key: formstate,
                child: Column(
                  children: <Widget>[
                    const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Email",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.black87),
                          ),
                        ]),
                    const SizedBox(
                      height: 2,
                    ),
                    FadeInUp(
                        duration: const Duration(milliseconds: 1200),
                        child: TextFormField(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade400)),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade400)),
                          ),
                          controller: textEditingController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            archiveController.vall = value!;
                            if (value.isEmpty) {
                              return "الحقل فارغ";
                            } else if (RegExp(
                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                .hasMatch(value)) {
                            } else {
                              return "Enter valid Email";
                            }
                            return null;
                          },
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "User Name",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.black87),
                          ),
                        ]),
                    const SizedBox(
                      height: 2,
                    ),
                    FadeInUp(
                        duration: const Duration(milliseconds: 1200),
                        child: TextFormField(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade400)),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade400)),
                          ),
                          controller: userEditingController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            archiveController.vall = value!;
                            if (value.isEmpty) {
                              return "الحقل فارغ";
                            }
                            return null;
                          },
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "passward",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.black87),
                          ),
                        ]),
                    const SizedBox(
                      height: 2,
                    ),
                    FadeInUp(
                        duration: const Duration(milliseconds: 1200),
                        child: TextFormField(
                          onChanged: (password) =>
                              archiveController.onPasswordChanged(password),
                          obscureText: archiveController.passToggle,
                          decoration: InputDecoration(
                            suffix: InkWell(
                              onTap: () {
                                archiveController.passToggle =
                                    !archiveController.passToggle;
                              },
                              child: Icon(
                                archiveController.passToggle
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade400)),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade400)),
                          ),
                          controller: passEditingController,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter your passward";
                              // } else if (controller4
                              //         .passEditingController.text.length <
                              //     6) {
                              //   return "Passward length should be more than 6 characters ";
                            }
                            return null;
                          },
                        )),
                    const SizedBox(
                      height: 2,
                    ),
                    const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Confirm passward",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.black87),
                          ),
                        ]),
                    const SizedBox(
                      height: 5,
                    ),
                    FadeInUp(
                        duration: const Duration(milliseconds: 1200),
                        child: TextFormField(
                          onChanged: (password) =>
                              archiveController.onPasswordChanged(password),
                          obscureText: archiveController.passToggle,
                          decoration: InputDecoration(
                            suffix: InkWell(
                              onTap: () {
                                archiveController.passToggle =
                                    !archiveController.passToggle;
                              },
                              child: Icon(
                                archiveController.passToggle
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade400)),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade400)),
                          ),
                          controller: confirmpassword,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please re-enter password';
                            }

                            if (archiveController.passEditingController.text !=
                                archiveController.confirmpassword.text) {
                              return "Password does not match";
                            }

                            return null;
                          },
                        )),
                    const SizedBox(
                      height: 2,
                    ),
                    FlutterPwValidator(
                      defaultColor: Colors.black,
                      controller: archiveController.controller,
                      successColor: Colors.green.shade700,
                      minLength: 8,
                      uppercaseCharCount: 1,
                      numericCharCount: 2,
                      specialCharCount: 1,
                      normalCharCount: 4,
                      width: 350,
                      height: 150,
                      onSuccess: () {
                        archiveController.success;
                      },
                      onFail: () {
                        archiveController.fail;
                      },
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                  ],
                ),
              ),
              FadeInUp(
                  duration: const Duration(milliseconds: 1500),
                  child: Container(
                    padding: const EdgeInsets.only(top: 3, left: 3),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: const Border(
                          bottom: BorderSide(color: Colors.black),
                          top: BorderSide(color: Colors.black),
                          left: BorderSide(color: Colors.black),
                          right: BorderSide(color: Colors.black),
                        )),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: () async {
                        if (formstate.currentState!.validate()) {
                          int res = await archiveController.uppdateuser({
                            "email": textEditingController.text,
                            "username": userEditingController.text,
                            "pass": passEditingController.text,
                          });
                          if (res > 0) {
                            Get.to(() => Archives());
                          }
                        }
                      },
                      color: Colors.blue,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      child: const Text(
                        "Edit",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
