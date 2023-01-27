import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tumservicecar/models/car_model.dart';
import 'package:tumservicecar/models/expire_model.dart';
import 'package:tumservicecar/models/feture_model.dart';
import 'package:tumservicecar/models/user_model.dart';

class AppController extends GetxController {
  RxBool obSecu = true.obs;
  RxList files = <File>[].obs;
  RxList urlImages = <String>[].obs;
  RxList fetureModels = <FetureModel>[].obs;
  RxList docIdFetures =<String>[].obs;
  RxInt indexBody = 0.obs;
  RxList userModels = <UserModel>[].obs;

  RxList carModels = <CarModel>[].obs;
  RxList docIdCars =<String>[].obs;

  RxList xFiles = <XFile>[].obs;
  RxList images =<String>[].obs;
  RxList chooseDateTime =<DateTime>[].obs;

  RxList expireModels =<ExpireModel>[].obs;
}
