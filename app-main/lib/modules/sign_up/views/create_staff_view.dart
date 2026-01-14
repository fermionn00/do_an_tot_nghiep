import 'package:app_work_log/common/widgets/base_appbar.dart';
import 'package:app_work_log/common/widgets/base_button_login.dart';
import 'package:app_work_log/common/widgets/base_gradient_text.dart';
import 'package:app_work_log/common/widgets/base_text_form_field.dart';
import 'package:app_work_log/modules/sign_up/controllers/sign_up_staff_controller.dart';
import 'package:app_work_log/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateStaffView extends GetView<SignUpStaffController> {
  const CreateStaffView({super.key});
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
                  image: AssetImage("assets/images/common/img_bg_2.png"),
                  fit: BoxFit.fill)),
          child: Padding(
            padding: EdgeInsets.only(
                top: size.height * 0.04,
                right: size.width * 0.03,
                left: size.width * 0.03),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const BaseAppBar(
                    title: "",
                    action: SizedBox(),
                    hasBack: true,
                  ),
                  SizedBox(height: size.height * 0.02),
                  getTitleWidget(),
                  SizedBox(height: size.height * 0.03),
                  getFormWidget(context),
                  SizedBox(height: size.height * 0.03),
                  getButton(context),
                  (MediaQuery.of(context).viewInsets.bottom != 0)
                      ? SizedBox(
                          height: MediaQuery.of(context).viewInsets.bottom)
                      : const SizedBox()
                ],
              ),
            ),
          )),
    );
  }

  getButton(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Padding(
      padding: EdgeInsets.only(bottom: size.height * 0.03),
      child: GestureDetector(
        onTap: () {
          controller.validateAndSignUp(context);
        },
        child: BaseButtonLogin(
            // height: size.height * 0.06,
            //   width: size.width * 0.85,
            title: "sign_up".tr,
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
    );
  }

  getFormWidget(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Form(
      key: controller.formKeyCreateStaff,
      child: Column(children: [
        getInputWidget(context),
        const SizedBox(height: 18),
        SizedBox(
          width: size.width * 0.9,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(
                () => GestureDetector(
                  onTap: () => controller.updateCheckPrivacy(),
                  child: Image.asset(
                      (controller.isCheckedPrivacy.value)
                          ? "assets/icons/ic_check_box.png"
                          : "assets/icons/ic_uncheck_box.png",
                      width: 22,
                      height: 22),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('by_signing_you_agree_to_our'.tr,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColor.primaryGrey)),
                  GradientText(
                    'term_of_use_and_privacy'.tr,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w600),
                    gradient: LinearGradient(colors: [
                      AppColor.primaryBlue,
                      AppColor.primaryPurple,
                    ]),
                  ),
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }

  getInputWidget(BuildContext context) {
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
          child: Column(
            children: [
              BaseTextFormField(
                prefixIcon: Icon(Icons.apartment_rounded,
                    color: AppColor.primaryGrey.withAlpha(
                      (0.8 * 255).round(),
                    )),
                label: "Company Name",
                enabled: false,
                controller: controller.textCompanyName,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: Divider(),
              ),
              BaseTextFormField(
                prefixIcon: Icon(Icons.email,
                    color: AppColor.primaryGrey.withAlpha(
                      (0.8 * 255).round(),
                    )),
                label: 'email'.tr,
                controller: controller.textEmail,
                validateFunction: controller.emailValidateFunc,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: Divider(),
              ),
              BaseTextFormField(
                prefixIcon: Icon(Icons.person,
                    color: AppColor.primaryGrey.withAlpha(
                      (0.8 * 255).round(),
                    )),
                label: 'first_name'.tr,
                controller: controller.textFirstName,
                validateFunction: controller.emptyValidateFunc,
              ),
              BaseTextFormField(
                prefixIcon: Icon(Icons.person,
                    color: AppColor.primaryGrey.withAlpha(
                      (0.8 * 255).round(),
                    )),
                label: 'last_name'.tr,
                controller: controller.textLastName,
                validateFunction: controller.emptyValidateFunc,
              ),
              BaseTextFormField(
                prefixIcon: Icon(Icons.badge,
                    color: AppColor.primaryGrey.withAlpha(
                      (0.8 * 255).round(),
                    )),
                label: 'employee_id'.tr,
                controller: controller.textEmployeeID,
                validateFunction: controller.emptyValidateFunc,
              ),
              BaseTextFormField(
                prefixIcon: Icon(Icons.lock,
                    color: AppColor.primaryGrey.withAlpha(
                      (0.8 * 255).round(),
                    )),
                label: 'password'.tr,
                controller: controller.textPassword,
                validateFunction: controller.passwordValidateFunc,
              ),
              BaseTextFormField(
                prefixIcon: Icon(Icons.enhanced_encryption,
                    color: AppColor.primaryGrey.withAlpha(
                      (0.8 * 255).round(),
                    )),
                label: 'confirm_password'.tr,
                controller: controller.textConfirmPassword,
                validateFunction: controller.confirmPasswordValidateFunc,
              ),
            ],
          ),
        )
      ],
    );
  }

  getTitleWidget() {
    return Column(
      children: [
        GradientText(
          'sign_up'.tr,
          style: const TextStyle(fontSize: 38, fontWeight: FontWeight.w600),
          gradient: LinearGradient(colors: [
            AppColor.primaryBlue,
            AppColor.primaryPurple,
          ]),
        ),
        Text(
          "create_your_new_account".tr,
          style: TextStyle(
              color: AppColor.primaryGrey,
              fontSize: 14,
              fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
