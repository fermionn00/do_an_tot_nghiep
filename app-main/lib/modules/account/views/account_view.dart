import 'package:app_work_log/common/global.dart';
import 'package:app_work_log/modules/account/controllers/account_controller.dart';
import 'package:app_work_log/modules/account/widget/account_header.dart';
import 'package:app_work_log/modules/account/widget/item_option_account.dart';
import 'package:app_work_log/oauth2/service/auth_service.dart';
import 'package:app_work_log/routes/app_pages.dart';
import 'package:app_work_log/themes/app_color.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AccountView extends GetView<AccountController> {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: size.height,
        width: size.width,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/images/common/img_bg_1.png",
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: SafeArea(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              const AccountHeader(),
              Container(
                margin: EdgeInsets.only(top: size.height * 0.08),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      ItemOptionAccount(
                        img: SvgPicture.asset(
                          "assets/images/profile/ic_update_profile.svg",
                          colorFilter: ColorFilter.mode(
                            AppColor.colorIconProfile,
                            BlendMode.color,
                          ),
                        ),
                        name: "update_profile",
                        clickItem: () {
                          Get.toNamed(Routes.updateProfile,
                              arguments: controller.userInfo.value);
                        },
                      ),
                      ItemOptionAccount(
                        img: SvgPicture.asset(
                          "assets/images/profile/ic_change_password.svg",
                          colorFilter: ColorFilter.mode(
                            AppColor.colorIconProfile,
                            BlendMode.color,
                          ),
                        ),
                        name: "change_password".tr,
                        clickItem: () {
                          Get.toNamed(Routes.changePassword);
                        },
                      ),
                      ItemOptionAccount(
                        img: SvgPicture.asset(
                          "assets/images/manage/ic_leave_request.svg",
                          colorFilter: ColorFilter.mode(
                            AppColor.colorIconProfile,
                            BlendMode.color,
                          ),
                        ),
                        name: "leave_requests".tr,
                        clickItem: () {
                          Get.toNamed(Routes.leaveRequestHistory);
                        },
                      ),
                      ItemOptionAccount(
                        img: SvgPicture.asset(
                          "assets/images/manage/ic_overtime_requests.svg",
                          colorFilter: ColorFilter.mode(
                            AppColor.colorIconProfile,
                            BlendMode.color,
                          ),
                        ),
                        name: "overtime".tr,
                        clickItem: () {
                          Get.toNamed(Routes.overtimeRequestHistory);
                        },
                      ),
                      ItemOptionAccount(
                        img: SvgPicture.asset(
                          "assets/images/profile/ic_language.svg",
                          colorFilter: ColorFilter.mode(
                            AppColor.colorIconProfile,
                            BlendMode.color,
                          ),
                        ),
                        name: "language".tr,
                        clickItem: () {
                          Get.toNamed(Routes.language);
                        },
                      ),
                      ItemOptionAccount(
                        img: SvgPicture.asset(
                          "assets/images/manage/ic_attendance_checkin.svg",
                          colorFilter: ColorFilter.mode(
                            AppColor.colorIconProfile,
                            BlendMode.color,
                          ),
                        ),
                        name: "default_checkin_method".tr,
                        clickItem: () {
                          Get.toNamed(
                            Routes.defaultCheckin,
                          );
                        },
                      ),
                      ItemOptionAccount(
                        img: SvgPicture.asset(
                          "assets/images/manage/ic_shift_textfield.svg",
                          colorFilter: ColorFilter.mode(
                            AppColor.colorIconProfile,
                            BlendMode.color,
                          ),
                        ),
                        name: "default_shift".tr,
                        clickItem: () {
                          Get.toNamed(
                            Routes.defaultShift,
                            arguments: controller.userInfo.value,
                          );
                        },
                      ),
                      ItemOptionAccount(
                        img: SvgPicture.asset(
                            "assets/images/profile/ic_logout.svg"),
                        name: "log_out".tr,
                        clickItem: () {
                          var auth = Get.find<AuthService>();
                          Global.refreshGlobacl();
                          auth.logout();
                        },
                      ),
                      ItemOptionAccount(
                        img: SvgPicture.asset(
                          "assets/images/manage/ic_statistics_checkin.svg",
                          colorFilter: const ColorFilter.mode(
                              Colors.white, BlendMode.srcIn),
                        ),
                        textColor: AppColor.lightRed,
                        name: "delete_account".tr,
                        clickItem: () {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.scale,
                            title: "Delete account",
                            desc: "Do you really want to delete this account?",
                            btnOkColor: AppColor.lightRed,
                            btnOkOnPress: () {
                              var auth = Get.find<AuthService>();
                              Global.refreshGlobacl();
                              auth.logout();
                            },
                          ).show();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
