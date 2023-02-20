import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tumservicecar/models/feture_model.dart';
import 'package:tumservicecar/utility/app_constant.dart';
import 'package:tumservicecar/utility/app_controller.dart';
import 'package:tumservicecar/utility/app_service.dart';
import 'package:tumservicecar/utility/app_snack_bar.dart';
import 'package:tumservicecar/widgets/widget_button.dart';
import 'package:tumservicecar/widgets/widget_form.dart';
import 'package:tumservicecar/widgets/widget_icon_button.dart';
import 'package:tumservicecar/widgets/widget_image.dart';
import 'package:tumservicecar/widgets/widget_image_internet.dart';
import 'package:tumservicecar/widgets/widget_text.dart';

class AddFeture extends StatefulWidget {
  const AddFeture({super.key});

  @override
  State<AddFeture> createState() => _AddFetureState();
}

class _AddFetureState extends State<AddFeture> {
  String? feture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: WidgetText(
          text: 'Add New Feture',
          textStyle: AppConstant().h2Style(),
        ),
      ),
      body: GetX(
          init: AppController(),
          builder: (AppController appController) {
            print('files --> ${appController.files.length}');
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 36),
                  width: 550,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          appController.urlImages.isEmpty
                              ? const WidgetImage(
                                  path: 'images/image.png',
                                  width: 250,
                                )
                              : WidgetImageNetwork(
                                  urlImage: appController.urlImages.last,
                                  boxFit: BoxFit.cover,
                                  size: 250,
                                ),
                          SizedBox(
                            width: 250,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                WidgetIconButton(
                                  iconData: Icons.add_photo_alternate,
                                  pressFunc: () {
                                    AppService()
                                        .processTakePhotoAndUpload(
                                            source: ImageSource.gallery,
                                            path: 'feture')
                                        .then((value) {
                                      print(
                                          'success take --> file = ${appController.urlImages.length}');
                                    });
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          WidgetForm(
                            hint: 'Feture:',
                            changeFunc: (p0) {
                              feture = p0.trim();
                            },
                          ),
                          WidgetButton(
                            label: 'Add New Feture',
                            pressFunc: () async {
                              if (appController.urlImages.isEmpty) {
                                AppSnackBar().normalSnackbar(
                                  title: 'No Photo',
                                  message: 'Plase take photo',
                                  bgColor: Colors.red.shade900,
                                  textColor: Colors.white,
                                  snackPosition: SnackPosition.TOP,
                                );
                              } else if (feture?.isEmpty ?? true) {
                                AppSnackBar().normalSnackbar(
                                  title: 'No Feture?',
                                  message: 'Please fill feture in Blank',
                                  bgColor: Colors.red.shade900,
                                  textColor: Colors.white,
                                  snackPosition: SnackPosition.TOP,
                                );
                              } else {
                                FetureModel fetureModel = FetureModel(
                                    feture: feture!,
                                    urlImage: appController.urlImages.last);
                                await FirebaseFirestore.instance
                                    .collection('feture')
                                    .doc()
                                    .set(fetureModel.toMap())
                                    .then((value) {
                                  appController.urlImages.clear();
                                  Get.back();
                                });
                              }
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}
