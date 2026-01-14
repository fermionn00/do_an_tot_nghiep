import 'package:app_work_log/common/widgets/base_text.dart';
import 'package:app_work_log/modules/department_manage/controllers/department_manage_controller.dart';
import 'package:app_work_log/modules/department_manage/widgets/bottom_input_name_csv.dart';
import 'package:app_work_log/modules/department_manage/widgets/item_department.dart';
import 'package:app_work_log/modules/department_manage/widgets/popup_add_departmant.dart';
import 'package:app_work_log/modules/department_manage/widgets/popup_detail_departmant.dart';
import 'package:app_work_log/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DepartmentManageView extends GetView<DepartmentManageController> {
  const DepartmentManageView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            height: size.height,
            width: size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/images/common/img_bg_2.png",
                ),
                fit: BoxFit.fill,
              ),
            ),
            child: SafeArea(
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
                            )),
                        Expanded(
                          child: BaseText(
                            text: "department_manage".tr,
                            isTile: true,
                            size: 24,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            controller.textNameFileCsv.value.text = "";
                            Get.bottomSheet(BottomInputNameCsv());
                          },
                          child: SvgPicture.asset(
                              "assets/images/common/ic_export_csv.svg"),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: size.height * 0.06,
                    width: size.width,
                    margin: EdgeInsets.only(
                      top: size.height * 0.0125,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.colorBackgroundTitleTable,
                    ),
                    child: Row(children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: size.width * 0.05),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              BaseText(
                                text: "name_department".tr,
                                isTile: true,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: size.width * 0.05),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              BaseText(
                                text: "manager_department".tr,
                                isTile: true,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
                  ),
                  Obx(
                    () => Expanded(
                      child: (controller.listDepartment.length == 1 &&
                              controller.listDepartment[0].id == -1)
                          ? Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColor.primaryPurple),
                              ),
                            )
                          : ListView.builder(
                              itemCount: controller.listDepartment.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    controller.chooseItemDepartment(index,
                                        controller.listDepartment[index]);
                                    Get.bottomSheet(
                                      isScrollControlled: true,
                                      PopupDetailDepartment(),
                                    );
                                  },
                                  child: ItemDepartment(
                                    item: controller.listDepartment[index],
                                  ),
                                );
                              },
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: size.width * 0.05,
            right: size.width * 0.05,
            child: InkWell(
              onTap: () {
                controller.refreshInput();
                Get.bottomSheet(
                  isScrollControlled: true,
                  PopupAddDepartment(),
                );
              },
              child: SizedBox(
                height: size.width * 0.13,
                width: size.width * 0.13,
                child: SvgPicture.asset("assets/images/manage/ic_add.svg"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
