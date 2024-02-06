// ignore_for_file: file_names, unused_local_variable

import 'package:get/get.dart';
import 'package:welcom/model/sqlitedb2.dart';
import 'package:welcom/view/CurrencyPage.dart';

class CurrencyController extends GetxController {
  SqlDB sqldb = SqlDB();
  RxList currency = [].obs;

  readData2() async {
    List<Map> response = await sqldb.readData("SELECT * FROM currency");
    currency.addAll(response);
  }

  insertcurr(Map curr) async {
    await sqldb.insertData(
        "INSERT INTO 'currency' ('curreny_name','currency_symbol','rate') VALUES('${curr['namecurr']}','${curr['currsymbol']}',${curr['rate']})");
    currency.add(curr);
  }

  delete(int id) async {
    int response =
        await sqldb.deletData("DELETE FROM currency WHERE currency_id=$id");
    currency.removeWhere((element) => element['id'] == id);
    if (response > 0) {
      Get.to(() => Currency());
    }
  }

  filter(String val) {
    Iterable filterCurr = currency.where(
        (element) => element['currency_id'] == val || element['rate'] == val);
    currency.replaceRange(0, currency.length, filterCurr.toList());
  }

  updateCurreny(Map update) async {
    await sqldb.updateData(
        ''' UPDATE curreny SET curreny_name= "${update['currency_name']}" ,
                              currency_symbol= "${update['currency_symbol']}" ,
                               rate= "${update['rate']}"
                              WHERE id= ${Get.arguments['id']} ''');
                            
                        
  }

  @override
  void onInit() {
    readData2();
    super.onInit();
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
}
