import 'package:app_work_log/common/widgets/base_appbar.dart';
import 'package:app_work_log/common/widgets/base_button_login.dart';
import 'package:app_work_log/common/widgets/base_gradient_text.dart';
import 'package:app_work_log/common/widgets/base_text_form_field.dart';
import 'package:app_work_log/modules/sign_up/controllers/sign_up_staff_controller.dart';
import 'package:app_work_log/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';

class SignUpStaffView extends GetView<SignUpStaffController> {
  const SignUpStaffView({super.key});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
          width: size.width,
          height: size.height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/common/img_bg_1.png"),
                  fit: BoxFit.fill)),
          child: Padding(
            padding: EdgeInsets.only(
                top: size.height * 0.04,
                right: size.width * 0.03,
                left: size.width * 0.03),
            child: Column(
              children: [
                const BaseAppBar(
                  title: "",
                  action: SizedBox(),
                  hasBack: true,
                ),
                Expanded(
                  child: Form(
                    key: controller.formKeySignUp,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        getTitleWidget(),
                        SizedBox(height: size.height * 0.07),
                        getCompanyIdWidget(context),
                        SizedBox(height: size.height * 0.02),
                        InkWell(
                          onTap: () async {
                            controller.textCompanyIdController.text =
                                await FlutterBarcodeScanner.scanBarcode(
                                    '#ff6666',
                                    'Cancel',
                                    false,
                                    ScanMode.BARCODE);
                          },
                          child: Image.asset(
                            "assets/images/sign_up/img_qr_button.png",
                            width: size.width * 0.3,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        SizedBox(height: size.height * 0.02),

                        // Next button
                        GestureDetector(
                          onTap: () async {
                            await controller.validateAndNexttoSignUp(context);
                          },
                          child: BaseButtonLogin(
                              height: size.height * 0.07,
                              width: size.width * 0.8,
                              title: "next".tr,
                              textColor: Colors.white,
                              fontSize: 20,
                              verticalPadding: 14,
                              horizontalPadding: 10,
                              colorBegin: AppColor.primaryBlue
                                ..withAlpha(
                                  (0.9 * 255).round(),
                                ),
                              colorEnd: AppColor.primaryPurple
                                ..withAlpha(
                                  (0.9 * 255).round(),
                                ),
                              fontWeight: FontWeight.w600,
                              borderRadius: 10),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  getCompanyIdWidget(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: size.width * 0.85,
          padding: const EdgeInsets.symmetric(vertical: 7),
          decoration: BoxDecoration(
              color: AppColor.lightPurple,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(color: Colors.black12, spreadRadius: 2, blurRadius: 4)
              ]),
          child: BaseTextFormField(
            controller: controller.textCompanyIdController,
            prefixIcon: Icon(Icons.apartment,
                color: AppColor.primaryGrey.withAlpha(
                  (0.8 * 255).round(),
                )),
            label: 'company_id'.tr,
            validateFunction: controller.emptyValidateFunc,
          ),
        )
      ],
    );
  }

  getTitleWidget() {
    return Column(
      children: [
        GradientText(
          'welcome_back'.tr,
          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
          gradient: LinearGradient(colors: [
            AppColor.primaryBlue,
            AppColor.primaryPurple,
          ]),
        ),
        const SizedBox(height: 10),
        Text(
          "welcome_back_desc".tr,
          style: TextStyle(
              color: AppColor.primaryGrey,
              fontSize: 15,
              fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
