import 'package:get/get.dart';

class DrawerController1 extends GetxController {
  void usersOpen() {
    Get.toNamed('/archive');
  }

  void currencyOpen() {
    Get.toNamed('/currency');
  }

  void orederOpen() {
    Get.toNamed('/order');
  }
}
