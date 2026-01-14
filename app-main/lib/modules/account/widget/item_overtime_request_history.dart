import 'package:app_work_log/common/utils/numeral.dart';
import 'package:app_work_log/common/widgets/base_button.dart';
import 'package:app_work_log/common/widgets/base_text.dart';
import 'package:app_work_log/modules/account/models/overtime_request_model.dart';
import 'package:app_work_log/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ItemOverTimeRequestHistory extends StatelessWidget {
  final OvertimeRequestModel overtimeRequest;
  const ItemOverTimeRequestHistory({super.key, required this.overtimeRequest});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(
                  top: size.height * 0.005, left: size.width * 0.1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      BaseText(
                        text: "from".tr,
                        colorText: AppColor.primaryBlue,
                        isTile: true,
                        size: 13,
                      ),
                      const SizedBox(width: 6),
                      BaseText(
                        text: DateFormat("yyyy-MM-dd hh:mm")
                            .format(overtimeRequest.timeStart!),
                        colorText: AppColor.primaryBlue,
                        isTile: true,
                        size: 13,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      BaseText(
                        text: "to".tr,
                        colorText: AppColor.primaryBlue,
                        isTile: true,
                        size: 13,
                      ),
                      const SizedBox(width: 6),
                      BaseText(
                        text: DateFormat("yyyy-MM-dd hh:mm")
                            .format(overtimeRequest.timeEnd!),
                        colorText: AppColor.primaryBlue,
                        isTile: true,
                        size: 13,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            getStatusWidget(
                context: context, type: overtimeRequest.statusCode ?? 1)
          ],
        ),
        const Divider(),
      ],
    );
  }

  getStatusWidget({required BuildContext context, required int type}) {
    final size = MediaQuery.sizeOf(context);

    String label = "pending".tr;
    Color color = AppColor.colorButtonPending;

    if (type == Numeral.statusCodeApproved) {
      label = "approved".tr;
      color = AppColor.colorButtonApproved;
    } else if (type == Numeral.statusCodeReject) {
      label = "rejected".tr;
      color = AppColor.colorButtonReject;
    }

    return Container(
      margin: EdgeInsets.only(right: size.width * 0.05),
      child: InkWell(
        onTap: () {},
        child: BaseButton(
          height: size.height * 0.05,
          width: size.width * 0.25,
          title: label,
          borderRadius: 20,
          textColor: AppColor.primaryText,
          fontWeight: FontWeight.w500,
          colorBegin: color,
          colorEnd: color,
        ),
      ),
    );
  }
}
