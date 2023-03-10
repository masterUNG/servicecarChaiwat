import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tumservicecar/bodys/body_profile_mobile.dart';
import 'package:tumservicecar/main.dart';
import 'package:tumservicecar/models/car_model.dart';
import 'package:tumservicecar/states/add_car.dart';
import 'package:tumservicecar/states/authen_admin.dart';
import 'package:tumservicecar/states/main_home.dart';
import 'package:tumservicecar/utility/app_constant.dart';
import 'package:tumservicecar/utility/app_controller.dart';
import 'package:tumservicecar/utility/app_dialog.dart';
import 'package:tumservicecar/utility/app_service.dart';
import 'package:tumservicecar/utility/app_snack_bar.dart';
import 'package:tumservicecar/widgets/widget_form.dart';
import 'package:tumservicecar/widgets/widget_icon_button.dart';

import 'package:tumservicecar/widgets/widget_text.dart';
import 'package:tumservicecar/widgets/widget_text_button.dart';

class DetailCar extends StatefulWidget {
  const DetailCar({
    Key? key,
    required this.docIdCar,
    required this.carModel,
  }) : super(key: key);

  final String docIdCar;
  final CarModel carModel;

  @override
  State<DetailCar> createState() => _DetailCarState();
}

class _DetailCarState extends State<DetailCar> {
  var user = FirebaseAuth.instance.currentUser;
  Map<String, dynamic> data = {};
  CarModel? carModel;
  String? docIdCar;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AppService().readExpireModels(docIdCar: widget.docIdCar);
    carModel = widget.carModel;
    docIdCar = widget.docIdCar;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: WidgetText(
          text: 'Detail Car',
          textStyle: AppConstant().h2Style(),
        ),
      ),
      body: GetX(
          init: AppController(),
          builder: (AppController appController) {
            print('expireModels --> ${appController.expireModels.length}');
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    WidgetText(
                      text: carModel!.brand,
                      textStyle: AppConstant().h2Style(),
                    ),
                    WidgetIconButton(
                      iconData: Icons.edit,
                      pressFunc: () {
                        processEditDataCar(
                            string: carModel!.brand,
                            keyMap: 'brand',
                            appController: appController);
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    WidgetText(
                      text: carModel!.type,
                      textStyle: AppConstant().h3Style(),
                    ),
                    WidgetIconButton(
                      iconData: Icons.edit,
                      pressFunc: () {
                        processEditDataCar(
                            string: carModel!.type,
                            keyMap: 'type',
                            appController: appController);
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    WidgetText(
                      text: carModel!.color,
                      textStyle: AppConstant().h3Style(),
                    ),
                    WidgetIconButton(
                      iconData: Icons.edit,
                      pressFunc: () {
                        processEditDataCar(
                            string: carModel!.color,
                            keyMap: 'color',
                            appController: appController);
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    WidgetText(
                      text: carModel!.register,
                      textStyle: AppConstant().h3Style(),
                    ),
                    WidgetIconButton(
                      iconData: Icons.edit,
                      pressFunc: () {
                        processEditDataCar(
                            string: carModel!.register,
                            keyMap: 'register',
                            appController: appController);
                      },
                    ),
                  ],
                ),
                Card(
                  child: WidgetTextButton(
                    label: 'Delete Car',
                    size: 18,
                    textColor: Colors.red.shade700,
                    pressFunc: () async {
                      processDeleteCar(
                          string: carModel!.register,
                          appController: appController,
                          keyMap: 'register');
                    },
                  ),
                ),
                const Divider(
                  color: Colors.black,
                ),
                appController.expireModels.isEmpty
                    ? const SizedBox()
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemCount: appController.expireModels.length,
                        itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            AppDialog(context: context).normalDialog(
                                title:
                                    '??????????????????????????????????????????????????????\n${appController.expireModels[index].feture}',
                                contentWidget: WidgetText(
                                    text:
                                        '???????????????????????????????????????????????? : ${AppService().changeToString(timestamp: appController.expireModels[index].timeExpire)}'),
                                secondActionWidget: WidgetTextButton(
                                  label: 'Edit New Date',
                                  pressFunc: () async {
                                    Get.back();

                                    DateTime dateTime = appController
                                        .expireModels[index].timeExpire
                                        .toDate();

                                    await showDatePicker(
                                            context: context,
                                            initialDate: dateTime,
                                            firstDate:
                                                DateTime(dateTime.year - 1),
                                            lastDate:
                                                DateTime(dateTime.year + 1))
                                        .then((value) async {
                                      DateTime? newDateTime = value;

                                      print(
                                          '##26jan newDateTime --> $newDateTime');
                                      print(
                                          '##26jan docIdExpire --> ${appController.docIdExpires[index]}');

                                      data = appController.expireModels[index]
                                          .toMap();
                                      data['timeExpire'] =
                                          Timestamp.fromDate(newDateTime!);

                                      await FirebaseFirestore.instance
                                          .collection('user')
                                          .doc(user!.uid)
                                          .collection('car')
                                          .doc(widget.docIdCar)
                                          .collection('expire')
                                          .doc(
                                              appController.docIdExpires[index])
                                          .update(data)
                                          .then((value) {
                                        print('##26jan Success');
                                        AppService().readExpireModels(
                                            docIdCar: widget.docIdCar);
                                      });
                                    });
                                  },
                                ));
                          },
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  WidgetText(
                                    text: appController
                                        .expireModels[index].feture,
                                    textStyle: AppConstant()
                                        .h3Style(fontWeight: FontWeight.bold),
                                  ),
                                  WidgetText(
                                    text: AppService().changeToString(
                                        timestamp: appController
                                            .expireModels[index].timeExpire),
                                    textStyle: AppConstant().h3Style(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      WidgetIconButton(
                                        iconData: Icons.delete,
                                        pressFunc: () async {
                                          AppDialog(context: context)
                                              .normalDialog(
                                            title: '????????????????????????????????????\n?????????????????????????????? ?',
                                            contentWidget: WidgetText(
                                                text:
                                                    '${appController.expireModels[index].feture}'),
                                            secondActionWidget:
                                                WidgetTextButton(
                                              label: 'Delete Expire',
                                              pressFunc: () async {
                                                Get.back();

                                                await FirebaseFirestore.instance
                                                    .collection('user')
                                                    .doc(user!.uid)
                                                    .collection('car')
                                                    .doc(widget.docIdCar)
                                                    .collection('expire')
                                                    .doc(appController
                                                        .docIdExpires[index])
                                                    .delete()
                                                    .then((value) {
                                                  print(
                                                      '##26jan Delete Success');
                                                  AppService().readExpireModels(
                                                      docIdCar:
                                                          widget.docIdCar);
                                                });
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
              ],
            );
          }),
    );
  }

  void processEditDataCar(
      {required String string,
      required String keyMap,
      required AppController appController}) {
    TextEditingController textEditingController = TextEditingController();
    textEditingController.text = string;

    String? newText;

    Widget widget = WidgetForm(
      hint: '',
      changeFunc: (p0) {
        newText = p0.trim();
      },
      textEditingController: textEditingController,
    );
    AppDialog(context: context).normalDialog(
        title: 'Edit ?????????????????????????????????',
        contentWidget: widget,
        secondActionWidget: WidgetTextButton(
          label: 'Edit',
          pressFunc: () async {
            if (newText?.isEmpty ?? true) {
              Get.back();
              AppSnackBar().normalSnackbar(
                  title: '?????????????????????????????????????????????????????????',
                  message: '????????????????????????????????????????????????????????????',
                  bgColor: Colors.red,
                  textColor: Colors.white);
            } else {
              Map<String, dynamic> map = carModel!.toMap();
              map[keyMap] = newText;

              await FirebaseFirestore.instance
                  .collection('user')
                  .doc(user!.uid)
                  .collection('car')
                  .doc(docIdCar)
                  .update(map)
                  .then((value) {
                print('##26jan edit car success');
                Get.back();
                AppService().findCarModels().then(
                  (value) {
                    carModel = CarModel.fromMap(map);
                    setState(() {});
                  },
                );
              });
            }
          },
        ));
  }

  void processDeleteCar(
      {required String string,
      required String keyMap,
      required AppController appController}) {
    TextEditingController textEditingController = TextEditingController();
    textEditingController.text = string;

    String? newText;

    Widget widget = WidgetForm(
      hint: '',
      changeFunc: (p0) {
        newText = p0.trim();
      },
      textEditingController: textEditingController,
    );

    AppDialog(context: context).normalDialog(
      title: 'Delete ?????????????????????????????????',
      contentWidget: widget,
      secondActionWidget: WidgetTextButton(
          label: 'Delete',
          pressFunc: () async {
            if (newText?.isEmpty ?? false) {
              Get.back();
            } else {
              Map<String, dynamic> map = carModel!.toMap();
              map[keyMap] = newText;

              await FirebaseFirestore.instance
                  .collection('user')
                  .doc(user!.uid)
                  .collection('car')
                  .doc(docIdCar)
                  .delete()
                  .then(
                (value) {
                  print('##26jan delete car success');
                  Get.back();
                  AppService().findCarModels().then(
                    (value) {
                      carModel = CarModel.fromMap(map);
                      setState(() {});
                    },
                  );
                },
              );
            }
          }),
    );
  }
}
