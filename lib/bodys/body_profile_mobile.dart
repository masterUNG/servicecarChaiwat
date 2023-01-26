import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tumservicecar/states/add_car.dart';
import 'package:tumservicecar/utility/app_constant.dart';
import 'package:tumservicecar/utility/app_controller.dart';
import 'package:tumservicecar/utility/app_service.dart';
import 'package:tumservicecar/widgets/widget_button.dart';
import 'package:tumservicecar/widgets/widget_image_internet.dart';
import 'package:tumservicecar/widgets/widget_text.dart';

class BodyProfileMobile extends StatefulWidget {
  const BodyProfileMobile({super.key});

  @override
  State<BodyProfileMobile> createState() => _BodyProfileMobileState();
}

class _BodyProfileMobileState extends State<BodyProfileMobile> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, BoxConstraints boxConstraints) {
      return GetX(
          init: AppController(),
          builder: (AppController appController) {
            print('carModels --> ${appController.carModels.length}');
            return Scaffold(
              backgroundColor: Colors.white,
              body: appController.carModels.isEmpty
                  ? Center(
                      child: WidgetText(
                      text: 'ยังไม่ได้ลงทะเบียน',
                      textStyle: AppConstant().h2Style(),
                    ))
                  : ListView.builder(
                      itemCount: appController.carModels.length,
                      itemBuilder: (context, index) => Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: WidgetImageNetwork(
                              urlImage:
                                  appController.carModels[index].images.last,
                              size: boxConstraints.maxWidth * 0.3,
                              boxFit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                top: 4, bottom: 4, right: 8),
                            width: boxConstraints.maxWidth * 0.7 - 24,
                            height: boxConstraints.maxWidth * 0.3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                displayDetail(
                                    head: 'ยี่ห้อ :',
                                    value: appController.carModels[index].brand,
                                    textStyle: AppConstant().h2Style()),
                                    displayDetail(head: 'รุ่น :', value: appController.carModels[index].type),
                                    displayDetail(head: 'สีของรถ :', value: appController.carModels[index].color),
                                    displayDetail(head: 'ป้ายทะเบียนรถ :', value: appController.carModels[index].register),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
              floatingActionButton: WidgetButton(
                label: 'Add Car',
                pressFunc: () {
                  Get.to(const AddCar())!.then((value) {
                    AppService().findCarModels();
                  });
                },
              ),
            );
          });
    });
  }

  Row displayDetail(
      {required String head, required String value, TextStyle? textStyle}) {
    return Row(
      children: [
        WidgetText(
          text: head,
          textStyle: AppConstant().h3Style(fontWeight: FontWeight.bold),
        ),
        WidgetText(
          text: value,
          textStyle: textStyle ?? AppConstant().h3Style(),
        ),
      ],
    );
  }
}
