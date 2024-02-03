// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Setting extends GetxService {
  late SharedPreferences sharedPrefer; 
  RxInt counter = 0.obs;
  Future<Setting> init() async {
    //start services
    sharedPrefer = await SharedPreferences.getInstance();
    counter.value = sharedPrefer.getInt("counter") ?? 0;
    return this;
  }

  increase() {
    counter.value++;
    sharedPrefer.setInt("counter", counter.value);
  }
}
