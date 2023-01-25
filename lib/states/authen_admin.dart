import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tumservicecar/states/main_home_admin.dart';
import 'package:tumservicecar/utility/app_constant.dart';
import 'package:tumservicecar/utility/app_controller.dart';
import 'package:tumservicecar/utility/app_snack_bar.dart';
import 'package:tumservicecar/widgets/widget_button.dart';
import 'package:tumservicecar/widgets/widget_form.dart';
import 'package:tumservicecar/widgets/widget_head.dart';
import 'package:tumservicecar/widgets/widget_icon_button.dart';

class AuthenAdmin extends StatefulWidget {
  const AuthenAdmin({super.key});

  @override
  State<AuthenAdmin> createState() => _AuthenAdminState();
}

class _AuthenAdminState extends State<AuthenAdmin> {
  String? email, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX(
          init: AppController(),
          builder: (AppController appController) {
            print('obsecu --> ${appController.obSecu}');
            return Container(
              decoration: AppConstant().bgBox(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 100),
                    width: 498,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const WidgetHead(),
                        Row(
                          children: [
                            WidgetForm(
                              width: 245,
                              hint: 'Email: ',
                              changeFunc: (p0) {
                                email = p0.trim();
                              },
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            WidgetForm(
                              width: 245,
                              hint: 'Password:',
                              obsecu: appController.obSecu.value,
                              changeFunc: (p0) {
                                password = p0.trim();
                              },
                              subfixWidget: WidgetIconButton(
                                iconData: Icons.remove_red_eye,
                                pressFunc: () {
                                  appController.obSecu.value =
                                      !appController.obSecu.value;
                                },
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            WidgetButton(
                              label: 'Login',
                              pressFunc: () {
                                if ((email?.isEmpty ?? true) ||
                                    (password?.isEmpty ?? true)) {
                                  AppSnackBar().narmalSnackbar(
                                    title: 'Have Space?',
                                    message: 'Please Fill Every Blank',
                                    snackPosition: SnackPosition.TOP,
                                    bgColor: Colors.red.shade400,
                                    textColor: Colors.white,
                                  );
                                } else {
                                  processCheckLogin();
                                }
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  Future<void> processCheckLogin() async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!)
        .then((value) {
      String uid = value.user!.uid;
      if (uid == AppConstant.uidAdmin) {
        //Admin true
        Get.offAll(const MainHomeAdmin());
        AppSnackBar().narmalSnackbar(
            title: 'login Success',
            message: 'Welcome to Web Admin',
            snackPosition: SnackPosition.TOP,
            bgColor: Theme.of(context).primaryColor);
      } else {
        AppSnackBar().narmalSnackbar(
          title: 'No Permission Admin',
          message: 'This Account please use in mobile',
          snackPosition: SnackPosition.TOP,
          bgColor: Colors.red.shade700,
          textColor: Colors.white,
        );
      }
    }).catchError((onError) {
      AppSnackBar().narmalSnackbar(
        title: onError.code,
        message: onError.message,
        snackPosition: SnackPosition.TOP,
        bgColor: Colors.red.shade700,
        textColor: Colors.white,
      );
    });
  }
}
