import 'package:app_work_log/common/widgets/base_button.dart';
import 'package:app_work_log/common/widgets/base_text.dart';
import 'package:app_work_log/common/widgets/base_text_form_field.dart';
import 'package:app_work_log/modules/department_manage/controllers/department_manage_controller.dart';
import 'package:app_work_log/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomInputNameCsv extends GetView<DepartmentManageController> {
  const BottomInputNameCsv({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Form(
      key: controller.formKey,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14),
        height: size.height * 0.32,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BaseText(
              text: "noti_input_name_file_csv".tr,
              isTile: true,
              size: 24,
            ),
            const Divider(),
            BaseTextFormField(
              controller: controller.textNameFileCsv.value,
              prefixIcon: Icon(Icons.code,
                  color: AppColor.primaryGrey.withAlpha(
                    (0.8 * 255).round(),
                  )),
              label: "name_file_csv".tr,
              validateFunction: controller.emptyValidateFunc,
            ),
            Container(
              margin: EdgeInsets.only(
                left: size.width * 0.025,
                right: size.width * 0.025,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: BaseButton(
                      height: size.height * 0.05,
                      width: size.width * 0.35,
                      title: "cancel".tr,
                      colorBegin: AppColor.colorButtonReject,
                      colorEnd: AppColor.colorButtonReject.withAlpha(
                        (0.8 * 255).round(),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.validateConfirm();
                    },
                    child: BaseButton(
                      height: size.height * 0.05,
                      width: size.width * 0.35,
                      title: "confirm".tr,
                      colorBegin: AppColor.colorButtonApproved,
                      colorEnd: AppColor.colorButtonApproved.withAlpha(
                        (0.8 * 255).round(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
