import 'package:app_work_log/common/widgets/base_appbar.dart';
import 'package:app_work_log/common/widgets/base_button.dart';
import 'package:app_work_log/common/widgets/base_gradient_text.dart';
import 'package:app_work_log/common/widgets/base_text_form_field.dart';
import 'package:app_work_log/modules/login/controllers/login_controller.dart';
import 'package:app_work_log/oauth2/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_work_log/routes/app_pages.dart';
import 'package:app_work_log/themes/app_color.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      getTitleWidget(),
                      SizedBox(height: size.height * 0.07),
                      getSignInWidget(context),
                      SizedBox(height: size.height * 0.02),

                      SizedBox(
                        width: size.width * 0.8,
                        child: Row(
                          children: [
                            Obx(
                              () => InkWell(
                                onTap: () {
                                  Get.find<AuthService>().setSaveInfoLogin(
                                      controller.statusSaveInfoLogin
                                          .toggle()
                                          .value);
                                },
                                child: controller.statusSaveInfoLogin.value
                                    ? Image.asset(
                                        "assets/icons/ic_check_box.png",
                                        width: 22,
                                        height: 22)
                                    : Image.asset(
                                        "assets/icons/ic_uncheck_box.png",
                                        width: 22,
                                        height: 22),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'keep_me_sign_in'.tr,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.primaryGrey),
                            ),
                            Expanded(
                              child: Container(),
                            ),
                            InkWell(
                              onTap: () {
                                Get.toNamed(Routes.forgotPassword);
                              },
                              child: GradientText(
                                'Forgot Password'.tr,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                                gradient: LinearGradient(colors: [
                                  AppColor.primaryBlue,
                                  AppColor.primaryPurple,
                                ]),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Next button
                      Padding(
                        padding: EdgeInsets.only(bottom: 60.0, top: 40),
                        child: GestureDetector(
                          onTap: () {
                            controller.validateAndLogin();
                          },
                          child: BaseButton(
                              height: size.height * 0.07,
                              width: size.width * 0.8,
                              title: "intro_sign_in_button_label".tr,
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
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }

  getSignInWidget(BuildContext context) {
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
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                BaseTextFormField(
                  controller: controller.textEmail,
                  prefixIcon: Icon(Icons.email,
                      color: AppColor.primaryGrey.withAlpha(
                        (0.8 * 255).round(),
                      )),
                  label: 'email'.tr,
                  validateFunction: controller.emptyValidateFunc,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: Divider(),
                ),
                Obx(
                  () => BaseTextFormField(
                    controller: controller.textPassword,
                    prefixIcon: Icon(Icons.lock,
                        color: AppColor.primaryGrey.withAlpha(
                          (0.8 * 255).round(),
                        )),
                    label: 'password'.tr,
                    obscureText: !controller.showPassword.value,
                    textInputType: TextInputType.visiblePassword,
                    suffixIcon: Align(
                      widthFactor: 1.0,
                      heightFactor: 1.0,
                      child: InkWell(
                        onTap: () {
                          controller.showPassword.value =
                              !controller.showPassword.value;
                        },
                        child: Icon(
                          controller.showPassword.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                    ),
                    validateFunction: controller.emptyValidateFunc,
                  ),
                ),
              ],
            ),
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
