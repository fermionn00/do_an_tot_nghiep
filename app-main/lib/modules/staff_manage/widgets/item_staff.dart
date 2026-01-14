import 'package:app_work_log/common/utils/numeral.dart';
import 'package:app_work_log/common/widgets/base_text.dart';
import 'package:app_work_log/modules/staff_manage/models/staff.dart';
import 'package:app_work_log/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ItemStaff extends StatelessWidget {
  final StaffManage item;
  const ItemStaff({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            Get.toNamed(Routes.profileStaff, arguments: item);
          },
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(
                    left: size.width * 0.025, top: size.height * 0.0125),
                height: size.width * 0.13,
                width: size.width * 0.13,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      width: 1,
                      color: Colors.grey,
                    ),
                    shape: BoxShape.circle),
                child: Center(
                  child: BaseText(
                    text: item.firstName == null ? "N" : item.firstName![0],
                    isTile: true,
                    size: 18,
                  ),
                ),
              ),
              SizedBox(
                width: size.width * 0.0125,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      BaseText(
                        text: item.firstName == null || item.lastName == null
                            ? "Null"
                            : "${item.firstName} ${item.lastName}",
                        isTile: true,
                      ),
                      SizedBox(
                        width: size.width * 0.0125,
                      ),
                      item.statusCode == Numeral.statusCodeActive
                          ? SvgPicture.asset(
                              "assets/images/manage/ic_staff_active.svg")
                          : SvgPicture.asset(
                              "assets/images/manage/ic_staff_inactive.svg"),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.005,
                  ),
                  BaseText(
                    text: item.employeeCode == null
                        ? ""
                        : "#${item.employeeCode}",
                    colorText: Colors.grey,
                  ),
                ],
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            Get.toNamed(Routes.attendanceStaff, arguments: item);
          },
          child: Container(
            margin: EdgeInsets.only(right: size.width * 0.05),
            child: SvgPicture.asset(
              "assets/images/manage/ic_late_statistics.svg",
              color: Colors.grey.withAlpha(
                (0.4 * 255).round(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
