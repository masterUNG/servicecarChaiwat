import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tumservicecar/states/authen.dart';
import 'package:tumservicecar/states/authen_admin.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

var getPages = <GetPage<dynamic>>[
  GetPage(
    name: '/authenAdmin',
    page: () => const AuthenAdmin(),
  ),
  GetPage(
    name: '/authen',
    page: () => const Authen(),
  ),
];

String? keyPage;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    keyPage = '/authenAdmin';
  } else {
    keyPage = 'authen';

    await Firebase.initializeApp().then(
      (value) => runApp(
        const MyApp(),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: getPages,
      initialRoute: keyPage ?? '/authen',
      theme: ThemeData(useMaterial3: true, primarySwatch: Colors.orange),
    );
  }
}
