// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:welcom/controller/drawercontroller.dart';
import 'package:welcom/controller/ordercontroller.dart';
import 'package:welcom/view/addorder.dart';

// ignore: must_be_immutable
class Orders extends GetView<OrederController> {
  Orders({super.key});
  var scaffoldkey3 = GlobalKey<ScaffoldState>();

  OrederController controller6 = Get.put(OrederController());
  DrawerController1 drawerController1 = Get.put(DrawerController1());
  OrederController orederController = Get.put(OrederController());
  TextEditingController fitercontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey3,
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
                drawerController1.usersOpen();
                scaffoldkey3.currentState!.closeDrawer();
              },
              title: const Text('Users'),
            ),
            ListTile(
              onTap: () {
                drawerController1.currencyOpen();
                scaffoldkey3.currentState!.closeDrawer();
              },
              title: const Text('Currency'),
            ),
            ListTile(
              onTap: () {
                drawerController1.orederOpen();
                scaffoldkey3.currentState!.closeDrawer();
              },
              title: const Text('Orders'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Order Page"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
          onPressed: () {
            Get.to(() => Add());
          }),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Form(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: TextField(
                        controller: fitercontroller,
                        decoration: InputDecoration(
                            hintText: 'Search...',
                            labelText: 'Search',
                            prefixIcon: TextButton(
                                onPressed: () async {
                                  if (fitercontroller.text.toLowerCase() ==
                                      "paid") {
                                    orederController.getAllPaid();
                                  } else {
                                    if (fitercontroller.text.toLowerCase() ==
                                        "not paid") {
                                      controller.getAllNotPaid();
                                    } else {
                                      orederController
                                          .filter(fitercontroller.text);
                                    }
                                  }

                                  if (fitercontroller.text == '') {
                                    controller.states.clear();
                                    controller.orders.clear();
                                    controller.readDataOrder();
                                  }
                                },
                                child: const Icon(Icons.search)),
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                            )),
                        onChanged: (value) {
                          if (value == '') {
                            orederController.states.clear();
                            orederController.orders.clear();
                            orederController. readDataOrder()();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              GetX<OrederController>(
                builder: (OrederController orederController) => Expanded(
                  child: ListView.builder(
                    itemCount: orederController.orders.length,
                    itemBuilder: (context, i) {
                      return Card(
                        child: ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    " ${orederController.orders[i]['username']}"),
                                Text(
                                    " ${orederController.orders[i]['order_date']}"),
                                Obx(
                                  () => Text(
                                      " ${orederController.states[i] == 1 ? "Paid" : orederController.states[i] == 0 ? "Not Paid" : null}"),
                                ),
                                Text(" ${orederController.orders[i]['type']}"),
                                Text(
                                    " ${orederController.orders[i]['amount']}"),
                                Text(
                                    " ${orederController.orders[i]['equalAmount']}"),
                                Text(
                                    " ${orederController.orders[i]['currencyName']}"),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    await orederController.delete('orders',
                                        orederController.orders[i]['order_Id']);
                                  },
                                  icon: const Icon(Icons.delete),
                                ),
                                Obx(
                                  () => Switch(
                                    value: orederController.states[i] == 1
                                        ? true
                                        : false,
                                    onChanged: (bool value) async {
                                      await orederController.updateOrderState(
                                          value ? 1 : 0,
                                          orederController.orders[i]
                                              ['order_Id']);

                                      orederController.switchOrderState(
                                          i, value);
                                      orederController.orders.clear();
                                      orederController.readDataOrder();
                                    },
                                  ),
                                ),
                              ],
                            )),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
