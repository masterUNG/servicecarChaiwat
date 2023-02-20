import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tumservicecar/models/user_model.dart';
import 'package:tumservicecar/utility/app_constant.dart';
import 'package:tumservicecar/utility/app_snack_bar.dart';
import 'package:tumservicecar/widgets/widget_button.dart';
import 'package:tumservicecar/widgets/widget_form.dart';
import 'package:tumservicecar/widgets/widget_text.dart';

class CreatNewAccount extends StatefulWidget {
  const CreatNewAccount({super.key});

  @override
  State<CreatNewAccount> createState() => _CreatNewAccountState();
}

class _CreatNewAccountState extends State<CreatNewAccount> {
  String? name, email, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: WidgetText(
          text: 'Create New Account',
          textStyle: AppConstant().h2Style(),
        ),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque, //แต๊ะที่หน้าจอแล้วให้คีย์บอร์ดหาย
        onTap: () => FocusScope.of(context).requestFocus(FocusScopeNode()),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                WidgetForm(
                  hint: 'Display Name:',
                  changeFunc: (p0) {
                    name = p0.trim();
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                WidgetForm(
                  hint: 'Email : ',
                  changeFunc: (p0) {
                    email = p0.trim();
                  },
                  textInputType: TextInputType.emailAddress,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                WidgetForm(
                  hint: 'Pass word:',
                  changeFunc: (p0) {
                    password = p0.trim();
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                WidgetButton(
                  label: 'Create New Account',
                  pressFunc: () {
                    if ((name?.isEmpty ?? true) ||
                        (email?.isEmpty ?? true) ||
                        (password?.isEmpty ?? true)) {
                      AppSnackBar().normalSnackbar(
                          title: 'Have space',
                          message: 'Please Every Blank',
                          bgColor: Colors.red.withOpacity(0.5));
                    } else {
                      processCreateNewAccount();
                    }
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> processCreateNewAccount() async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!)
        .then((value) async {
      String uid = value.user!.uid;
      UserModel model = UserModel(
        displayName: name!,
        uid: uid,
        email: email!,
        password: password!,
      );

      await FirebaseFirestore.instance
          .collection('user')
          .doc(uid)
          .set(model.toMap())
          .then((value) {
        Get.back();
        AppSnackBar().normalSnackbar(
            title: 'Create New Account Success', message: 'Please login');
      });
    }).catchError((onError) {
      AppSnackBar()
          .normalSnackbar(title: onError.code, message: onError.message);
    });
  }
}
