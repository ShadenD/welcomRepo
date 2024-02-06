// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:welcom/controller/drawercontroller.dart';
import 'package:welcom/controller/ordercontroller.dart';

// ignore: must_be_immutable
class Orders extends GetView<OrederController> {
  Orders({super.key});
  var scaffoldkey3 = GlobalKey<ScaffoldState>();

  OrederController controller6 = Get.put(OrederController());
  DrawerController1 drawerController1 = Get.put(DrawerController1());

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
        // leading: IconButton(
        //   onPressed: () {
        //     setState(() {
        //       Get.to(Loginpage2());
        //     });
        //   },
        //   icon: const Icon(
        //     Icons.arrow_back_ios,
        //     size: 20,
        //     color: Colors.black,
        //   ),
        // ),
      ),
    );
  }
}
