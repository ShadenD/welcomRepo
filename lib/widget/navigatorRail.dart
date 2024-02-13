// ignore_for_file: file_names, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:welcom/controller/drawercontroller.dart';
import 'package:welcom/view/CurrencyPage.dart';
import 'package:welcom/view/OrderPage.dart';
import 'package:welcom/view/archivePage.dart';

class MyNavicator extends StatelessWidget {
  final NavigationController navigationController =
      Get.put(NavigationController());

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      backgroundColor: Colors.grey[300],
      selectedIndex: navigationController.selectedIndex.value,
      unselectedIconTheme: const IconThemeData(color: Colors.black, size: 25),
      selectedIconTheme: const IconThemeData(color: Colors.red, size: 40),
      onDestinationSelected: (int index) {
        navigationController.updateSelectedIndex(index);
        if (index == 0) {
          Get.to(() => Archives());
        }
        if (index == 1) {
          Get.off(() => Currency());
        }
        if (index == 2) {
          Get.to(() => Orders());
        }
      },
      labelType: NavigationRailLabelType.all,
      destinations: const [
        NavigationRailDestination(
          icon: Icon(Icons.supervised_user_circle),
          label: Text('Users'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.currency_lira_sharp),
          label: Text('Currencies'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.online_prediction_rounded),
          label: Text('Orders'),
        ),
      ],
    );
  }
}
