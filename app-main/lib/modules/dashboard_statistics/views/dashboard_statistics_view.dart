import 'package:app_work_log/common/widgets/base_text.dart';
import 'package:app_work_log/modules/dashboard_statistics/controllers/dashboard_statistics_controller.dart';
import 'package:app_work_log/modules/dashboard_statistics/widgets/month_statistics_view.dart';
import 'package:app_work_log/modules/dashboard_statistics/widgets/today_statistics_view.dart';
import 'package:app_work_log/modules/dashboard_statistics/widgets/week_statistics_view.dart';
import 'package:app_work_log/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardStatisticsView extends GetView<DashboardStatisticsController> {
  const DashboardStatisticsView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/images/common/img_bg_1.png",
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
                          size: 24,
                        )),
                    Expanded(
                      child: BaseText(
                        text: "statistics".tr,
                        isTile: true,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.025,
              ),
              Expanded(
                child: DefaultTabController(
                  length: 3,
                  child: Column(
                    children: [
                      Container(
                        height: size.height * 0.05,
                        margin: EdgeInsets.only(
                          left: size.width * 0.05,
                          right: size.width * 0.05,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                                blurRadius: 4,
                                spreadRadius: 4,
                                color: Colors.black12)
                          ],
                        ),
                        child: TabBar(
                          indicator: BoxDecoration(
                            color: AppColor.colorTabChoose,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          labelColor: AppColor.colorTextChoose,
                          unselectedLabelColor: AppColor.colorTextNotChoose,
                          tabs: [
                            SizedBox(
                              height: size.height * 0.05,
                              child: Align(
                                child: Center(
                                  child: Tab(
                                    text: 'today'.tr,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.05,
                              child: Align(
                                child: Center(
                                  child: Tab(
                                    text: 'week'.tr,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.05,
                              child: Align(
                                child: Center(
                                  child: Tab(
                                    text: 'month'.tr,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Expanded(
                          child: TabBarView(
                        children: [
                          TodayStatisticsView(),
                          WeekStatisticsView(),
                          MonthStatisticsView(),
                        ],
                      ))
                    ],
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
