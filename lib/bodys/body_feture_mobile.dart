import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tumservicecar/models/feture_model.dart';
import 'package:tumservicecar/states/detail_car.dart';
import 'package:tumservicecar/states/setup_feture.dart';
import 'package:tumservicecar/utility/app_constant.dart';
import 'package:tumservicecar/utility/app_controller.dart';
import 'package:tumservicecar/utility/app_service.dart';
import 'package:tumservicecar/widgets/widget_image_internet.dart';
import 'package:tumservicecar/widgets/widget_text.dart';
import 'package:tumservicecar/widgets/widget_text_button.dart';

class BodyfetureMobile extends StatefulWidget {
  const BodyfetureMobile({super.key});

  @override
  State<BodyfetureMobile> createState() => _BodyfetureMobileState();
}

class _BodyfetureMobileState extends State<BodyfetureMobile> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, BoxConstraints boxConstraints) {
      return GetX(
          init: AppController(),
          builder: (AppController appController) {
            print('userModel --> ${appController.userModels.length}');
            return appController.fetureModels.isEmpty
                ? const SizedBox()
                : SizedBox(
                    width: boxConstraints.maxWidth,
                    height: boxConstraints.maxHeight,
                    child: Stack(
                      children: [
                        GridView.builder(
                          itemCount: appController.fetureModels.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3),
                          itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              processChooseCar(
                                fetureModel: appController.fetureModels[index],
                                appController: appController,
                                docIdFeture: appController.docIdFetures[index],
                              );
                            },
                            child: Card(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  WidgetImageNetwork(
                                    urlImage: appController
                                        .fetureModels[index].urlImage,
                                    size: 80,
                                  ),
                                  WidgetText(
                                    text: appController
                                        .fetureModels[index].feture,
                                    textStyle: AppConstant()
                                        .h3Style(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: WidgetText(text: 'Ad mob'),
                        ),
                      ],
                    ),
                  );
          });
    });
  }

  bool? checkStatus(
      {required AppController appController, required int index}) {
    bool? haveFeture;
    var docIdFetures = <String>[];
    for (var element in appController.userModels.last.docIdFetures) {
      docIdFetures.add(element);
    }

    if (docIdFetures.contains(appController.docIdFetures[index])) {
      print('มี Feture นี่แล้ว');
      haveFeture = true;
    } else {
      print('ไม่มี feture นี่');
      haveFeture = false;
    }
    return haveFeture;
  }

  void processChooseCar({
    required FetureModel fetureModel,
    required AppController appController,
    required String docIdFeture,
  }) {
    Get.dialog(
      AlertDialog(
        icon: WidgetImageNetwork(
          urlImage: fetureModel.urlImage,
          size: 100,
        ),
        title: WidgetText(
          text: 'กรุณาเลือกรถ ให้กับการทำ ${fetureModel.feture}',
          textStyle: AppConstant().h3Style(fontWeight: FontWeight.bold),
        ),
        content: SizedBox(
          height: 150,
          width: 200,
          child: ListView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: appController.carModels.length,
            itemBuilder: (context, index) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WidgetTextButton(
                  label: appController.carModels[index].brand,
                  size: 18,
                  pressFunc: () {
                    String docIdCar = appController.docIdCars[index];
                    print('##27jan docIdCar ที่เลือก $docIdCar');

                    AppService()
                        .readExpireModels(docIdCar: docIdCar)
                        .then((value) async {
                      print(
                          '##27jan expireModels -->${appController.expireModels.length}');

                      if (appController.expireModels.isEmpty) {
                        //ไม่มี expire เลย
                        Get.back();
                        Get.to(
                          SetupFeture(
                            docIdFetures: docIdFeture,
                            carModel: appController.carModels[index],
                            fetureModel: fetureModel,
                            docIdCar: appController.docIdCars[index],
                          ),
                        );
                      } else {
                        // มี expire แล้ว

                        var user = FirebaseAuth.instance.currentUser;
                        await FirebaseFirestore.instance
                            .collection('user')
                            .doc(user!.uid)
                            .collection('car')
                            .doc(docIdCar)
                            .collection('expire')
                            .where('docIdFeture', isEqualTo: docIdFeture)
                            .get()
                            .then((value) {
                          if (value.docs.isEmpty) {
                            // ยังไม่เคยมี feture นี่
                            Get.back();
                            Get.to(
                              SetupFeture(
                                docIdFetures: docIdFeture,
                                carModel: appController.carModels[index],
                                fetureModel: fetureModel,
                                docIdCar: appController.docIdCars[index],
                              ),
                            );
                          } else {
                            //มี feture นี่แล้ว
                            Get.back();
                            Get.to(DetailCar(
                              docIdCar: docIdCar,
                              carModel: appController.carModels[index],
                            ));
                          }
                        });
                      }
                    });
                  }, //end
                ),
                WidgetText(
                  text: appController.carModels[index].type,
                  textStyle: AppConstant().h3Style(
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const Divider(
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
