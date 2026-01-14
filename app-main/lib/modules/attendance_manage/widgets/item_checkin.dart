import 'package:app_work_log/common/widgets/base_text.dart';
import 'package:app_work_log/modules/attendance_manage/controllers/attendance_manage_controller.dart';
import 'package:app_work_log/modules/attendance_manage/models/attendance_checkin_manage.dart';
import 'package:app_work_log/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ItemCheckIn extends GetView<AttendanceCheckInManageController> {
  final AttendanceCheckInManage item;
  const ItemCheckIn({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(
              left: size.width * 0.025,
              top: size.height * 0.0125,
              right: size.width * 0.0125),
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
              text: item.userInfo!.firstName == null
                  ? ""
                  : item.userInfo!.firstName![0],
              isTile: true,
              size: 18,
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BaseText(
                text: item.userInfo!.firstName == null ||
                        item.userInfo!.lastName == null
                    ? ""
                    : "${item.userInfo!.firstName} ${item.userInfo!.lastName!}",
                isTile: true,
              ),
              SizedBox(
                height: size.height * 0.005,
              ),
              BaseText(
                text: "#${item.userId}",
                colorText: Colors.grey,
              ),
            ],
          ),
        ),
        SizedBox(
          width: size.width * 0.0125,
        ),
        SvgPicture.asset(
          "assets/images/common/ic_time_checkin.svg",
          color: controller.checkTimekCheckInisLate(
                  item.timeCheckin!, item.shiftInfo!.timeStart!)
              ? null
              : AppColor.colorTextTimeLate,
        ),
        SizedBox(
          width: size.width * 0.1,
          child: BaseText(
            text: controller.filterHoursfromDateTime(item.timeCheckin!),
            colorText: controller.checkTimekCheckInisLate(
                    item.timeCheckin!, item.shiftInfo!.timeStart!)
                ? AppColor.colorTextTimeNormal
                : AppColor.colorTextTimeLate,
          ),
        ),
        SizedBox(
          width: size.width * 0.025,
        ),
        SvgPicture.asset("assets/images/common/ic_time_checkout.svg"),
        SizedBox(
          width: size.width * 0.1,
          child: BaseText(
            text: item.timeCheckout == null
                ? "--:--"
                : controller.filterHoursfromDateTime(item.timeCheckout!),
            colorText: AppColor.colorTextTimeNormal,
          ),
        ),
        SizedBox(
          width: size.width * 0.05,
        ),
      ],
    );
  }
}
