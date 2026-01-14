import 'package:app_work_log/common/widgets/base_text.dart';
import 'package:app_work_log/modules/shift_manage/model/shift.dart';
import 'package:flutter/material.dart';

class ItemShift extends StatelessWidget {
  final ShiftManager item;
  const ItemShift({super.key, required this.item});

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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: size.width * 0.025,),
                      child: BaseText(
                        text: item.name,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: BaseText(
                          text: item.timeStart,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: BaseText(
                          text: item.timeEnd,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Divider(),
      ],
    );
  }
}
