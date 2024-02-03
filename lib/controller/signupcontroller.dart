// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:welcom/model/sqlitedb2.dart';

class SignupPageController extends GetxController {
  SqlDB sqldb = SqlDB();
  TextEditingController textEditingController = TextEditingController();
  TextEditingController passEditingController = TextEditingController();
  RxBool passToggle = true.obs;
  bool succ = true;
  bool fail = false;
  var selectedImagePath = ''.obs;
  var selectedImageSize = ''.obs;

  void pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
      selectedImageSize.value =
          ((File(selectedImagePath.value).lengthSync() / 1024 / 1024))
                  .toStringAsFixed(2) +
              "MB";
    } else {
      Get.snackbar('Error', 'No image selected',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }
  // onPasswordChanged(String password) {
  //   final numericRegex = RegExp(r'[0-9]');

  //   if (password.length >= 8) {
  //     print("Strong passward");
  //     const Text("Strong password");
  //   }

  //   if (numericRegex.hasMatch(password)) {}
  // }

  Future<List<Map>> readData() async {
    List<Map> response = await sqldb.readData("SELECT * FROM users");
    return response;
  }

  @override
  void onInit() {
    super.onInit();
    readData();
  }

  @override
  void onReady() {
    // called after the widget is rendered on screen
    super.onReady();
  }

  @override
  void onClose() {
    // called just before the Controller is deleted from memory
    textEditingController.dispose();
    super.onClose();
  }
}
