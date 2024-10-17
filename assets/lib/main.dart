import 'dart:io';
import 'package:aliyamart/views/screens/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import 'controllers/category_controller.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
            apiKey: "AIzaSyDK_N9UIzaiu2FjlP5i-E4dMqMxGjKZ5BY",
            appId: '1:69723042368:android:350bea0d69d405dcfb65a5',
            messagingSenderId: '69723042368',
            projectId: 'shop-a84e5',
            storageBucket: "shop-a84e5.appspot.com",
          ),
        )
      : await Firebase.initializeApp();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MainScreen(),
      initialBinding: BindingsBuilder(
        () {
          Get.put<CategoryController>(CategoryController());
        },
      ),
    );
  }
}
