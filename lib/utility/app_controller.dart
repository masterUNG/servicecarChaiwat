

import 'dart:io';

import 'package:get/get.dart';
import 'package:tumservicecar/models/feture_model.dart';

class AppController extends GetxController {
  RxBool obSecu = true.obs;
  RxList files =<File>[].obs;
  RxList urlImages = <String>[].obs;

  RxList fetureModels =<FetureModel>[].obs;

  
}
