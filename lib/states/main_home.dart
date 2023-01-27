import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:tumservicecar/bodys/body_feture_mobile.dart';
import 'package:tumservicecar/bodys/body_profile_mobile.dart';
import 'package:tumservicecar/models/expire_model.dart';
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
    'My Car',
  ];

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  InitializationSettings? initializationSettings;
  AndroidInitializationSettings? androidInitializationSettings;

  @override
  void initState() {
    super.initState();
    AppService().findUserModel();
    AppService().findCarModels();
    AppService().processReadFeture();
    setupLocalNoti();
    processFindTimeNoti();
  }

  Future<void> processFindTimeNoti() async {
    var user = FirebaseAuth.instance.currentUser;
    var expireModels = <ExpireModel>[];
    var expireSortedModels = <ExpireModel>[];

    await FirebaseFirestore.instance
        .collection('user')
        .doc(user!.uid)
        .collection('car')
        .get()
        .then((value) async {
      if (value.docs.isNotEmpty) {
        for (var element in value.docs) {
          await FirebaseFirestore.instance
              .collection('user')
              .doc(user.uid)
              .collection('car')
              .doc(element.id)
              .collection('expire')
              .get()
              .then((value) {
            for (var element2 in value.docs) {
              ExpireModel model = ExpireModel.fromMap(element2.data());
              expireModels.add(model);
            }
          });
        }
        print('expireModel  --> ${expireModels.length}');

        var expireMaps = <Map<String, dynamic>>[];
        for (var element3 in expireModels) {
          var map = element3.toMap();
          expireMaps.add(map);
        }

        expireMaps.sort(
          (a, b) => b['timeExpire'].compareTo(a['timeExpire']),
        );
        for (var element4 in expireMaps) {
          ExpireModel model = ExpireModel.fromMap(element4);
          expireSortedModels.add(model);
        }
        String timeNoti = AppService()
            .changeToString(timestamp: expireSortedModels.last.timeExpire);
        print('##27jan timeNoti ---> $timeNoti');

        DateTime dateNoti = expireSortedModels.last.timeExpire.toDate();
        print('##27jan dateNoti --> $dateNoti');

        //ตัวอย่างการแจ้งล่วงหน้า 2 วัน
        dateNoti = DateTime(dateNoti.year, dateNoti.month, dateNoti.day - 2);
        print('##27jan dateNoti หลัง --> $dateNoti');

        DateTime text = DateTime.now().add(Duration(days: 2));

        await Future.delayed(
          dateNoti.difference(
            DateTime.now(),
          ),
          () {
            processDisplayNoti(
                title: expireSortedModels.last.feture,
                body: 'ได้เวลากระทำแล้วครับ');
          },
        );
      }
    }); //end
  }

  Future<void> setupLocalNoti() async {
    androidInitializationSettings =
        const AndroidInitializationSettings('app_icon');
    initializationSettings =
        InitializationSettings(android: androidInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings!);
  }

  Future<void> onSelectNoti(String? string) async {}

  Future<void> processDisplayNoti(
      {required String title, required String body}) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails('channelId', 'channelName',
            priority: Priority.high,
            importance: Importance.max,
            ticker: 'test');

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin.show(
        0, title, body, notificationDetails);
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
                    title: titles[0],
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
                    title: titles[1],
                    leadWidget: const WidgetImage(
                      path: 'images/profile.png',
                      width: 48,
                    ),
                    pressFunc: () {
                      appController.indexBody.value = 1;
                      Get.back();
                    },
                  ),
                  WidgetMenu(
                    title: 'Test Notification',
                    leadWidget: WidgetImage(
                      path: 'images/noti.png',
                      width: 48,
                    ),
                    pressFunc: () {
                      processDisplayNoti(
                          title: 'ทดสอบแจ้งเตือน',
                          body: 'รายละเอียดของการแจ้งเตือน');
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
