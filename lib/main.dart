import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tumservicecar/states/add_feture.dart';
import 'package:tumservicecar/states/authen.dart';
import 'package:tumservicecar/states/authen_admin.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:tumservicecar/states/display_feture.dart';
import 'package:tumservicecar/states/display_news.dart';
import 'package:tumservicecar/states/main_home.dart';
import 'package:tumservicecar/states/main_home_admin.dart';

var getPages = <GetPage<dynamic>>[
  GetPage(
    name: '/authenAdmin',
    page: () => const AuthenAdmin(),
  ),
  GetPage(
    name: '/authen',
    page: () => const Authen(),
  ),
  GetPage(
    name: '/mainHome',
    page: () => const MainHome(),
  ),
  GetPage(
    name: '/mainHomeAdmin',
    page: () => const MainHomeAdmin(),
  ),
  GetPage(
    name: '/displayFeture',
    page: () => const DisplayFeture(),
  ),
  GetPage(
    name: '/displayNews',
    page: () => const DisplayNews(),
  ),
];

String? keyPage;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance
    ..initialize()
    ..updateRequestConfiguration(RequestConfiguration(testDeviceIds: []));

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: 'AIzaSyAuAXIVS4fMJWwGz04plY1V2xzCAKtKiJA',
      appId: '1:82396635324:web:808f9a6eb0715883cdb0b9',
      messagingSenderId: '82396635324',
      projectId: 'servicecar-e2d51',
      storageBucket: "servicecar-e2d51.appspot.com",
    )).then((value) {
      // keyPage = '/authenAdmin';
      keyPage = '/mainHomeAdmin';

      runApp(const MyApp());
    });
  } else {
    await Firebase.initializeApp().then(
      (value) async {
        FirebaseAuth.instance.authStateChanges().listen((event) {
          if (event == null) {
            keyPage = 'authen';
          } else {
            keyPage = '/mainHome';
          }
        });

        runApp(const MyApp());
      },
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
