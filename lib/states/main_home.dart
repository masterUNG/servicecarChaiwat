import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tumservicecar/bodys/body_feture_mobile.dart';
import 'package:tumservicecar/bodys/body_profile_mobile.dart';
import 'package:tumservicecar/utility/app_constant.dart';
import 'package:tumservicecar/utility/app_controller.dart';
import 'package:tumservicecar/utility/app_dialog.dart';
import 'package:tumservicecar/utility/app_service.dart';
import 'package:tumservicecar/widgets/widget_image.dart';
import 'package:tumservicecar/widgets/widget_menu.dart';
import 'package:tumservicecar/widgets/widget_text.dart';
import 'package:tumservicecar/widgets/widget_text_button.dart';

class MainHome extends StatefulWidget {
  const MainHome({super.key});

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  var bodys = <Widget>[
    const BodyfetureMobile(),
    const BodyProfileMobile(),
  ];

  var titles = <String>[
    'Feture',
    'Profile',
  ];

  @override
  void initState() {
    super.initState();
    AppService().findUserModel();
    AppService().findCarModels();
  }

  @override
  Widget build(BuildContext context) {
    return GetX(
        init: AppController(),
        builder: (AppController appController) {
          print('carModels --> ${appController.carModels.length}');
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              centerTitle: true,
              title: WidgetText(
                text: titles[appController.indexBody.value],
                textStyle: AppConstant().h2Style(),
              ),
            ),
            drawer: Drawer(
              child: Column(
                children: [
                  UserAccountsDrawerHeader(
                    decoration: AppConstant().bgBox(),
                    accountName: WidgetText(
                      text: appController.userModels.isEmpty
                          ? 'Name'
                          : appController.userModels.last.displayName,
                      textStyle: AppConstant().h2Style(color: Colors.white),
                    ),
                    accountEmail: WidgetText(
                      text: appController.carModels.isNotEmpty
                          ? ''
                          : '< ยังไม่ได้ลงทะเบียนรถ >',
                      textStyle: AppConstant().h3Style(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange.shade200),
                    ),
                    currentAccountPicture: WidgetImage(),
                  ),
                  WidgetMenu(
                    title: 'Feture',
                    leadWidget: const WidgetImage(
                      path: 'images/feture.png',
                      width: 48,
                    ),
                    pressFunc: () {
                      appController.indexBody.value = 0;
                      Get.back();
                    },
                  ),
                  WidgetMenu(
                    title: 'Profile',
                    leadWidget: WidgetImage(
                      path: 'images/profile.png',
                      width: 48,
                    ),
                    pressFunc: () {
                      appController.indexBody.value = 1;
                      Get.back();
                    },
                  ),
                  const Spacer(),
                  const Divider(
                    color: Colors.black,
                  ),
                  WidgetMenu(
                    title: 'Sign Out',
                    leadWidget: WidgetImage(
                      path: 'images/signout.png',
                      width: 48,
                    ),
                    pressFunc: () {
                      Get.back();

                      AppDialog(context: context).normalDialog(
                          title: 'Sign Out ?',
                          subTitle: 'Plase confirm sign out',
                          iconWidget: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              WidgetImage(
                                width: 100,
                                path: 'images/signout.png',
                              ),
                            ],
                          ),
                          secondActionWidget: WidgetTextButton(
                            label: 'Confirm',
                            textColor: Colors.green,
                            pressFunc: () {
                              AppService().processSignOut();
                            },
                          ));
                    },
                  ),
                ],
              ),
            ),
            body: bodys[appController.indexBody.value],
          );
        });
  }
}
