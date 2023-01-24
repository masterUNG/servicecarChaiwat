import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tumservicecar/states/create_new_account.dart';
import 'package:tumservicecar/utility/app_constant.dart';
import 'package:tumservicecar/utility/app_controller.dart';
import 'package:tumservicecar/widgets/widget_button.dart';
import 'package:tumservicecar/widgets/widget_form.dart';
import 'package:tumservicecar/widgets/widget_head.dart';
import 'package:tumservicecar/widgets/widget_icon_button.dart';
import 'package:tumservicecar/widgets/widget_text_button.dart';

class Authen extends StatelessWidget {
  const Authen({super.key});

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
                          changeFunc: (p0) {},
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        WidgetForm(
                          hint: 'password',
                          changeFunc: (p0) {},
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
                                pressFunc: () {},
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
}
