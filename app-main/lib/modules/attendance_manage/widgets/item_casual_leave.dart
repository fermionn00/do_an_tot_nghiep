import 'package:app_work_log/common/widgets/base_text.dart';
import 'package:app_work_log/modules/attendance_manage/models/attendance_casual_leave_manage.dart';
import 'package:flutter/material.dart';

class ItemCasualLeave extends StatelessWidget {
  final AttendanceCasualLeave item;
  const ItemCasualLeave({super.key, required this.item});

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
              text: item.userInfo!.firstName![0],
              isTile: true,
              size: 18,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BaseText(
              text: "${item.userInfo!.firstName!} ${item.userInfo!.lastName!}",
              isTile: true,
            ),
            SizedBox(
              height: size.height * 0.005,
            ),
            BaseText(
              text: "#${item.userInfo!.employeeCode}",
              colorText: Colors.grey,
            ),
          ],
        ),
        Expanded(
          child: Container(),
        ),
        Container(
          height: size.width * 0.1,
          width: size.width * 0.25,
          decoration: BoxDecoration(
              color: Colors.blue, borderRadius: BorderRadius.circular(20)),
          child: const Center(
            child: BaseText(
              text: "Casual Leave",
              colorText: Colors.white,
            ),
          ),
        ),
        SizedBox(
          width: size.width * 0.05,
        ),
      ],
    );
  }
}
