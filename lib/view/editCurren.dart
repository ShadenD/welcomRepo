// ignore_for_file: file_names, must_be_immutable
// // ignore_for_file: file_names, must_be_immutable

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:welcom/controller/currencyController.dart';

// class EditAddCurr extends GetView<CurrencyController> {
//   EditAddCurr({super.key});
//   TextEditingController c1 = TextEditingController();
//   TextEditingController c2 = TextEditingController();
//   TextEditingController c3 = TextEditingController();
//   CurrencyController c4 = Get.put(CurrencyController());
//   @override
//   Widget build(BuildContext context) {
//     c4.c1.text = Get.arguments['currency_name'];
//     c4.c2.text = Get.arguments['currency_symbol'];
//     c4.c3.text = Get.arguments['rate'];
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Edit Currency Here"),
//       ),
//       body: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//           TextFormField(
//             controller: c4.c1,
//             keyboardType: TextInputType.text,
//             decoration: InputDecoration(
//               contentPadding:
//                   const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
//               enabledBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.grey.shade400)),
//               border: OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.grey.shade400)),
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           TextFormField(
//             controller: c4.c2,
//             keyboardType: TextInputType.text,
//             decoration: InputDecoration(
//               contentPadding:
//                   const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//               enabledBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.grey.shade400)),
//               border: OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.grey.shade400)),
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           TextFormField(
//             controller: c4.c3,
//             keyboardType: TextInputType.number,
//             decoration: InputDecoration(
//               contentPadding:
//                   const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
//               enabledBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.grey.shade400)),
//               border: OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.grey.shade400)),
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           MaterialButton(
//             minWidth: double.infinity,
//             height: 60,
//             onPressed: () async {
//               await c4.updateCurreny();
//             },
//             color: Colors.greenAccent,
//             elevation: 0,
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
//             child: const Text(
//               "Edit_Currency",
//               style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
//             ),
//           )
//         ]),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:welcom/controller/currencyController.dart';

class EditCurr extends StatelessWidget {
  EditCurr({super.key});
  TextEditingController currname = TextEditingController();
  TextEditingController currsymbol = TextEditingController();
  TextEditingController currrate = TextEditingController();
  CurrencyController currencyController = Get.put(CurrencyController());

  @override
  Widget build(BuildContext context) {
    currname.text = Get.arguments['currency_name'];
    currsymbol.text = Get.arguments['currency_symbol'];
    currrate.text = Get.arguments['rate'];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Currency Here"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          TextFormField(
            controller: currname,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400)),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400)),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: currsymbol,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400)),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400)),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: currrate,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400)),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400)),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          MaterialButton(
            minWidth: double.infinity,
            height: 60,
            onPressed: () async {
              // await currencyController.updateCurreny({
              //   'currency_name': currname.text,
              //   'currency_symbol': currsymbol.text,
              //   'rate': currrate.text,
              // });
            },
            color: Colors.greenAccent,
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            child: const Text(
              "Edit_Currency",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
          )
        ]),
      ),
    );
  }
}
