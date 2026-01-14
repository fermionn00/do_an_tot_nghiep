import 'package:app_work_log/common/widgets/base_text.dart';
import 'package:app_work_log/modules/account/controllers/account_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountHeader extends GetView<AccountController> {
  const AccountHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: size.height * 0.025),
            height: size.width * 0.2,
            width: size.width * 0.2,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  width: 1,
                  color: Colors.grey.withAlpha(
                    (0.5 * 255).round(),
                  ),
                ),
                shape: BoxShape.circle),
            child: Center(
              child: BaseText(
                text: controller.userFullName.value[0],
                isTile: true,
                size: 24,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: size.height * 0.0125),
            child: BaseText(
              text: controller.userFullName.value,
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
    );
  }
}
