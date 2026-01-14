import 'package:app_work_log/common/widgets/base_button.dart';
import 'package:app_work_log/common/widgets/base_text.dart';
import 'package:app_work_log/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseDialogConfirm extends StatelessWidget {
  final String title;
  final String? contentCancel;
  final VoidCallback clickCancel;
  final String? contentConfirm;
  final VoidCallback clickConfirm;
  const BaseDialogConfirm(
      {super.key,
      required this.title,
      this.contentCancel,
      required this.clickCancel,
      this.contentConfirm,
      required this.clickConfirm});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size.width * 0.8,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.025,
              ),
              BaseText(
                text: title,
                isTile: true,
                size: 24,
              ),
              SizedBox(
                height: size.height * 0.0125,
              ),
              const Divider(),
              SizedBox(
                height: size.height * 0.0125,
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
                      onTap: clickCancel,
                      child: BaseButton(
                        height: size.height * 0.05,
                        width: size.width * 0.35,
                        title: contentCancel ?? "cancel".tr,
                        colorBegin: AppColor.colorButtonReject,
                        colorEnd: AppColor.colorButtonReject.withAlpha(
                          (0.8 * 255).round(),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: clickConfirm,
                      child: BaseButton(
                        height: size.height * 0.05,
                        width: size.width * 0.35,
                        title: contentConfirm ?? "confirm".tr,
                        colorBegin: AppColor.colorButtonApproved,
                        colorEnd: AppColor.colorButtonApproved.withAlpha(
                          (0.8 * 255).round(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.025,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
