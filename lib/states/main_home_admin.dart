import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tumservicecar/utility/app_constant.dart';
import 'package:tumservicecar/widgets/widget_head.dart';
import 'package:tumservicecar/widgets/widget_image.dart';
import 'package:tumservicecar/widgets/widget_text.dart';

class MainHomeAdmin extends StatefulWidget {
  const MainHomeAdmin({super.key});

  @override
  State<MainHomeAdmin> createState() => _MainHomeAdminState();
}

class _MainHomeAdminState extends State<MainHomeAdmin> {
  var pathImages = <String>[
    'images/feture.png',
    'images/news.png',
  ];
  var titles = <String>['Feture', 'News'];
  var KeyPages = <String>[
    '/displayFeture',
    '/displayNews',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 80),
            width: 500,
            child: Column(
              children: [
                const WidgetHead(),
                const SizedBox(
                  height: 40,
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: titles.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 4 / 5,
                      //crossAxisSpacing: 20,
                      //mainAxisSpacing: 50,
                      crossAxisCount: 5),
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      Get.toNamed(KeyPages[index]);
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            WidgetImage(
                              path: pathImages[index],
                              width: 80,
                            ),
                            WidgetText(
                              text: titles[index],
                              textStyle: AppConstant().h3Style(
                                  fontWeight: FontWeight.bold, size: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
