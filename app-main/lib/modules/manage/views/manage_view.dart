import 'package:app_work_log/common/utils/numeral.dart';
import 'package:app_work_log/common/widgets/base_text.dart';
import 'package:app_work_log/modules/manage/controllers/manage_controller.dart';
import 'package:app_work_log/modules/manage/widgets/item_manage.dart';
import 'package:app_work_log/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageView extends GetView<ManageController> {
  const ManageView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/images/common/img_bg_2.png",
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: BaseText(
                  text: "manage".tr,
                  isTile: true,
                  size: 24,
                ),
              ),
              Obx(
                () => Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Container(
                      alignment: Alignment.center,
                      child: SingleChildScrollView(
                        child: Wrap(
                          children: List.generate(controller.listManage.length,
                              (index) {
                            return ItemManage(
                              index: index,
                              icon: controller.listManage[index].icon!,
                              color: controller.listManage[index].color!,
                              text: controller.listManage[index].text!,
                              voidCallback: () {
                                if (index == Numeral.selectAttendanceCheckin) {
                                  Get.toNamed(Routes.attendanceManage,
                                      arguments: Numeral.selectListCheckin);
                                } else if (index ==
                                    Numeral.selectAttendanceLate) {
                                  Get.toNamed(Routes.attendanceManage,
                                      arguments: Numeral.selectListLate);
                                } else if (index ==
                                    Numeral.selectAttendanceCasualLeave) {
                                  Get.toNamed(Routes.attendanceManage,
                                      arguments: Numeral.selectListCasualLeave);
                                } else if (index ==
                                    Numeral.selectDashboardStatistics) {
                                  Get.toNamed(Routes.dashboardStatistics);
                                } else if (index ==
                                    Numeral.selectLeaveRequests) {
                                  Get.toNamed(Routes.leaveRequestsManage);
                                } else if (index ==
                                    Numeral.selectOvertimeRequests) {
                                  Get.toNamed(Routes.overtimeRequestsManage);
                                } else if (index == Numeral.selectStaff) {
                                  Get.toNamed(Routes.staffManage);
                                } else if (index == Numeral.selectDepartment) {
                                  Get.toNamed(Routes.departmentManage);
                                } else if (index == Numeral.selectShift) {
                                  Get.toNamed(Routes.shiftManage);
                                } else if (index ==
                                    Numeral.selectProfileCompany) {
                                  Get.toNamed(Routes.companyProfile);
                                } else if (index ==
                                    Numeral.selectCompanySetting) {
                                  Get.toNamed(Routes.companySetting);
                                }
                              },
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
