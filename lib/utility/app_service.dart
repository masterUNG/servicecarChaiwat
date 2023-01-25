import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tumservicecar/models/feture_model.dart';
import 'package:tumservicecar/utility/app_controller.dart';

class AppService {
  Future<void> processReadFeture() async {
    AppController appController = Get.put(AppController());
    if (appController.fetureModels.isNotEmpty) {
      appController.fetureModels.clear();
    }

    await FirebaseFirestore.instance.collection('feture').get().then((value) {
      for (var element in value.docs) {
        FetureModel model = FetureModel.fromMap(element.data());
        appController.fetureModels.add(model);
      }
    });
  }

  Future<void> processTakePhotoAndUpload(
      {required ImageSource source, required String path}) async {
    AppController appController = Get.put(AppController());

    var result = await ImagePicker().pickImage(
      source: source,
      maxWidth: 800,
      maxHeight: 800,
    );

    if (result != null) {
      var imageByte = await result.readAsBytes();

      String nameFile = 'image${Random().nextInt(1000000)}.jpg';
      FirebaseStorage firebaseStorage = FirebaseStorage.instance;
      Reference reference = firebaseStorage.ref().child('$path/$nameFile');
      UploadTask uploadTask = reference.putData(
          imageByte, SettableMetadata(contentType: 'image/jpeg'));
      await uploadTask.whenComplete(() async {
        await reference.getDownloadURL().then((value) {
          appController.urlImages.add(value);
        });
      });
    }
  }
}
