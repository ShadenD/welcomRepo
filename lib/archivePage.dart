// ignore: file_names
import 'package:flutter/material.dart';
import 'package:welcom/editUser.dart';
import 'package:welcom/sqlitedb2.dart';

class Archives extends StatefulWidget {
  const Archives({super.key});

  @override
  State<Archives> createState() => _ArchivesState();
}

class _ArchivesState extends State<Archives> {
  SqlDB sqldb = SqlDB();
  List users = [];
  TextEditingController teSeach = TextEditingController();

  readData() async {
    List<Map> response = await sqldb.readData("SELECT * FROM users");
    users.addAll(response);
  }

  filter(String val) {
    setState(() {
      Iterable filterUser = users.where(
          (element) => element['username'] == val || element['email'] == val);
      users.replaceRange(0, users.length, filterUser.toList());
    });
  }

  @override
  void initState() {
    super.initState();
    readData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Users Archives"),
        leading: IconButton(
          onPressed: () {
            setState(() {
              Navigator.pop(context);
            });
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    if (value == '') {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const Archives()));
                    }
                  });
                },
                controller: teSeach,
                decoration: InputDecoration(
                    hintText: 'Search...',
                    labelText: 'Search',
                    prefixIcon: TextButton(
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          await filter(teSeach.text);
                        },
                        child: const Icon(Icons.search)),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    )),
              ),
            ),
            ListView.builder(
              itemCount: users.length,
              shrinkWrap: true,
              itemBuilder: (context, i) {
                return Container(
                  // height: 150,
                  child: Card(
                    elevation: 9,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child: ListTile(
                      dense: false,
                      title: Text(
                        "${users[i]['id']}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      subtitle: Column(children: [
                        Text(
                          "${users[i]['username']}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text(
                          "${users[i]['email']}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ]),
                      trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                        IconButton(
                            onPressed: () async {
                              int response = await sqldb.deletData(
                                  "DELETE FROM users WHERE id=${users[i]['id']}");
                              if (response > 0) {
                                // ignore: use_build_context_synchronously
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Archives()));
                              }
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            )),
                        IconButton(
                            onPressed: () async {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Edit(
                                        id: users[i]['id'],
                                        username: users[i]['username'],
                                        email: users[i]['email'],
                                        pass: users[i]['pass'],
                                      )));
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
            // Add your other widgets here if needed
          ],
        ),
      ),
    );
  }
}
