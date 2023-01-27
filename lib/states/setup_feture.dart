import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tumservicecar/models/car_model.dart';
import 'package:tumservicecar/models/expire_model.dart';
import 'package:tumservicecar/models/feture_model.dart';
import 'package:tumservicecar/models/user_model.dart';
import 'package:tumservicecar/utility/app_constant.dart';
import 'package:tumservicecar/utility/app_controller.dart';
import 'package:tumservicecar/utility/app_snack_bar.dart';
import 'package:tumservicecar/widgets/widget_button.dart';
import 'package:tumservicecar/widgets/widget_text.dart';

class SetupFeture extends StatefulWidget {
  const SetupFeture({
    Key? key,
    required this.docIdFetures,
    required this.fetureModel,
    required this.carModel,
    required this.docIdCar,
  }) : super(key: key);

  final String docIdFetures;
  final FetureModel fetureModel;
  final CarModel carModel;
  final String docIdCar;

  @override
  State<SetupFeture> createState() => _SetupFetureState();
}

class _SetupFetureState extends State<SetupFeture> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: WidgetText(
          text: 'Setup ${widget.fetureModel.feture}',
          textStyle: AppConstant().h2Style(),
        ),
      ),
      body: LayoutBuilder(builder: (context, BoxConstraints boxConstraints) {
        return GetX(
            init: AppController(),
            builder: (AppController appController) {
              print('chooseDateTime -->${appController.chooseDateTime.length}');
              return SizedBox(
                width: boxConstraints.maxWidth,
                child: ListView(
                  children: [
                    WidgetText(
                      text: widget.carModel.brand,
                      textStyle: AppConstant().h2Style(),
                    ),
                    WidgetText(
                      text: widget.carModel.type,
                      textStyle: AppConstant().h3Style(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        WidgetText(
                          text: appController.chooseDateTime.isEmpty
                              ? 'dd/MM/yyyy'
                              : appController.chooseDateTime.last.toString(),
                          textStyle: AppConstant().h2Style(),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        WidgetButton(
                          label: 'Expire Date',
                          pressFunc: () async {
                            DateTime dateTime = DateTime.now();
                            await showDatePicker(
                                    context: context,
                                    initialDate: dateTime,
                                    firstDate: dateTime,
                                    lastDate: DateTime(dateTime.year + 2))
                                .then((value) {
                              print('value Choose --> $value');

                              appController.chooseDateTime.add(value);
                            });
                          },
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        WidgetButton(
                          label: 'Setup',
                          pressFunc: () async {
                            if (appController.chooseDateTime.isEmpty) {
                              AppSnackBar().narmalSnackbar(
                                  title: 'วันหมดอายุ',
                                  message: 'โปรดเลือกวันหมดอายุ',
                                  snackPosition: SnackPosition.TOP,
                                  bgColor: Colors.red.shade700,
                                  textColor: Colors.white);
                            } else {
                              String docIdCar = widget.docIdCar;
                              print('##27jan docIdCar --> $docIdCar');

                              ExpireModel expireModel = ExpireModel(
                                feture: widget.fetureModel.feture,
                                timeExpire: Timestamp.fromDate(
                                    appController.chooseDateTime.last),
                                docIdFeture: widget.docIdFetures,
                              );

                              var user = FirebaseAuth.instance.currentUser;

                              //step 1; Insert Expire Data
                              await FirebaseFirestore.instance
                                  .collection('user')
                                  .doc(user!.uid)
                                  .collection('car')
                                  .doc(docIdCar)
                                  .collection('expire')
                                  .doc()
                                  .set(expireModel.toMap())
                                  .then((value) {
                                appController.chooseDateTime.clear();
                                Get.back();
                              });
                            }
                          },
                          bgColor: Colors.green,
                          textColor: Colors.white,
                        )
                      ],
                    )
                  ],
                ),
              );
            });
      }),
    );
  }
}
