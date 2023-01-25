import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tumservicecar/states/add_car.dart';
import 'package:tumservicecar/utility/app_constant.dart';
import 'package:tumservicecar/utility/app_controller.dart';
import 'package:tumservicecar/utility/app_service.dart';
import 'package:tumservicecar/widgets/widget_button.dart';
import 'package:tumservicecar/widgets/widget_text.dart';

class BodyProfileMobile extends StatefulWidget {
  const BodyProfileMobile({super.key});

  @override
  State<BodyProfileMobile> createState() => _BodyProfileMobileState();
}

class _BodyProfileMobileState extends State<BodyProfileMobile> {
  @override
  Widget build(BuildContext context) {
    return GetX(
        init: AppController(),
        builder: (AppController appController) {
          print('carModels --> ${appController.carModels.length}');
          return Scaffold(backgroundColor: Colors.white,
            body: appController.carModels.isEmpty
                ? Center(
                    child: WidgetText(
                    text: 'ยังไม่ได้ลงทะเบียน',
                    textStyle: AppConstant().h2Style(),
                  ))
                : WidgetText(text: 'Have car'),
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
  }
}
