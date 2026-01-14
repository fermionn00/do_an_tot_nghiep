import 'package:app_work_log/common/widgets/base_text.dart';
import 'package:app_work_log/themes/app_color.dart';
import 'package:flutter/material.dart';

class BaseCardStatistics extends StatelessWidget {
  final double? height;
  final double? width;
  final Widget? icon;
  final String? text;
  final double? sizeText;
  final Color? colorText;
  final String? value;
  final double? sizeValue;
  final Color? colorValue;
  final double? spaceVertical;
  final double? spaceHorizontal;
  final Color? beginColor;
  final Color? endColor;
  final double? borderRadius;
  final Alignment? beginVecter;
  final Alignment? endVecter;
  final double? lengthBegin;
  final double? lengthEnd;

  const BaseCardStatistics(
      {super.key,
      this.height,
      this.width,
      this.icon,
      this.text,
      this.sizeText,
      this.colorText,
      this.value,
      this.sizeValue,
      this.colorValue,
      this.spaceVertical,
      this.spaceHorizontal,
      this.beginColor,
      this.endColor,
      this.borderRadius,
      this.beginVecter,
      this.endVecter,
      this.lengthBegin,
      this.lengthEnd});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Column(
      children: [
        Container(
          height: height ?? size.height * 0.12,
          width: width ?? size.width * 0.4,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: beginVecter ?? Alignment.topCenter,
              end: endVecter ?? Alignment.bottomCenter,
              colors: [
                beginColor ?? AppColor.primaryBlue
                  ..withAlpha(
                    (0.9 * 255).round(),
                  ),
                endColor ?? AppColor.primaryPurple
                  ..withAlpha(
                    (0.9 * 255).round(),
                  ),
              ],
              stops: [lengthBegin ?? 0.1, lengthEnd ?? 0.9],
            ),
            borderRadius: BorderRadius.circular(borderRadius ?? 16),
          ),
          child: Stack(
            children: [
              Positioned(
                top: spaceVertical ?? size.width * 0.02,
                left: spaceHorizontal ?? size.width * 0.035,
                child: icon ?? SizedBox(),
              ),
              Positioned(
                top: spaceVertical ?? size.width * 0.02,
                right: spaceHorizontal ?? size.width * 0.035,
                child: BaseText(
                  text: value,
                  colorText: colorValue ?? Colors.white,
                  isTile: true,
                  size: sizeValue ?? 24,
                ),
              ),
              Positioned(
                bottom: spaceVertical ?? size.width * 0.02,
                left: spaceHorizontal ?? size.width * 0.035,
                child: BaseText(
                  text: text,
                  colorText: colorText ?? Colors.white,
                  size: sizeText ?? 18,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
