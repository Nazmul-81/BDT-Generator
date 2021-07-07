import 'package:bdt_generator/Widgets/condition.dart';
import 'package:bdt_generator/Widgets/my_button.dart';
import 'package:bdt_generator/Widgets/my_form_field.dart';
import 'package:bdt_generator/Widgets/snack_bar.dart';
import 'package:bdt_generator/Widgets/text_widget.dart';
import 'package:bdt_generator/constants.dart';
import 'package:bdt_generator/model/users.dart';
import 'package:bdt_generator/screen/Home/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class MyLoginBody extends StatefulWidget {
  @override
  _MyLoginBodyState createState() => _MyLoginBodyState();
}

class _MyLoginBodyState extends State<MyLoginBody> {
  bool isLogin = false;
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final numberController = TextEditingController();
  final referralCodeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
              ),
              MyCondition(
                condition: !isLogin,
                child: Center(
                  child: MyText(
                    label: "LOGIN",
                    size: 40.0,
                    color: Colors.white,
                  ),
                ),
                elseChild: Center(
                  child: MyText(
                    label: "Register",
                    size: 40.0,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              MyCondition(
                child: MyTextFormField(
                  controller: nameController,
                  labelText: "User Name",
                  validationMassage: "Name Required",
                  onChange: (val) {},
                  obscureText: false,
                  isPass: false,
                ),
                condition: isLogin,
              ),
              MyCondition(
                child: MyTextFormField(
                  controller: numberController,
                  labelText: "Mobile No",
                  validationMassage: "Number Required",
                  onChange: (val) {},
                  obscureText: false,
                  isPass: false,
                ),
                condition: isLogin,
              ),
              MyTextFormField(
                controller: emailController,
                labelText: "Email",
                validationMassage: "Email Required",
                onChange: (val) {},
                obscureText: false,
                isPass: false,
              ),
              MyTextFormField(
                controller: passwordController,
                labelText: "Password",
                validationMassage: "Password Required",
                onChange: (val) {},
                obscureText: true,
                isPass: true,
              ),
              MyCondition(
                child: MyTextFormField(
                  controller: referralCodeController,
                  labelText: "Referral Code",
                  validationMassage: null,
                  onChange: (val) {},
                  obscureText: false,
                  isPass: false,
                ),
                condition: isLogin,
              ),
              SizedBox(
                height: 10,
              ),
              MyCondition(
                condition: !isLogin,
                child: MyButton(
                  name: "Login",
                  onPressed: () {
                    setState(() {
                      isLoading = true;
                    });
                    MyUser.login(emailController.text, passwordController.text)
                        .then((value) {
                      setState(() {
                        isLoading = false;
                      });
                      print(value);
                      if (value == 200) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyHomePage()));
                      } else {
                        Scaffold.of(context).showSnackBar(MySnackBar(
                                "Something Error", Colors.white, Colors.red)
                            .mySnackBar);
                        setState(() {
                          isLoading = false;
                        });
                      }
                    });
                  },
                ),
                elseChild: MyButton(
                  name: "SignUp",
                  onPressed: () {
                    print('Pressed');
                    if (formKey.currentState.validate()) {
                      setState(() {
                        isLoading = true;
                      });
                      FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text)
                          .then((user) {
                        if (user != null) {
                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(user.user.uid)
                              .set({
                            'point': 0,
                            'uid': user.user.uid,
                            'name': nameController.text,
                            'email': emailController.text,
                            'password': passwordController.text,
                            'mobile': numberController.text,
                            'code': referralCodeController.text,
                            'addedReferral': 0,
                            'income': [
                              {'date': DateTime.now(), 'amount': 0},
                            ],
                            'referral': [
                              {'date': DateTime.now(), 'amount': 0},
                            ],
                          }).then((value) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyHomePage()));
                          }).catchError((e) {
                            Scaffold.of(context).showSnackBar(MySnackBar(
                                    "Something Error", Colors.white, Colors.red)
                                .mySnackBar);
                            setState(() {
                              isLoading = false;
                            });
                          });
                        } else {
                          Scaffold.of(context).showSnackBar(MySnackBar(
                                  "Something Error", Colors.white, Colors.red)
                              .mySnackBar);
                          setState(() {
                            isLoading = false;
                          });
                        }
                      }).catchError((e) {
                        Scaffold.of(context).showSnackBar(MySnackBar(
                                "Something Error", Colors.white, Colors.red)
                            .mySnackBar);
                        setState(() {
                          isLoading = false;
                        });
                      });
                    }
                  },
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    isLogin = !isLogin;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MyCondition(
                    condition: !isLogin,
                    child: MyText(
                      label: "Have no account? SignUp",
                      color: Colors.white,
                    ),
                    elseChild: MyText(
                      label: "Have an account?Login",
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    numberController.dispose();
    referralCodeController.dispose();
  }
}
