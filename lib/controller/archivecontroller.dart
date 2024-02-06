import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:welcom/model/sqlitedb2.dart';
import 'package:welcom/view/archivePage.dart';

class ArchiveController extends GetxController {
  var scaffoldkey = GlobalKey<ScaffoldState>();
  List users = [].obs;
  SqlDB sqldb = SqlDB();
  TextEditingController teSeach = TextEditingController();
  TextEditingController textEditingController = TextEditingController();
  TextEditingController userEditingController = TextEditingController();
  TextEditingController passEditingController = TextEditingController();
  bool isEmailCorrect = false;
  bool passToggle = true;

  final TextEditingController controller = TextEditingController();
  bool success = true;
  bool fail = false;
  late String vall;

  TextEditingController confirmpassword = TextEditingController();

  readData() async {
    List<Map> response = await sqldb.readData("SELECT * FROM users");
    users.addAll(response);
  }

  filter(String val) {
    Iterable filterUser = users.where(
        (element) => element['username'] == val || element['email'] == val);
    users.replaceRange(0, users.length, filterUser.toList());
  }

  inseretuser(Map insertuser) async {
    await sqldb.insertData(
        "INSERT INTO 'users' ('username','email','pass','bod','photo') VALUES('${insertuser['username']}','${insertuser['email']}','${insertuser['pass']}','20-1-2000','${insertuser['photo']}')");
    users.add(insertuser);
  }

  uppdateuser(Map updatuser) async {
    int res = await sqldb
        .updateData(''' UPDATE users SET username= "${updatuser['username']}" ,
                              email= "${updatuser['email']}" ,
                               pass= "${updatuser['pass']}"
                              WHERE id= ${Get.arguments['id']}  ''');
    return res;
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
    super.onClose();
  }

  onPasswordChanged(String password) {
    final numericRegex = RegExp(r'[0-9]');

    if (password.length >= 8) {}

    if (numericRegex.hasMatch(password)) {}
  }

  deleteuser(int id) async {
    int response = await sqldb.deletData("DELETE FROM users WHERE id=$id");
    users.removeWhere((element) => element['id'] == id);
    if (response > 0) {
      Get.to(() => Archives());
    }
  }
}
