import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:easylibrary/app/routes/app_pages.dart';

import '../controllers/splashscreen_controller.dart';

class SplashscreenView extends GetView<SplashscreenController> {
  const SplashscreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
     Future.delayed(const Duration(milliseconds: 4000), () {
      Get.offAllNamed(Routes.LOGIN);
    });
    return Scaffold(
      body: Container(
        color: Colors.blue.shade800,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Center(
              child: Image(image: AssetImage('assets/images/logo.png'))
            ),
            Padding(padding: EdgeInsets.only(top: 200)),
            CircularProgressIndicator(),
            Padding(padding: EdgeInsets.only(top: 50))
          ],
        ),
      ),
    );
  }
}
