import 'package:app_work_log/common/widgets/base_button.dart';
import 'package:app_work_log/common/widgets/base_dialog.dart';
import 'package:app_work_log/common/widgets/base_dialog_confirm.dart';
import 'package:app_work_log/common/widgets/base_text.dart';
import 'package:app_work_log/common/widgets/base_text_form_field.dart';
import 'package:app_work_log/modules/department_manage/controllers/department_manage_controller.dart';
import 'package:app_work_log/modules/department_manage/model/employee_company.dart';
import 'package:app_work_log/themes/app_color.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class PopupDetailDepartment extends GetView<DepartmentManageController> {
  const PopupDetailDepartment({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Form(
      key: controller.formKey,
      child: Container(
        padding: EdgeInsets.all(size.width * 0.025),
        height: size.height * 0.42,
        width: size.width,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: size.width,
                  margin: EdgeInsets.only(top: size.height * 0.025),
                  child: BaseText(
                    text: "department_manage".tr,
                    isTile: true,
                    size: 18,
                  ),
                ),
                Positioned(
                  right: 0,
                  child: Container(
                    margin: EdgeInsets.only(top: size.height * 0.025),
                    child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(Icons.close)),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(
                  top: size.height * 0.05,
                  right: size.width * 0.05,
                  left: size.width * 0.05),
              decoration: BoxDecoration(
                  color: AppColor.lightPurple,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12, spreadRadius: 2, blurRadius: 4)
                  ]),
              child: Column(
                children: [
                  BaseTextFormField(
                    controller: controller.textDepartment.value,
                    prefixIcon: Container(
                        margin: EdgeInsets.all(size.width * 0.04),
                        child: SvgPicture.asset(
                            "assets/images/manage/ic_department_textfield.svg")),
                    label: "department".tr,
                    validateFunction: controller.emptyValidateFunc,
                  ),
                  Divider(),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            left: size.width * 0.05, right: size.width * 0.05),
                        child: SvgPicture.asset(
                            "assets/images/manage/ic_manager_textfield.svg"),
                      ),
                      Obx(
                        () => Expanded(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2<EmployeeCompany>(
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
                              items: controller.listEmployee
                                  .map((item) => DropdownMenuItem(
                                        value: item,
                                        child: Text(
                                          item.firstName == null ||
                                                  item.lastName == null
                                              ? ""
                                              : "${item.employeeCode} - ${item.firstName} ${item.lastName}",
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  controller.updateSelectedManager(value);
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
                                      contentPadding:
                                          const EdgeInsets.symmetric(
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
                                  String displayedLabel =
                                      "${item.value?.firstName} ${item.value?.lastName}";

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
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: size.height * 0.025),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      controller.validateAndSaveEnroll();
                    },
                    child: BaseButton(
                      height: size.height * 0.06,
                      width: size.width * 0.4,
                      title: "save".tr,
                      iconLeft: SizedBox(
                          height: size.width * 0.06,
                          width: size.width * 0.06,
                          child: SvgPicture.asset(
                              "assets/images/manage/ic_save.svg")),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.05,
                  ),
                  InkWell(
                    onTap: () async {
                      Get.dialog(
                        BaseDialogConfirm(
                            title: "content_title_confirm_delete".tr,
                            clickCancel: () {
                              Get.back();
                              Get.back();
                            },
                            clickConfirm: () async {
                              Get.back();
                              Get.back();
                              if (await controller.deleteShift()) {
                                BaseDialog.getBaseDialog(
                                    context: Get.context!,
                                    title: "success".tr,
                                    desc: "success".tr,
                                    dialogType: DialogType.success,
                                    buttonColor: AppColor.primaryGreen,
                                    textColor: AppColor.primaryGreen);
                                controller.getEmployee();
                                controller.getListDepartment();
                              } else {
                                BaseDialog.getBaseDialog(
                                    context: Get.context!,
                                    title: "error".tr,
                                    desc: "error".tr,
                                    dialogType: DialogType.error,
                                    buttonColor: AppColor.lightRed,
                                    textColor: AppColor.lightRed);
                              }
                            }),
                      );
                    },
                    child: BaseButton(
                      height: size.height * 0.06,
                      width: size.width * 0.4,
                      title: "delete".tr,
                      colorBegin: AppColor.primaryPink,
                      colorEnd: AppColor.primaryPink.withAlpha(
                        (0.7 * 255).round(),
                      ),
                      iconLeft: SizedBox(
                          height: size.width * 0.06,
                          width: size.width * 0.06,
                          child: SvgPicture.asset(
                              "assets/images/manage/ic_inactive_staff.svg")),
                      fontWeight: FontWeight.w700,
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
