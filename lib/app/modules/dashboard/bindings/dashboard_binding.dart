
import 'package:easylibrary/app/modules/home/controllers/home_controller.dart';
import 'package:easylibrary/app/modules/profile/controllers/profile_controller.dart';
import 'package:easylibrary/app/modules/history/controllers/history_controller.dart';
import 'package:easylibrary/app/modules/book/controllers/book_controller.dart';
import 'package:get/get.dart';

import '../controllers/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(
      () => DashboardController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
    Get.lazyPut<BookController>(
      () => BookController(),
    );
    Get.lazyPut<HistoryController>(
      () => HistoryController(),
    );
  }
}
