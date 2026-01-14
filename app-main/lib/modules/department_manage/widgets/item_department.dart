import 'package:app_work_log/common/widgets/base_text.dart';
import 'package:app_work_log/modules/department_manage/model/department_manager.dart';
import 'package:flutter/material.dart';

class ItemDepartment extends StatelessWidget {
  final DepartmentManage item;
  const ItemDepartment({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(size.width * 0.025),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: size.width * 0.025,),
                  child: Row(
                    children: [
                      BaseText(
                        text: item.name,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: size.width * 0.05,),
                  child: Row(
                    children: [
                      BaseText(
                        text: item.managerInfo == null ? "" : item.managerInfo!.firstName == null || item.managerInfo!.firstName == null ? "No Name" : "${item.managerInfo!.firstName} ${item.managerInfo!.lastName!}",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}
