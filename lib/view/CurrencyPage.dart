// ignore_for_file: file_names, avoid_print
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:welcom/controller/currencyController.dart';
import 'package:welcom/controller/drawercontroller.dart';
import 'package:welcom/view/editCurren.dart';
import 'package:welcom/widget/navigatorRail.dart';

// ignore: must_be_immutable
class Currency extends GetView<CurrencyController> {
  Currency({super.key});
  var scaffoldKey2 = GlobalKey<ScaffoldState>();
  TextEditingController teSeach1 = TextEditingController();
  NavigationController controllerDrawer = Get.put(NavigationController());
  CurrencyController controllerCurrency = Get.put(CurrencyController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey2,
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Currency Page"),
        actions: <Widget>[
          Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: () {
                  Get.toNamed('/addcurr');
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                onPressed: () {
                  // controllerLogin.save();
                  Get.toNamed('/');
                },
              )
            ],
          )
        ],
      ),
      body: Row(children: [
        MyNavicator(),
        Expanded(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  onChanged: (value) {
                    if (value == '') {
                      controllerCurrency.currency.clear();
                      controllerCurrency.readData2();
                      //Get.to(() => Currency());
                    }
                  },
                  controller: teSeach1,
                  decoration: InputDecoration(
                      hintText: 'Search...',
                      labelText: 'Search',
                      prefixIcon: TextButton(
                          onPressed: () async {
                            FocusScope.of(context).unfocus();
                            await controllerCurrency.filter(teSeach1.text);
                          },
                          child: const Icon(Icons.search)),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      )),
                ),
              ),
              GetX<CurrencyController>(
                  builder: (CurrencyController controller) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: controller.currency.length,
                    shrinkWrap: true,
                    itemBuilder: (context, i) {
                      return Column(
                        children: [
                          Card(
                            elevation: 9,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                            ),
                            child: ListTile(
                              dense: false,
                              leading: Text(
                                  '${controller.currency[i]['currency_symbol']}'),
                              title: Column(children: [
                                Text(
                                  "${controller.currency[i]['rate']}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ]),
                              subtitle: Text(
                                "${controller.currency[i]['curreny_name']}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                        onPressed: () async {
                                          await controllerCurrency.delete(
                                              controllerCurrency.currency[i]
                                                  ['currency_id']);
                                          print("delete currency");
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        )),
                                    IconButton(
                                        onPressed: () async {
                                          Get.off(EditCurr(), arguments: {
                                            'id': controller.currency[i]
                                                ['currency_id'],
                                            'curreny_name': controller
                                                .currency[i]['curreny_name']
                                                .toString(),
                                            'currency_symbol': controller
                                                .currency[i]['currency_symbol']
                                                .toString(),
                                            'rate': controller.currency[i]
                                                    ['rate']
                                                .toString(),
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.update,
                                          color: Colors.black,
                                        )),
                                  ]),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                );
              }),
            ],
          ),
        ),
      ]),
    );
  }
}
