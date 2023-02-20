import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tumservicecar/states/create_new_account.dart';
import 'package:tumservicecar/states/main_home.dart';
import 'package:tumservicecar/utility/app_constant.dart';
import 'package:tumservicecar/utility/app_controller.dart';
import 'package:tumservicecar/utility/app_snack_bar.dart';
import 'package:tumservicecar/widgets/widget_button.dart';
import 'package:tumservicecar/widgets/widget_form.dart';
import 'package:tumservicecar/widgets/widget_head.dart';
import 'package:tumservicecar/widgets/widget_icon_button.dart';
import 'package:tumservicecar/widgets/widget_text_button.dart';

class Authen extends StatefulWidget {
  const Authen({super.key});

  @override
  State<Authen> createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  String? email, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX(
          init: AppController(),
          builder: (AppController appController) {
            print('obSecu --> ${appController.obSecu}');
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () =>
                  FocusScope.of(context).requestFocus(FocusScopeNode()),
              child: Container(
                decoration: AppConstant().bgBox(),
                child: ListView(
                  children: [
                    const WidgetHead(
                      marginTop: 50,
                      marginLeft: 32,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        WidgetForm(
                          hint: 'Email',
                          changeFunc: (p0) {
                            email = p0.trim();
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        WidgetForm(
                          hint: 'password',
                          changeFunc: (p0) {
                            password = p0.trim();
                          },
                          obsecu: appController.obSecu.value,
                          subfixWidget: WidgetIconButton(
                            iconData: Icons.remove_red_eye,
                            pressFunc: () {
                              appController.obSecu.value =
                                  !appController.obSecu.value;
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 250,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              WidgetButton(
                                label: 'login',
                                pressFunc: () {
                                  if ((email?.isEmpty ?? true) ||
                                      (password?.isEmpty ?? true)) {
                                    AppSnackBar().normalSnackbar(
                                        title: 'Have space?',
                                        message: 'Please Fill Every Blank',
                                        bgColor:
                                            Theme.of(context).primaryColor);
                                  } else {
                                    processCheckLogin();
                                  }
                                },
                                width: 125,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    WidgetTextButton(
                      label: 'Create New Account',
                      pressFunc: () {
                        Get.to(const CreatNewAccount());
                      },
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }

  Future<void> processCheckLogin() async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!)
        .then((value) {
      Get.offAll(const MainHome());
      AppSnackBar().normalSnackbar(
          title: 'Welcome to App', message: 'Welcome Service Car');
    }).catchError((onError) {
      AppSnackBar().normalSnackbar(
          title: onError.code,
          message: onError.message,
          bgColor: Colors.red,
          textColor: Colors.white);
    });
  }
}
