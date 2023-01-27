import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tumservicecar/models/feture_model.dart';
import 'package:tumservicecar/states/detail_car.dart';
import 'package:tumservicecar/states/setup_feture.dart';
import 'package:tumservicecar/utility/app_constant.dart';
import 'package:tumservicecar/utility/app_controller.dart';
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
                              print(
                                  'You tab docId -->> ${appController.docIdFetures[index]}');
                              print(
                                  'docIdFeture in userModel--->${appController.userModels.last.docIdFetures.length}');
                              var docIdFetures = <String>[];

                              if (appController
                                  .userModels.last.docIdFetures.isEmpty) {
                                print('No Doc');

                                processChooseCar(
                                    fetureModel:
                                        appController.fetureModels[index],
                                    appController: appController,
                                    docIdFeture:
                                        appController.docIdFetures[index]);
                              } else {
                                print(
                                    '${appController.docIdFetures[index]} Have Doc  ${appController.userModels.last.docIdFetures}');

                                var docIdFetures = <String>[];
                                for (var element in appController
                                    .userModels.last.docIdFetures) {
                                  docIdFetures.add(element);
                                }
                                print('docIdFeture -->> $docIdFetures');

                                if (docIdFetures.contains(
                                    appController.docIdFetures[index])) {
                                  print('มี Feture นี่แล้ว');
                                  Get.to(const DetailCar());
                                } else {
                                  print('ไม่มี feture นี่');
                                }
                              }
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

  void processChooseCar(
      {required FetureModel fetureModel,
      required AppController appController,
      required String docIdFeture}) {
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
                    Get.back();
                    
                    if (condition) {
                      //ไปเพิ่ม feture
                      Get.to(
                      SetupFeture(
                        docIdFetures: docIdFeture,
                        carModel: appController.carModels[index],
                        fetureModel: fetureModel,
                        docIdCar: appController.docIdCars[index],
                      ),
                    );
                      
                    } else {
                      //ไปดู detail
                      
                    }

                  },
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
