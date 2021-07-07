import 'package:bdt_generator/Widgets/my_form_field.dart';
import 'package:bdt_generator/Widgets/text_widget.dart';
import 'package:bdt_generator/model/users.dart';
import 'package:bdt_generator/screen/common.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:string_validator/string_validator.dart';

class MyWalletBody extends StatefulWidget {
  @override
  _MyWalletBodyState createState() => _MyWalletBodyState();
}

class _MyWalletBodyState extends State<MyWalletBody> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser.uid)
            .snapshots(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Something went wrong'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Text("Loading"),
            );
          }
          final doc = snapshot.data;
          setUserGlobal(doc);
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                ),
                OneRow(
                  name: "My Balance: ",
                  value: "${myUserMeGlobal.point} ৳",
                ),
                SizedBox(
                  height: 60,
                ),
                MaterialButton(
                  onPressed: () {
                    print("Withdraw");
                    _withdraw();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white12,
                    ),
                    padding: EdgeInsets.all(5),
                    child: Center(
                      child: OneRow(
                        name: "Withdraw",
                        value: "",
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                MaterialButton(
                  onPressed: () {
                    print("Send Money");
                    _sendMoney();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white12,
                    ),
                    padding: EdgeInsets.all(5),
                    child: Center(
                      child: OneRow(
                        name: "Send Money",
                        value: "",
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  final formKey = GlobalKey<FormState>();
  final addressController = TextEditingController();
  final amountController = TextEditingController();

  _sendMoney() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Money Transaction'),
              content: SingleChildScrollView(
                child: Theme(
                  data: ThemeData.dark(),
                  child: Form(
                    key: formKey,
                    child: ListBody(
                      children: <Widget>[
                        Text('(You can send if you have more than 100 ৳)'),
                        MyTextFormField(
                          onChange: (val) {},
                          validationMassage: "Receiver address required",
                          labelText: 'Receiver Address',
                          isPass: false,
                          obscureText: false,
                          controller: addressController,
                          color: Colors.green,
                        ),
                        MyTextFormField(
                          onChange: (val) {},
                          validationMassage: "Amount",
                          labelText: 'Enter an amount',
                          isPass: false,
                          obscureText: false,
                          controller: amountController,
                          color: Colors.green,
                        ),
                        Text('Are you sure?'),
                      ],
                    ),
                  ),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('Send'),
                  onPressed: () {
                    sendMoney();
                  },
                ),
              ],
            ));
  }

  sendMoney() {
    if (isNumeric(amountController.text)) {
      if (formKey.currentState.validate() &&
          int.parse(amountController.text) >= 100) {
        addTransaction(myUserMeGlobal.uid, -int.parse(amountController.text))
            .then((value) {
          addTransaction(
                  addressController.text, int.parse(amountController.text))
              .then((value) {
            Navigator.pop(context);
          });
        });
      }
    }
  }

  _withdraw() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Money Withdraw'),
              content: SingleChildScrollView(
                child: Theme(
                  data: ThemeData.dark(),
                  child: Form(
                    key: formKey,
                    child: ListBody(
                      children: <Widget>[
                        Text('(You can withdraw if you have more than 500 ৳)'),
                        MyTextFormField(
                          onChange: (val) {},
                          validationMassage: "Amount",
                          labelText: 'Enter an amount',
                          isPass: false,
                          obscureText: false,
                          controller: amountController,
                          color: Colors.green,
                        ),
                        Text('Are you sure?'),
                      ],
                    ),
                  ),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('Ok'),
                  onPressed: () {
                    withDraw();
                  },
                ),
              ],
            ));
  }

  withDraw() {
    if (isNumeric(amountController.text)) {
      if (formKey.currentState.validate()) {
        if (myUserMeGlobal.point >= 500 &&
            isDivisibleBy(amountController.text, 100)) {
          FirebaseFirestore.instance
              .collection('withdraw')
              .doc(myUserMeGlobal.uid)
              .get()
              .then((doc) {
            if (doc.exists) {
              Fluttertoast.showToast(
                  msg: "Your Previous Transaction is pending");
              Navigator.pop(context);
            } else {
              FirebaseFirestore.instance
                  .collection('withdraw')
                  .doc(myUserMeGlobal.uid)
                  .set({
                'name': myUserMeGlobal.name,
                'email': myUserMeGlobal.email,
                'amount': amountController.text,
                'mobile': myUserMeGlobal.mobile,
                'date': DateTime.now(),
              }).then((value) {
                addTransaction(
                        myUserMeGlobal.uid, -int.parse(amountController.text))
                    .then((value) {
                  Navigator.pop(context);
                });
              }).catchError((e) {
                Fluttertoast.showToast(msg: "Transaction Failed");
              });
            }
          });
        }
      } else {
        Fluttertoast.showToast(msg: "Transaction Failed");
      }
    }
  }

  @override
  void dispose() {
    addressController.dispose();
    amountController.dispose();
    super.dispose();
  }
}
