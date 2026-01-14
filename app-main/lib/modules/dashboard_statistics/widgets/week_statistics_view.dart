import 'package:app_work_log/common/widgets/base_card_statistics.dart';
import 'package:app_work_log/modules/dashboard_statistics/controllers/dashboard_statistics_controller.dart';
import 'package:app_work_log/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class WeekStatisticsView extends GetView<DashboardStatisticsController> {
  const WeekStatisticsView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Obx(
      () => Column(
        children: [
          Container(
            margin: EdgeInsets.only(
                top: size.height * 0.0125,
                left: size.width * 0.05,
                right: size.width * 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BaseCardStatistics(
                  width: size.width * 0.425,
                  text: "check_in".tr,
                  value:
                      controller.companyStatisticWeek.value.checkins.toString(),
                  sizeValue: 32,
                  beginColor: AppColor.colorStatisticsLateToday,
                  endColor: AppColor.colorStatisticsLateToday.withAlpha(
                    (0.5 * 255).round(),
                  ),
                  icon: SvgPicture.asset(
                      "assets/images/manage/ic_checkin_statistics.svg"),
                ),
                BaseCardStatistics(
                  text: "late".tr,
                  value: controller.companyStatisticWeek.value.lateArrivals
                      .toString(),
                  sizeValue: 32,
                  beginColor: AppColor.colorStatisticsCasualLeaveToday,
                  endColor: AppColor.colorStatisticsCasualLeaveToday.withAlpha(
                    (0.5 * 255).round(),
                  ),
                  icon: SvgPicture.asset(
                      "assets/images/manage/ic_late_statistics.svg"),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                top: size.height * 0.0125,
                left: size.width * 0.05,
                right: size.width * 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BaseCardStatistics(
                  width: size.width * 0.425,
                  text: "casual_leave".tr,
                  value: controller.companyStatisticWeek.value.leaveRequest
                      .toString(),
                  sizeValue: 32,
                  beginColor: AppColor.colorStatisticsLateMonth,
                  endColor: AppColor.colorStatisticsLateMonth.withAlpha(
                    (0.5 * 255).round(),
                  ),
                  icon: SvgPicture.asset(
                      "assets/images/manage/ic_absent_statistics.svg"),
                ),
                BaseCardStatistics(
                  text: "overtime".tr,
                  value: controller.companyStatisticWeek.value.overtimeRequest
                      .toString(),
                  sizeValue: 32,
                  beginColor: AppColor.colorStatisticsCheckinToday,
                  endColor: AppColor.colorStatisticsCheckinToday.withAlpha(
                    (0.5 * 255).round(),
                  ),
                  icon: SvgPicture.asset(
                      "assets/images/manage/ic_casual_leave_statistics.svg"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
