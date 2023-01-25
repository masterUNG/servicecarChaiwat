import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tumservicecar/models/car_model.dart';
import 'package:tumservicecar/models/feture_model.dart';
import 'package:tumservicecar/models/user_model.dart';
import 'package:tumservicecar/states/authen.dart';
import 'package:tumservicecar/utility/app_controller.dart';

class AppService {
  Future<void> processUploadMultiImage() async {
    AppController appController = Get.put(AppController());

    for (var element in appController.xFiles) {
      File file = File(element.path);
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference reference =
          storage.ref().child('car/car${Random().nextInt(1000000)}.jpg');
      UploadTask uploadTask = reference.putFile(file);
      await uploadTask.whenComplete(() async {
        await reference.getDownloadURL().then((value) {
          appController.images.add(value);
        });
      });
    }
  }

  Future<void> processChooseMultiImage() async {
    AppController appController = Get.put(AppController());

    await ImagePicker()
        .pickMultiImage(
      maxWidth: 800,
      maxHeight: 800,
    )
        .then((value) {
      appController.xFiles.addAll(value);
    });
  }

  Future<void> findCarModels() async {
    AppController appController = Get.put(AppController());

    if (appController.carModels.isNotEmpty) {
      appController.carModels.clear();
    }

    var user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection('user')
        .doc(user!.uid)
        .collection('car')
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        for (var element in value.docs) {
          CarModel model = CarModel.fromMap(element.data());
          appController.carModels.add(model);
        }
      }
    });
  }

  Future<void> findUserModel() async {
    AppController appController = Get.put(AppController());
    ;
    var user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection('user')
        .doc(user!.uid)
        .get()
        .then((value) {
      UserModel model = UserModel.fromMap(value.data()!);
      appController.userModels.add(model);
    });
  }

  Future<void> processSignOut() async {
    await FirebaseAuth.instance
        .signOut()
        .then((value) => Get.offAll(const Authen()));
  }

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
