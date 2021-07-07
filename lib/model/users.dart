import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

MyUser myUserMeGlobal = MyUser();

class MyUser {
  String name;
  String email;
  String code;
  String mobile;
  String password;
  String uid;
  int addReferral;
  int point = 0;
  int todayIncome = 0;
  int lastWeekIncome = 0;
  int lastMonthIncome = 0;
  int lastYearIncome = 0;
  int lifeTimeIncome = 0;

  int totalReferral = 0;
  int referralYearly = 0;
  int commission = 0;

  List<dynamic> income;
  List<dynamic> referral;
  bd(uid) async {
    final val =
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'point': 0,
      'uid': uid,
      'name': name,
      'email': email,
      'password': password,
      'mobile': mobile,
      'code': code,
      'addedReferral': 0,
      'income': [
        {'date': DateTime.now(), 'amount': 0},
      ],
      'referral': [
        {'date': DateTime.now(), 'amount': 0},
      ],
    }).then((value) {
      print("OK");
      return 200;
    }).catchError((e) {
      print(e);
      return -2;
    });
  }

  static Future<UserCredential> createUser(String name, String email,
      String password, String mobile, String code) async {
    final user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((user) {
      print(user);
    });
    return user;
  }

  static Future<int> login(email, password) async {
    final value = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((user) {
      print(user);
      if (user.user != null) {
        print(email);
        print(password);
        return 200;
      } else {
        return -1;
      }
    }).catchError((e) {
      print(e);
      return -1;
    });
    print("after ");
    return value;
  }

  static void setIncomes() {
    myUserMeGlobal.todayIncome = 0;
    myUserMeGlobal.lastWeekIncome = 0;
    myUserMeGlobal.lastMonthIncome = 0;
    myUserMeGlobal.lastYearIncome = 0;
    myUserMeGlobal.lifeTimeIncome = 0;
    myUserMeGlobal.income.forEach((element) {
      DateTime date = element['date'].toDate();
      myUserMeGlobal.lifeTimeIncome += element['amount'];
      if (date.day == DateTime.now().day) {
        myUserMeGlobal.todayIncome += element['amount'];
      }
      if (date.isAfter(DateTime.now().subtract(Duration(days: 30)))) {
        myUserMeGlobal.lastMonthIncome += element['amount'];
      }
      if (date.isAfter(DateTime.now().subtract(Duration(days: 365)))) {
        myUserMeGlobal.lastYearIncome += element['amount'];
      }
      if (date.isAfter(DateTime.now().subtract(Duration(days: 7)))) {
        myUserMeGlobal.lastWeekIncome += element['amount'];
      }
      print(date);
      print(date.weekday);
      print(DateTime.now().weekday);
    });
  }

  static void setReferrals() {
    myUserMeGlobal.totalReferral = myUserMeGlobal.referral.length - 1;
    myUserMeGlobal.referralYearly = -1;
    myUserMeGlobal.commission = (myUserMeGlobal.referral.length - 1) * 5;
    myUserMeGlobal.referral.forEach((element) {
      DateTime date = element['date'].toDate();
      if (date.isAfter(DateTime.now().subtract(Duration(days: 365)))) {
        myUserMeGlobal.referralYearly++;
      }
    });
  }
}

setUserGlobal(doc) {
  print("COOOOOOOOOOOOOOOOOOOOOOOOOOOOO");
  print(myUserMeGlobal.code);
  if (myUserMeGlobal.code != null && myUserMeGlobal.code != "") {
    if (myUserMeGlobal.lifeTimeIncome >= 100) {
      print("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");
      addTransaction(myUserMeGlobal.code, 10).then((value) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(myUserMeGlobal.uid)
            .update({'code': null});
      });
    }
  }
  myUserMeGlobal.code = doc.data()['code'];
  myUserMeGlobal.email = doc.data()['email'];
  myUserMeGlobal.income = doc.data()['income'];
  myUserMeGlobal.mobile = doc.data()['mobile'];
  myUserMeGlobal.name = doc.data()['name'];
  myUserMeGlobal.password = doc.data()['password'];
  myUserMeGlobal.referral = doc.data()['referral'];
  myUserMeGlobal.uid = doc.data()['uid'];
  myUserMeGlobal.point = doc.data()['point'];
  myUserMeGlobal.addReferral = doc.data()['addReferral'];
  MyUser.setIncomes();
}

updateGlobal() {
  FirebaseFirestore.instance
      .collection('users')
      .doc(myUserMeGlobal.uid)
      .get()
      .then((doc) {
    setUserGlobal(doc);
  });
}

Future addTransaction(uid, amount) async {
  List income;
  final data = await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .get()
      .then((doc) {
    income = doc.data()['income'];
    print(income);
    income.add({'amount': amount, 'date': DateTime.now()});
  }).then((value) {
    FirebaseFirestore.instance.collection('users').doc(uid).update({
      'income': income,
      'point': myUserMeGlobal.point + amount,
    }).then((value) {
      updateGlobal();
      Fluttertoast.showToast(msg: "Transaction Successful");
    }).catchError((e) {
      Fluttertoast.showToast(msg: "Transaction Failed");
    });
  }).catchError((e) {
    Fluttertoast.showToast(msg: "Transaction Failed");
  });
  return data;
}
