import 'package:app_work_log/themes/app_color.dart';
import 'package:flutter/material.dart';

class BaseButton extends StatelessWidget {
  final double? height;
  final double? width;
  final bool? isIcon;
  final String? title;
  final Color? textColor;
  final double? fontSize;
  final double? verticalPadding;
  final double? horizontalPadding;
  final double? borderRadius;
  final Color? colorBegin;
  final Color? colorEnd;
  final FontWeight? fontWeight;
  final Widget? iconLeft;
  final Color? colorIconLeft;
  final double? widthBorder;

  const BaseButton(
      {super.key,
      required this.height,
      required this.width,
      this.isIcon,
      required this.title,
      this.textColor,
      this.fontSize,
      this.verticalPadding,
      this.horizontalPadding,
      this.borderRadius,
      this.colorBegin,
      this.colorEnd,
      this.fontWeight,
      this.iconLeft,
      this.colorIconLeft,
      this.widthBorder});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            colorBegin ?? AppColor.primaryBlue
              ..withAlpha(
                (0.9 * 255).round(),
              ),
            colorEnd ?? AppColor.primaryPurple
              ..withAlpha(
                (0.9 * 255).round(),
              ),
          ],
          stops: const [0.1, 0.9],
        ),
        borderRadius: BorderRadius.circular(borderRadius ?? 8),
        border: Border.all(
            color: widthBorder != null
                ? AppColor.primaryBlue.withAlpha(
                    (0.9 * 255).round(),
                  )
                : Colors.white,
            width: widthBorder ?? 0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding ?? 0, vertical: verticalPadding ?? 0),
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DefaultTextStyle(
                  style: const TextStyle(),
                  child: Text(
                    title!,
                    style: TextStyle(
                        color: textColor ?? Colors.white,
                        fontSize: fontSize ?? 13,
                        fontWeight: fontWeight ?? FontWeight.normal),
                  ),
                ),
                isIcon ?? false
                    ? Icon(Icons.arrow_forward_ios_rounded,
                        color: textColor, size: fontSize)
                    : Container(),
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: size.width * 0.025),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconLeft ?? Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
