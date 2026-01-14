import 'package:app_work_log/common/utils/numeral.dart';
import 'package:app_work_log/languages/language_service.dart';
import 'package:app_work_log/modules/home/controllers/home_controller.dart';
import 'package:app_work_log/modules/manage/controllers/manage_controller.dart';
import 'package:app_work_log/oauth2/service/auth_service.dart';
import 'package:get/get.dart';

class LanguageController extends GetxController {
  var selectLanguage = 0.obs;
  final authService = Get.find<AuthService>();

  @override
  void onInit() {
    super.onInit();
    switch (authService.languageApp) {
      case 1:
        selectLanguage.value = Numeral.languageEn;
        break;
      case 2:
        selectLanguage.value = Numeral.languageVn;
        break;
      case 3:
        selectLanguage.value = Numeral.languageJp;
        break;
      default:
        selectLanguage.value = Numeral.languageEn;
        break;
    }
  }

  setSelectedLanguage(int value) {
    selectLanguage.value = value;
  }

  saveLanguage() {
    Get.find<AuthService>().setLanguageServiceApp(selectLanguage.value);
    switch (Get.find<AuthService>().languageApp) {
      case 1:
        LanguageService.changeLocale("en");
        break;
      case 2:
        LanguageService.changeLocale("vi");
        break;
      case 3:
        LanguageService.changeLocale("jp");
        break;
      default:
        LanguageService.changeLocale("en");
        break;
    }
    refreshLanguage();
  }

  refreshLanguage() {
    Get.find<ManageController>().getManage();
    Get.find<HomeController>().getDateNow();
    Get.find<HomeController>().getHomeStatistic();
  }
}
