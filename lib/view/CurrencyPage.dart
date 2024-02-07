// ignore_for_file: file_names, avoid_print
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:welcom/controller/currencyController.dart';
import 'package:welcom/controller/drawercontroller.dart';
import 'package:welcom/view/editCurren.dart';

// ignore: must_be_immutable
class Currency extends GetView<CurrencyController> {
  Currency({super.key});
  var scaffoldKey2 = GlobalKey<ScaffoldState>();
  TextEditingController teSeach1 = TextEditingController();
  DrawerController1 controllerDrawer = Get.put(DrawerController1());
  CurrencyController controllerCurrency = Get.put(CurrencyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey2,
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
                child: Row(
              children: [
                Image.asset(
                  'assets/images/1.jpg',
                  height: 70,
                  width: 70,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('Welcome to your app'),
              ],
            )),
            ListTile(
              onTap: () {
                controllerDrawer.usersOpen();
              },
              title: const Text('Users'),
            ),
            ListTile(
              onTap: () {
                controllerDrawer.currencyOpen();
                scaffoldKey2.currentState!.closeDrawer();
              },
              title: const Text('Currency'),
            ),
            ListTile(
              onTap: () {
                controllerDrawer.orederOpen();
                scaffoldKey2.currentState!.closeDrawer();
              },
              title: const Text('Orders'),
            ),
          ],
        ),
      ),
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                onChanged: (value) {
                  if (value == '') {
                    Get.to(() => Currency());
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
            Obx(
              () => Expanded(
                child: ListView.builder(
                  itemCount: controllerCurrency.currency.length,
                  shrinkWrap: true,
                  itemBuilder: (context, i) {
                    return Column(
                      children: [
                        Card(
                          elevation: 9,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          child: ListTile(
                            dense: false,
                            leading: Iconify(
                                '${controllerCurrency.currency[i]['currency_symbol']}'),
                            title: Column(children: [
                              Text(
                                "${controllerCurrency.currency[i]['rate']}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ]),
                            subtitle: Text(
                              "${controllerCurrency.currency[i]['curreny_name']}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            trailing:
                                Row(mainAxisSize: MainAxisSize.min, children: [
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
                                    Get.to(EditCurr(), arguments: {
                                      'id': controllerCurrency.currency[i]
                                          ['currency_id'],
                                      'currency_name': controllerCurrency
                                          .currency[i]['currency_name'],
                                      'currency_symbol': controllerCurrency
                                          .currency[i]['currency_symbol'],
                                      'rate': controllerCurrency.currency[i]
                                          ['rate'],
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
