import 'package:app_work_log/common/widgets/base_button.dart';
import 'package:app_work_log/common/widgets/base_text.dart';
import 'package:app_work_log/common/widgets/base_text_form_field.dart';
import 'package:app_work_log/modules/staff_manage/controllers/profile_staff_controller.dart';
import 'package:app_work_log/modules/staff_manage/controllers/staff_manage_controller.dart';
import 'package:app_work_log/modules/staff_manage/models/department.dart';
import 'package:app_work_log/routes/app_pages.dart';
import 'package:app_work_log/themes/app_color.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProfileStaffManageView extends GetView<ProfileStaffController> {
  const ProfileStaffManageView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/images/common/img_bg_1.png",
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(
                            Icons.chevron_left,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Obx(
                    () => Container(
                      margin: EdgeInsets.only(top: size.height * 0.0125),
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
                          text: controller.staff.value.firstName == null
                              ? "N"
                              : controller.staff.value.firstName![0],
                          isTile: true,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                  Obx(
                    () => Container(
                      margin: EdgeInsets.only(top: size.height * 0.0125),
                      child: BaseText(
                        text: controller.staff.value.firstName == null ||
                                controller.staff.value.lastName == null
                            ? "Null"
                            : "${controller.staff.value.firstName!} ${controller.staff.value.lastName!}",
                        isTile: true,
                        size: 18,
                      ),
                    ),
                  ),
                  // BaseText(
                  //   text: "Product Manager",
                  //   size: 16,
                  // ),
                  workInfomationView(context),
                  personalInfomationView(context),
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: size.height * 0.0125,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.toNamed(Routes.workingHoursStatistics,
                                arguments: controller.staff.value);
                          },
                          child: BaseButton(
                            height: size.height * 0.06,
                            width: size.width * 0.4,
                            title: "woring_hour".tr,
                            iconLeft: SizedBox(
                              height: size.width * 0.05,
                              width: size.width * 0.05,
                              child: SvgPicture.asset(
                                "assets/images/manage/ic_attendance_staff.svg",
                                color: Colors.white,
                              ),
                            ),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.05,
                        ),
                        Obx(
                          () => InkWell(
                            onTap: () async {
                              if (await controller.activeStaff(context)) {
                                /// Thông báo thành công
                                Get.find<StaffManageController>()
                                    .getListStaff();
                              }
                            },
                            child: BaseButton(
                              height: size.height * 0.06,
                              width: size.width * 0.4,
                              title: controller.isActive.value
                                  ? "in_active".tr
                                  : "active".tr,
                              colorBegin: AppColor.primaryPink,
                              colorEnd: AppColor.primaryPink.withAlpha(
                                (0.7 * 255).round(),
                              ),
                              iconLeft: SizedBox(
                                height: size.width * 0.05,
                                width: size.width * 0.05,
                                child: SvgPicture.asset(
                                    "assets/images/manage/ic_inactive_staff.svg"),
                              ),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.06,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget workInfomationView(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
              left: size.width * 0.05,
              right: size.width * 0.05,
              top: size.height * 0.025),
          child: Row(
            children: [
              BaseText(
                text: "work_info".tr,
                size: 16,
              ),
              Expanded(
                child: Container(),
              ),
              Obx(
                () => !controller.editWorkInfo.value
                    ? InkWell(
                        onTap: () {
                          controller.editWorkInfo.toggle();
                        },
                        child: SvgPicture.asset(
                            "assets/images/common/ic_edit_profile.svg"),
                      )
                    : Row(
                        children: [
                          InkWell(
                            onTap: () {
                              controller.editWorkInfo.toggle();
                            },
                            child: Icon(
                              Icons.close,
                              color: AppColor.lightRed,
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.025,
                          ),
                          InkWell(
                            onTap: () async {
                              if (await controller.validateUpdate()) {
                                if (await controller
                                    .updateWorkInfoStaff(context)) {
                                  controller.editWorkInfo.toggle();
                                  Get.find<StaffManageController>()
                                      .getListStaff();
                                }
                              }
                            },
                            child: Icon(
                              Icons.check,
                              color: AppColor.primaryGreen,
                            ),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              left: size.width * 0.05,
              right: size.width * 0.05,
              top: size.height * 0.0125),
          decoration: BoxDecoration(
              color: AppColor.lightPurple,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(color: Colors.black12, spreadRadius: 2, blurRadius: 4)
              ]),
          child: Obx(
            () => Column(
              children: [
                Container(
                  height: size.height * 0.08,
                  width: size.width,
                  margin: EdgeInsets.only(
                    left: 15,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.roofing,
                        color: AppColor.primaryGrey.withAlpha(
                          (0.8 * 255).round(),
                        ),
                      ),
                      Expanded(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2<DepartmentManage>(
                            isExpanded: true,
                            hint: TextFormField(
                              cursorColor: Colors.black,
                              readOnly: true,
                              decoration: InputDecoration(
                                labelText: controller.selectedDropBox.value,
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                labelStyle: TextStyle(
                                    color: (controller.isValidManager.value)
                                        ? AppColor.primaryGrey
                                        : AppColor.lightRed,
                                    fontSize: 14),
                              ),
                            ),
                            items: controller.listDepartment
                                .map((item) => DropdownMenuItem(
                                      value: item,
                                      child: Text(
                                        item.managerInfo == null
                                            ? "${item.name}"
                                            : "${item.name} - ${item.managerInfo?.firstName} ${item.managerInfo?.lastName}",
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            onChanged: !controller.editWorkInfo.value
                                ? null
                                : (value) {
                                    if (value != null) {
                                      controller
                                          .updateSelectedDepartment(value);
                                    }
                                  },
                            buttonStyleData: const ButtonStyleData(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              height: 40,
                              width: 200,
                            ),
                            dropdownStyleData: const DropdownStyleData(
                              maxHeight: 200,
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              height: 40,
                            ),
                            dropdownSearchData: DropdownSearchData(
                              searchController:
                                  controller.searchDropBoxController,
                              searchInnerWidgetHeight: 50,
                              searchInnerWidget: Container(
                                height: 50,
                                padding: const EdgeInsets.only(
                                  top: 8,
                                  bottom: 4,
                                  right: 8,
                                  left: 8,
                                ),
                                child: TextFormField(
                                  expands: true,
                                  maxLines: null,
                                  controller:
                                      controller.searchDropBoxController,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 8,
                                    ),
                                    hintText: 'Search for an item...',
                                    hintStyle: const TextStyle(fontSize: 12),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                              searchMatchFn: (item, searchValue) {
                                String displayedLabel = "${item.value?.name}";

                                displayedLabel = displayedLabel.toLowerCase();
                                searchValue = searchValue.toLowerCase();

                                return displayedLabel.contains(searchValue);
                              },
                            ),
                            //This to clear the search value when you close the menu
                            onMenuStateChange: (isOpen) {
                              if (!isOpen) {
                                controller.searchDropBoxController.clear();
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: size.width * 0.025,
                    right: size.width * 0.025,
                  ),
                  child: const Divider(),
                ),
                BaseTextFormField(
                  controller: controller.textEmployeeID.value,
                  prefixIcon: Icon(Icons.code,
                      color: AppColor.primaryGrey.withAlpha(
                        (0.8 * 255).round(),
                      )),
                  label: 'employee_id'.tr,
                  enabled: controller.editWorkInfo.value,
                  validateFunction: controller.emptyValidateFunc,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget personalInfomationView(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
              left: size.width * 0.05,
              right: size.width * 0.05,
              top: size.height * 0.04),
          child: Row(
            children: [
              BaseText(
                text: "personal_info".tr,
                size: 16,
              ),
              Expanded(
                child: Container(),
              ),
              Visibility(
                visible: false,
                child: Obx(
                  () => !controller.editPersonalInfo.value
                      ? InkWell(
                          onTap: () {
                            controller.editPersonalInfo.toggle();
                          },
                          child: SvgPicture.asset(
                              "assets/images/common/ic_edit_profile.svg"),
                        )
                      : Row(
                          children: [
                            InkWell(
                              onTap: () {
                                controller.editPersonalInfo.toggle();
                              },
                              child: Icon(
                                Icons.close,
                                color: AppColor.lightRed,
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.025,
                            ),
                            Icon(
                              Icons.check,
                              color: AppColor.primaryGreen,
                            ),
                          ],
                        ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              left: size.width * 0.05,
              right: size.width * 0.05,
              top: size.height * 0.0125),
          decoration: BoxDecoration(
              color: AppColor.lightPurple,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(color: Colors.black12, spreadRadius: 2, blurRadius: 4)
              ]),
          child: Column(
            children: [
              BaseTextFormField(
                controller: controller.textEmail.value,
                prefixIcon: Icon(Icons.email,
                    color: AppColor.primaryGrey.withAlpha(
                      (0.8 * 255).round(),
                    )),
                label: "email".tr,
                enabled: controller.editPersonalInfo.value,
              ),
              Container(
                margin: EdgeInsets.only(
                  left: size.width * 0.025,
                  right: size.width * 0.025,
                ),
                child: Divider(),
              ),
              BaseTextFormField(
                controller: controller.textNumberPhone.value,
                prefixIcon: Icon(Icons.phone,
                    color: AppColor.primaryGrey.withAlpha(
                      (0.8 * 255).round(),
                    )),
                label: 'phone_number'.tr,
                enabled: controller.editPersonalInfo.value,
              ),
              Container(
                margin: EdgeInsets.only(
                  left: size.width * 0.025,
                  right: size.width * 0.025,
                ),
                child: Divider(),
              ),
              BaseTextFormField(
                controller: controller.textAddress.value,
                prefixIcon: Icon(Icons.location_on,
                    color: AppColor.primaryGrey.withAlpha(
                      (0.8 * 255).round(),
                    )),
                label: 'address'.tr,
                enabled: controller.editPersonalInfo.value,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
