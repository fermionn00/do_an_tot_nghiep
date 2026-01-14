import 'package:app_work_log/common/utils/numeral.dart';
import 'package:app_work_log/common/widgets/base_appbar.dart';
import 'package:app_work_log/common/widgets/base_button_login.dart';
import 'package:app_work_log/common/widgets/base_gradient_text.dart';
import 'package:app_work_log/common/widgets/base_text_form_field.dart';
import 'package:app_work_log/modules/login/controllers/forgot_password_controller.dart';
import 'package:app_work_log/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({super.key});

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
            child: Column(
              children: [
                const BaseAppBar(
                  title: "",
                  action: SizedBox(),
                  hasBack: true,
                ),
                Expanded(
                  child: Column(
                    children: [
                      getTitleWidget(),
                      SizedBox(height: size.height * 0.05),
                      getFormWidget(context),
                      SizedBox(height: size.height * 0.04),
                      getButton(context),
                      SizedBox(height: size.height * 0.1),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }

  getButton(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Padding(
        padding: EdgeInsets.only(bottom: size.height * 0.05),
        child: GestureDetector(
          onTap: () {
            controller.clickSave();
          },
          child: BaseButtonLogin(
            height: size.height * 0.06,
            width: size.width * 0.7,
            title: "send".tr,
            borderRadius: 14,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ));
  }

  getFormWidget(BuildContext context) {
    return Form(
      key: controller.formKeyCreateStaff,
      child: Obx(
        () => Column(children: [
          getInputWidget(context),
          Visibility(
            visible: controller.steps.value != Numeral.stepInputEmail,
            child: inputConfirmCode(context),
          ),
          Visibility(
              visible: controller.steps.value == Numeral.stepInputPasswordNew,
              child: inputPasswordNew(context)),
        ]),
      ),
    );
  }

  Widget getInputWidget(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Container(
      width: size.width * 0.85,
      padding: const EdgeInsets.symmetric(vertical: 7),
      decoration: BoxDecoration(
          color: AppColor.lightPurple,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(color: Colors.black12, spreadRadius: 2, blurRadius: 4)
          ]),
      child: BaseTextFormField(
        prefixIcon: Icon(Icons.email,
            color: AppColor.primaryGrey.withAlpha(
              (0.8 * 255).round(),
            )),
        label: "email".tr,
        controller: controller.textEmail,
        validateFunction: controller.emailValidateFunc,
      ),
    );
  }

  Widget inputConfirmCode(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Container(
      margin: EdgeInsets.only(
        top: size.height * 0.02,
      ),
      width: size.width * 0.85,
      padding: const EdgeInsets.symmetric(vertical: 7),
      decoration: BoxDecoration(
          color: AppColor.lightPurple,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(color: Colors.black12, spreadRadius: 2, blurRadius: 4)
          ]),
      child: BaseTextFormField(
        prefixIcon: Icon(Icons.code,
            color: AppColor.primaryGrey.withAlpha(
              (0.8 * 255).round(),
            )),
        label: "code".tr,
        controller: controller.textCode,
        validateFunction: controller.emptyValidateFunc,
      ),
    );
  }

  Widget inputPasswordNew(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Container(
      margin: EdgeInsets.only(
        top: size.height * 0.02,
      ),
      width: size.width * 0.85,
      padding: const EdgeInsets.symmetric(vertical: 7),
      decoration: BoxDecoration(
          color: AppColor.lightPurple,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(color: Colors.black12, spreadRadius: 2, blurRadius: 4)
          ]),
      child: Obx(
        () => Column(
          children: [
            BaseTextFormField(
              prefixIcon: Icon(Icons.password,
                  color: AppColor.primaryGrey.withAlpha(
                    (0.8 * 255).round(),
                  )),
              label: "new_password".tr,
              obscureText: controller.obscureNewPassword.value,
              controller: controller.textNewPassword,
              suffixIcon: Align(
                widthFactor: 1.0,
                heightFactor: 1.0,
                child: InkWell(
                  onTap: () {
                    controller.obscureNewPassword.toggle();
                  },
                  child: Icon(
                    controller.obscureNewPassword.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                ),
              ),
              validateFunction: controller.passwordValidateFunc,
            ),
            Divider(),
            BaseTextFormField(
              prefixIcon: Icon(Icons.password,
                  color: AppColor.primaryGrey.withAlpha(
                    (0.8 * 255).round(),
                  )),
              label: "confirm_password".tr,
              textInputType: TextInputType.visiblePassword,
              obscureText: controller.obscureConfirmPassword.value,
              controller: controller.textConfirmPassword,
              suffixIcon: Align(
                widthFactor: 1.0,
                heightFactor: 1.0,
                child: InkWell(
                  onTap: () {
                    controller.obscureConfirmPassword.toggle();
                  },
                  child: Icon(
                    controller.obscureConfirmPassword.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                ),
              ),
              validateFunction: controller.confirmPasswordValidateFunc,
            ),
          ],
        ),
      ),
    );
  }

  getTitleWidget() {
    return Column(
      children: [
        GradientText(
          'forgot_password'.tr,
          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
          gradient: LinearGradient(colors: [
            AppColor.primaryBlue,
            AppColor.primaryPurple,
          ]),
        ),
        Text(
          "reset_your_password".tr,
          style: TextStyle(
              color: AppColor.primaryGrey,
              fontSize: 14,
              fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
