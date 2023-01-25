import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tumservicecar/states/add_feture.dart';
import 'package:tumservicecar/utility/app_constant.dart';
import 'package:tumservicecar/utility/app_controller.dart';
import 'package:tumservicecar/utility/app_service.dart';
import 'package:tumservicecar/widgets/widget_button.dart';
import 'package:tumservicecar/widgets/widget_image_internet.dart';
import 'package:tumservicecar/widgets/widget_text.dart';

class DisplayFeture extends StatefulWidget {
  const DisplayFeture({super.key});

  @override
  State<DisplayFeture> createState() => _DisplayFetureState();
}

class _DisplayFetureState extends State<DisplayFeture> {
  @override
  void initState() {
    super.initState();
    AppService().processReadFeture();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: WidgetText(
          text: 'Display All Feture',
          textStyle: AppConstant().h2Style(),
        ),
      ),
      floatingActionButton: WidgetButton(
          label: 'Add New Feture',
          pressFunc: () {
            Get.to(const AddFeture())!
                .then((value) => AppService().processReadFeture());
          }),
      body: GetX(
          init: AppController(),
          builder: (AppController appController) {
            print('fetureModels --> ${appController.fetureModels.length}');
            return appController.fetureModels.isEmpty
                ? const SizedBox()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 500,
                        child: GridView.builder(
                          itemCount: appController.fetureModels.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 5, childAspectRatio: 4 / 5,mainAxisSpacing: 16,crossAxisSpacing: 16),
                          itemBuilder: (context, index) => Card(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                WidgetImageNetwork(
                                  urlImage: appController
                                      .fetureModels[index].urlImage,
                                  size: 80,
                                ),
                                WidgetText(
                                  text:
                                      appController.fetureModels[index].feture,
                                  textStyle: AppConstant()
                                      .h3Style(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
          }),
    );
  }
}
