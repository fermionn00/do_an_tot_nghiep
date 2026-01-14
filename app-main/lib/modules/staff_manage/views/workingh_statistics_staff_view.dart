import 'package:app_work_log/common/widgets/base_card_statistics.dart';
import 'package:app_work_log/common/widgets/base_text.dart';
import 'package:app_work_log/modules/staff_manage/controllers/workingh_statistics_staff_controller.dart';
import 'package:app_work_log/modules/staff_manage/widgets/calendar_time_working_date.dart';
import 'package:app_work_log/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class WorkingHoursStatisticsStaffView
    extends GetView<WorkingHoursStatisticsStaffController> {
  const WorkingHoursStatisticsStaffView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      // body: BaseWorkingTimetable()
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
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(
                        Icons.chevron_left,
                        size: 32,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: size.width * 0.025),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: size.height * 0.0125),
                            child: BaseText(
                              text: controller.staff.value.firstName == null ||
                                      controller.staff.value.lastName == null
                                  ? ""
                                  : "${controller.staff.value.firstName} ${controller.staff.value.lastName!}",
                              isTile: true,
                              size: 18,
                            ),
                          ),
                          // BaseText(
                          //   text: "Product Manager",
                          //   size: 16,
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.only(
                    left: size.width * 0.025,
                    right: size.width * 0.025,
                    top: size.height * 0.0125),
                child: Row(
                  children: [
                    Obx(
                      () => BaseCardStatistics(
                        height: size.height * 0.08,
                        width: size.width * 0.3,
                        beginColor: AppColor.primaryBlue,
                        endColor: AppColor.primaryBlue
                          ..withAlpha(
                            (0.6 * 255).round(),
                          ),
                        text: "working_days".tr,
                        sizeText: 13,
                        value: controller.statistic.value.workingDays == null
                            ? ""
                            : controller.statistic.value.workingDays.toString(),
                        sizeValue: 18,
                        icon: SizedBox(
                          height: size.height * 0.03,
                          width: size.height * 0.03,
                          child: SvgPicture.asset(
                              "assets/images/manage/ic_statistics_checkin.svg"),
                        ),
                        borderRadius: 8,
                        spaceHorizontal: size.width * 0.02,
                        spaceVertical: size.width * 0.01,
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.025,
                    ),
                    Obx(
                      () => BaseCardStatistics(
                        height: size.height * 0.08,
                        width: size.width * 0.3,
                        beginColor: AppColor.primaryOrange,
                        endColor: AppColor.primaryOrange
                          ..withAlpha(
                            (0.6 * 255).round(),
                          ),
                        text: "workingH".tr,
                        sizeText: 13,
                        value: controller.statistic.value.workingHours == null
                            ? ""
                            : controller.statistic.value.workingHours!
                                .toStringAsFixed(2),
                        sizeValue: 18,
                        icon: SizedBox(
                          height: size.height * 0.03,
                          width: size.height * 0.03,
                          child: SvgPicture.asset(
                              "assets/images/manage/ic_statistics_checkin.svg"),
                        ),
                        borderRadius: 8,
                        spaceHorizontal: size.width * 0.02,
                        spaceVertical: size.width * 0.01,
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.025,
                    ),
                    Obx(
                      () => BaseCardStatistics(
                        height: size.height * 0.08,
                        width: size.width * 0.3,
                        beginColor: AppColor.primaryPink,
                        endColor: AppColor.primaryPink
                          ..withAlpha(
                            (0.6 * 255).round(),
                          ),
                        text: "overtime".tr,
                        sizeText: 13,
                        value: controller.statistic.value.overtimeHours == null
                            ? ""
                            : controller.statistic.value.overtimeHours
                                .toString(),
                        sizeValue: 18,
                        icon: SizedBox(
                          height: size.height * 0.03,
                          width: size.height * 0.03,
                          child: SvgPicture.asset(
                              "assets/images/manage/ic_statistics_checkin.svg"),
                        ),
                        borderRadius: 8,
                        spaceHorizontal: size.width * 0.02,
                        spaceVertical: size.width * 0.01,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: size.height * 0.01),
                child: Divider(),
              ),
              // BaseWorkingTimetable()
              const CalendarTimeWorkingDate()
            ],
          ),
        ),
      ),
    );
  }
}
