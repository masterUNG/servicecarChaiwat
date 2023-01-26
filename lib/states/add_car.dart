import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tumservicecar/models/car_model.dart';
import 'package:tumservicecar/utility/app_constant.dart';
import 'package:tumservicecar/utility/app_controller.dart';
import 'package:tumservicecar/utility/app_service.dart';
import 'package:tumservicecar/utility/app_snack_bar.dart';
import 'package:tumservicecar/widgets/widget_button.dart';
import 'package:tumservicecar/widgets/widget_form.dart';
import 'package:tumservicecar/widgets/widget_icon_button.dart';
import 'package:tumservicecar/widgets/widget_image.dart';
import 'package:tumservicecar/widgets/widget_text.dart';

class AddCar extends StatefulWidget {
  const AddCar({super.key});

  @override
  State<AddCar> createState() => _AddCarState();
}

class _AddCarState extends State<AddCar> {
  DateTime dateTime = DateTime.now();
  String? band, type, colorCar, registerCar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: WidgetText(
          text: 'Add Car',
          textStyle: AppConstant().h2Style(),
        ),
      ),
      body: LayoutBuilder(builder: (context, BoxConstraints boxConstraints) {
        return GetX(
            init: AppController(),
            builder: (AppController appController) {
              print('xFiles ----> ${appController.xFiles.length}');
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () =>
                    FocusScope.of(context).requestFocus(FocusScopeNode()),
                child: ListView(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 32),
                      child: WidgetText(
                        text: 'Time Record :\n ${dateTime.toLocal()}',
                        textStyle:
                            AppConstant().h3Style(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      width: boxConstraints.maxWidth,
                      height: 200,
                      child: appController.xFiles.isEmpty
                          ? WidgetImage(
                              path: 'images/image.png',
                              width: 200,
                            )
                          : ListView.builder(
                              scrollDirection: Axis.horizontal,
                              physics: ClampingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: appController.xFiles.length,
                              itemBuilder: (context, index) => Image.file(
                                File(appController.xFiles[index].path),
                                height: 180,
                              ),
                            ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 200,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              WidgetIconButton(
                                iconData: Icons.add_photo_alternate,
                                pressFunc: () {
                                  AppService().processChooseMultiImage();
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 250,
                      child: Column(
                        children: [
                          WidgetForm(
                            hint: 'ยี่ห้อรถ : ',
                            changeFunc: (p0) {
                              band = p0.trim();
                            },
                          ),
                          WidgetForm(
                            hint: 'รุ่นของรถ : ',
                            changeFunc: (p0) {
                              type = p0.trim();
                            },
                          ),
                          WidgetForm(
                            hint: 'สีรถ : ',
                            changeFunc: (p0) {
                              colorCar = p0.trim();
                            },
                          ),
                          WidgetForm(
                            hint: 'ทะเบียนรถ : ',
                            changeFunc: (p0) {
                              registerCar = p0.trim();
                            },
                          ),
                          WidgetButton(
                            label: 'ลงทะเบียน',
                            pressFunc: () {
                              if (appController.xFiles.isEmpty) {
                                AppSnackBar().narmalSnackbar(
                                  title: 'ยังไม่มีรูปรถ',
                                  message: 'กรูณาเลือกรูปรถอย่างน้อย 1 รูป',
                                  bgColor: Colors.red.shade700,
                                  textColor: Colors.white,
                                  snackPosition: SnackPosition.TOP,
                                );
                              } else if ((band?.isEmpty ?? true) ||
                                  (type?.isEmpty ?? true) ||
                                  (colorCar?.isEmpty ?? true) ||
                                  (registerCar?.isEmpty ?? true)) {
                                AppSnackBar().narmalSnackbar(
                                  title: 'กรอกไม่ครบ',
                                  message: 'กรุณากรอกให้ครบ',
                                  bgColor: Colors.red.shade700,
                                  textColor: Colors.white,
                                  snackPosition: SnackPosition.TOP,
                                );
                              } else {
                                AppService()
                                    .processUploadMultiImage()
                                    .then((value) {
                                  print(
                                      'upload finish --> ${appController.images}');
                                  var images = <String>[];
                                  for (var element in appController.images) {
                                    images.add(element);
                                  }

                                  processInsertCar(images: images);
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            });
      }),
    );
  }

  Future<void> processInsertCar({required List<String> images}) async {
    CarModel model = CarModel(
        brand: band!,
        type: type!,
        color: colorCar!,
        register: registerCar!,
        images: images,
        timeRecord: Timestamp.fromDate(dateTime));

    var user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection('user')
        .doc(user!.uid)
        .collection('car')
        .doc()
        .set(model.toMap())
        .then((value) {
          Get.back();
      AppSnackBar().narmalSnackbar(
          title: 'Insert Car success', message: 'WelCome insert Car succes');
      
    });
  }
}
