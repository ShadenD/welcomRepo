// ignore_for_file: file_names, must_be_immutable
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:welcom/controller/archivecontroller.dart';
import 'package:welcom/controller/drawercontroller.dart';
import 'package:welcom/model/sqlitedb2.dart';
import 'package:welcom/view/editUser.dart';
import 'package:welcom/view/home.dart';

class Archives extends GetView<ArchiveController> {
  Archives({super.key});
  SqlDB sqldb = SqlDB();
  TextEditingController teSeach = TextEditingController();
  DrawerController1 controller1 = Get.put(DrawerController1());
  ArchiveController archivecontroller = Get.put(ArchiveController());
  var scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
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
                controller1.usersOpen();
                scaffoldkey.currentState!.closeDrawer();
              },
              title: const Text('Users'),
            ),
            ListTile(
              onTap: () {
                controller1.currencyOpen();
                scaffoldkey.currentState!.closeDrawer();
              },
              title: const Text('Currency'),
            ),
            ListTile(
              onTap: () {
                controller1.orederOpen();
                scaffoldkey.currentState!.closeDrawer();
              },
              title: const Text('Orders'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Users Archives"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () {
              Get.to(() => HomePage());
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                onChanged: (value) {
                  if (value == '') {
                    Get.to(() => Archives());
                  }
                },
                controller: teSeach,
                decoration: InputDecoration(
                    hintText: 'Search...',
                    labelText: 'Search',
                    prefixIcon: TextButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          archivecontroller.filter(teSeach.text);
                        },
                        child: const Icon(Icons.search)),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    )),
              ),
            ),
            Obx(
              () => ListView.builder(
                itemCount: archivecontroller.users.length,
                shrinkWrap: true,
                itemBuilder: (context, i) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    // height: 150,
                    child: Card(
                      elevation: 9,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      child: ListTile(
                        dense: false,
                        leading: Image.file(
                          File('${archivecontroller.users[i]['photo']}'),
                        ),
                        title: Text(
                          "${archivecontroller.users[i]['id']}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        subtitle: Column(children: [
                          Text(
                            "${archivecontroller.users[i]['username']}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text(
                            "${archivecontroller.users[i]['email']}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ]),
                        trailing:
                            Row(mainAxisSize: MainAxisSize.min, children: [
                          IconButton(
                              onPressed: () async {
                                await archivecontroller.deleteuser(
                                    archivecontroller.users[i]['id']);
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              )),
                          IconButton(
                              onPressed: () async {
                                Get.to(Editarchive(), arguments: {
                                  "id": archivecontroller.users[i]['id'],
                                  "username": archivecontroller.users[i]['username'],
                                  "email": archivecontroller.users[i]['email'],
                                  "pass": archivecontroller.users[i]['pass'],
                                  "photo": archivecontroller.users[i]['photo'],
                                });
                              },
                              icon: const Icon(
                                Icons.update,
                                color: Colors.black,
                              )),
                        ]),
                      ),
                    ),
                  );
                },
              ),
            ),
            // Add your other widgets here if needed
          ],
        ),
      ),
    );
  }
}
