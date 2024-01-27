import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:welcom/login2.dart';
import 'package:welcom/sqlitedb2.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPage();
}

class _SignupPage extends State<SignupPage> {
  TextEditingController textEditingController = TextEditingController();
  TextEditingController userEditingController = TextEditingController();

  TextEditingController passEditingController = TextEditingController();
  bool isEmailCorrect = false;
  bool passToggle = true;
//  final bool _isPasswordEightCharacters = false;
  // final bool _hasPasswordOneNumber = false;
  final TextEditingController controller = TextEditingController();
  bool success = false;
  late String vall;

  TextEditingController confirmpassword = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey();
  onPasswordChanged(String password) {
    final numericRegex = RegExp(r'[0-9]');

    setState(() {
      if (password.length >= 8) {}

      if (numericRegex.hasMatch(password)) {}
    });
  }

  SqlDB sqldb = SqlDB();
  Future<List<Map>> readData() async {
    List<Map> response = await sqldb.readData("SELECT * FROM users");
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height - 30,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  FadeInUp(
                      duration: const Duration(milliseconds: 1000),
                      child: const Text(
                        "Sign up",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  FadeInUp(
                      duration: const Duration(milliseconds: 1200),
                      child: Text(
                        "Create an account, It's free",
                        style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                      )),
                ],
              ),
              Form(
                key: formstate,
                child: Column(
                  children: <Widget>[
                    const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Email",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.black87),
                          ),
                        ]),
                    const SizedBox(
                      height: 2,
                    ),
                    FadeInUp(
                        duration: const Duration(milliseconds: 1200),
                        child: TextFormField(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade400)),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade400)),
                          ),
                          controller: textEditingController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            vall = value!;
                            if (value.isEmpty) {
                              return "الحقل فارغ";
                            } else if (RegExp(
                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                .hasMatch(value)) {
                            } else {
                              return "Enter valid Email";
                            }
                            return null;
                          },
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "User Name",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.black87),
                          ),
                        ]),
                    const SizedBox(
                      height: 2,
                    ),
                    FadeInUp(
                        duration: const Duration(milliseconds: 1200),
                        child: TextFormField(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade400)),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade400)),
                          ),
                          controller: userEditingController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            vall = value!;
                            if (value.isEmpty) {
                              return "الحقل فارغ";
                            }
                            return null;
                          },
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "passward",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.black87),
                          ),
                        ]),
                    const SizedBox(
                      height: 2,
                    ),
                    FadeInUp(
                        duration: const Duration(milliseconds: 1200),
                        child: TextFormField(
                          onChanged: (password) => onPasswordChanged(password),
                          obscureText: passToggle,
                          decoration: InputDecoration(
                            suffix: InkWell(
                              onTap: () {
                                setState(() {
                                  passToggle = !passToggle;
                                });
                              },
                              child: Icon(
                                passToggle
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade400)),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade400)),
                          ),
                          controller: passEditingController,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter your passward";
                            } else if (passEditingController.text.length < 6) {
                              return "Passward length should be more than 6 characters ";
                            }
                            return null;
                          },
                        )),
                    const SizedBox(
                      height: 2,
                    ),
                    const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Confirm passward",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.black87),
                          ),
                        ]),
                    const SizedBox(
                      height: 5,
                    ),
                    FadeInUp(
                        duration: const Duration(milliseconds: 1200),
                        child: TextFormField(
                          onChanged: (password) => onPasswordChanged(password),
                          obscureText: passToggle,
                          decoration: InputDecoration(
                            suffix: InkWell(
                              onTap: () {
                                setState(() {
                                  passToggle = !passToggle;
                                });
                              },
                              child: Icon(
                                passToggle
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade400)),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade400)),
                          ),
                          controller: confirmpassword,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please re-enter password';
                            }

                            if (passEditingController.text !=
                                confirmpassword.text) {
                              return "Password does not match";
                            }

                            return null;
                          },
                        )),
                    const SizedBox(
                      height: 2,
                    ),
                    FlutterPwValidator(
                      defaultColor: Colors.black,
                      controller: passEditingController,
                      successColor: Colors.green.shade700,
                      minLength: 8,
                      uppercaseCharCount: 1,
                      numericCharCount: 2,
                      specialCharCount: 1,
                      normalCharCount: 4,
                      width: 350,
                      height: 150,
                      onSuccess: () {
                        setState(() {
                          success = true;
                        });
                      },
                      onFail: () {
                        setState(() {
                          success = false;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                  ],
                ),
              ),
              FadeInUp(
                  duration: const Duration(milliseconds: 1500),
                  child: Container(
                    padding: const EdgeInsets.only(top: 3, left: 3),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: const Border(
                          bottom: BorderSide(color: Colors.black),
                          top: BorderSide(color: Colors.black),
                          left: BorderSide(color: Colors.black),
                          right: BorderSide(color: Colors.black),
                        )),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: () async {
                        if (formstate.currentState!.validate()) {
                          var response = await sqldb.insertData(
                              "INSERT INTO 'users' ('username','email','pass','bod') VALUES('${userEditingController.text}','${textEditingController.text}','${passEditingController.text}','30-11-2001')");
                          // ignore: avoid_print
                          print(response);
                          // ignore: avoid_print
                          print("Data filled successfully");
                          textEditingController.clear();
                          passEditingController.clear();
                          confirmpassword.clear();
                        }
                      },
                      color: Colors.greenAccent,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      child: const Text(
                        "Sign up",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                    ),
                  )),
              FadeInUp(
                  duration: const Duration(milliseconds: 1600),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account?"),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Loginpage2()),
                          );
                        },
                        child: const Text(
                          " Login",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
