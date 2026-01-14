import 'package:app_work_log/common/widgets/base_text.dart';
import 'package:app_work_log/modules/attendance/models/attendance_model.dart';
import 'package:app_work_log/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class ItemAttendanceWidget extends StatelessWidget {
  final AttendanceModel attendance;
  final String date = "11\nTue";
  final String checkInTime = "--:--";
  final String checkOutTime = "--:--";
  final String workingHour = "--:--";

  final List<String> weekdays = [
    "Mon",
    "Tue",
    "Wed",
    "Thu",
    "Fri",
    "Sat",
    "Sun"
  ];

  ItemAttendanceWidget({super.key, required this.attendance});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Container(
      margin: EdgeInsets.only(top: size.height * 0.0125),
      child: Row(
        children: [
          SizedBox(
            width: size.width * 0.18,
            child: Container(
              height: size.width * 0.15,
              width: size.width * 0.15,
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.grey,
                  ),
                  shape: BoxShape.circle),
              child: Center(
                child: BaseText(
                  text:
                      "${attendance.timeCheckin?.day}\n${weekdays[attendance.timeCheckin!.weekday - 1]}",
                  isTile: true,
                  size: 14,
                ),
              ),
            ),
          ),
          SizedBox(
            width: size.width * 0.07,
            child: SvgPicture.asset(
              "assets/images/common/ic_time_checkin.svg",
              color: checkTimekCheckInisLate(
                      attendance.timeCheckin!, attendance.shiftInfo!.timeStart!)
                  ? null
                  : AppColor.colorTextTimeLate,
            ),
          ),
          SizedBox(
            width: size.width * 0.175,
            child: BaseText(
              text: DateFormat("HH:mm")
                  .format(attendance.timeCheckin ?? DateTime.now()),
              colorText: checkTimekCheckInisLate(
                      attendance.timeCheckin!, attendance.shiftInfo!.timeStart!)
                  ? AppColor.colorTextTimeNormal
                  : AppColor.colorTextTimeLate,
              size: 12,
            ),
          ),
          SizedBox(
            width: size.width * 0.07,
            child:
                SvgPicture.asset("assets/images/common/ic_time_checkout.svg"),
          ),
          SizedBox(
            width: size.width * 0.175,
            child: BaseText(
              text: DateFormat("HH:mm")
                  .format(attendance.timeCheckout ?? DateTime.now()),
              colorText: AppColor.colorTextTimeNormal,
              size: 12,
            ),
          ),
          Expanded(
            child: Center(
              child: BaseText(
                text: calWorkingHour(
                    attendance.timeCheckin, attendance.timeCheckout),
                colorText: AppColor.colorTextWorkingHrs,
                size: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool checkTimekCheckInisLate(DateTime checkIn, String workTime) {
    DateTime time = DateFormat("HH:mm").parse(workTime);
    DateTime dateTimeWorkingBegin = DateTime(
        checkIn.year, checkIn.month, checkIn.day, time.hour, time.second);
    if (checkIn.compareTo(dateTimeWorkingBegin) <= 0) {
      return true;
    }
    return false;
  }

  String calWorkingHour(DateTime? checkInTime, DateTime? checkOutTime) {
    var formatter = NumberFormat('00');

    if (checkInTime == null || checkOutTime == null) {
      return "--:--";
    } else {
      final Duration duration = checkOutTime.difference(checkInTime);
      int durationInMin = duration.inMinutes;
      return "${formatter.format(durationInMin ~/ 60)}h${formatter.format(durationInMin % 60)}";
    }
  }
}
