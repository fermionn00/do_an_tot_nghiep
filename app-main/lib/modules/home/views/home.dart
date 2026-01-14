import 'package:app_work_log/common/global.dart';
import 'package:app_work_log/common/utils/numeral.dart';
import 'package:app_work_log/common/widgets/base_gradient_widget.dart';
import 'package:app_work_log/modules/attendance/controllers/attendance_controller.dart';
import 'package:app_work_log/modules/home/controllers/home_controller.dart';
import 'package:app_work_log/modules/home/provider/home_provider.dart';
import 'package:app_work_log/modules/manage/controllers/manage_controller.dart';
import 'package:app_work_log/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_work_log/modules/home/utils/home_func.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [];

  @override
  void initState() {
    super.initState();
    resetBottomItemsForStaff();
    getUserRoleCode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: HomeFunc.getBody(selectedIndex, Global.roleCodeUser),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: Color(0xFF2EDA93),
          unselectedItemColor: Colors.grey,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: bottomItems,
          onTap: (routeIndex) async {
            selectedIndex = routeIndex;

            resetBottomItems();

            if (selectedIndex == Numeral.screenAttendance) {
              await Get.find<AttendanceController>().callApiGetListCheckIn();
            } else if (selectedIndex == Numeral.screenHome) {
              await Get.find<HomeController>().refreshData();
            }
          },
        ));
  }

  /// Get user infor
  getUserRoleCode() async {
    // showLoading();
    var result = await HomeProvider().getUserInfo();

    if (result.roleCode != null) {
      Global.roleCodeUser = result.roleCode!;
    }

    Get.find<ManageController>().getManage();

    resetBottomItems();
    // closeLoading();
  }

  resetBottomItems() {
    if (Global.roleCodeUser != Numeral.roleCodeManager &&
        Global.roleCodeUser != Numeral.roleCodeAdmin) {
      resetBottomItemsForStaff();
    } else {
      resetBottomItemsForManager();
    }
  }

  resetBottomItemsForManager() {
    setState(() {
      bottomItems = [
        BottomNavigationBarItem(
            icon: selectedIndex == Numeral.screenHome
                ? BaseGradientWidget(
                    widget: Icon(Icons.home_rounded, size: 34),
                    gradient: AppColor.primaryGradient)
                : BaseGradientWidget(
                    widget: Icon(Icons.home_outlined, size: 34),
                    gradient: AppColor.primaryGradient),
            label: 'Home'.tr),
        BottomNavigationBarItem(
            icon: selectedIndex == Numeral.screenAttendance
                ? BaseGradientWidget(
                    widget: Icon(Icons.how_to_reg_rounded, size: 34),
                    gradient: AppColor.primaryGradient)
                : BaseGradientWidget(
                    widget: Icon(Icons.how_to_reg_outlined, size: 34),
                    gradient: AppColor.primaryGradient),
            label: 'Attendance'.tr),
        BottomNavigationBarItem(
            icon: selectedIndex == Numeral.screenManager
                ? BaseGradientWidget(
                    widget: Icon(Icons.groups_2_rounded, size: 34),
                    gradient: AppColor.primaryGradient)
                : BaseGradientWidget(
                    widget: Icon(Icons.groups_2_outlined, size: 34),
                    gradient: AppColor.primaryGradient),
            label: 'Manage'.tr),
        BottomNavigationBarItem(
            icon: selectedIndex == Numeral.screenNotification
                ? BaseGradientWidget(
                    widget: Icon(Icons.notifications_rounded, size: 34),
                    gradient: AppColor.primaryGradient)
                : BaseGradientWidget(
                    widget: Icon(Icons.notifications_outlined, size: 34),
                    gradient: AppColor.primaryGradient),
            label: 'Notification'.tr),
        BottomNavigationBarItem(
            icon: selectedIndex == Numeral.screenProfile
                ? BaseGradientWidget(
                    widget: Icon(Icons.account_circle_rounded, size: 34),
                    gradient: AppColor.primaryGradient)
                : BaseGradientWidget(
                    widget: Icon(Icons.account_circle_outlined, size: 34),
                    gradient: AppColor.primaryGradient),
            label: 'Profile'.tr),
      ];
    });
  }

  resetBottomItemsForStaff() {
    setState(() {
      bottomItems = [
        BottomNavigationBarItem(
            icon: selectedIndex == Numeral.screenHome
                ? BaseGradientWidget(
                    widget: Icon(Icons.home_rounded, size: 34),
                    gradient: AppColor.primaryGradient)
                : BaseGradientWidget(
                    widget: Icon(Icons.home_outlined, size: 34),
                    gradient: AppColor.primaryGradient),
            label: 'Home'.tr),
        BottomNavigationBarItem(
            icon: selectedIndex == Numeral.screenAttendance
                ? BaseGradientWidget(
                    widget: Icon(Icons.how_to_reg_rounded, size: 34),
                    gradient: AppColor.primaryGradient)
                : BaseGradientWidget(
                    widget: Icon(Icons.how_to_reg_outlined, size: 34),
                    gradient: AppColor.primaryGradient),
            label: 'Attendance'.tr),
        BottomNavigationBarItem(
            icon: selectedIndex == 2
                ? BaseGradientWidget(
                    widget: Icon(Icons.notifications_rounded, size: 34),
                    gradient: AppColor.primaryGradient)
                : BaseGradientWidget(
                    widget: Icon(Icons.notifications_outlined, size: 34),
                    gradient: AppColor.primaryGradient),
            label: 'Notification'.tr),
        BottomNavigationBarItem(
            icon: selectedIndex == 3
                ? BaseGradientWidget(
                    widget: Icon(Icons.account_circle_rounded, size: 34),
                    gradient: AppColor.primaryGradient)
                : BaseGradientWidget(
                    widget: Icon(Icons.account_circle_outlined, size: 34),
                    gradient: AppColor.primaryGradient),
            label: 'Profile'.tr),
      ];
    });
  }
}
