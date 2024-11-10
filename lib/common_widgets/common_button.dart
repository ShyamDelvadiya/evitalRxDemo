import 'package:flutter/material.dart';
import 'package:untitled/utils/color_constant.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double height;
  final double? width;
  final Color? color;
  final Color? textcolor;
  final double? fontsize;
  final BorderRadius borderRadius;
  final void Function()? onTap;

  CustomButton({
    required this.text,
    this.color = (AppColor.buttonSecondary),
    this.textcolor = (AppColor.whiteColor),
    this.onTap,
    this.fontsize = (16.33),
    required this.onPressed,
    this.height = 51,
    this.width,
    this.borderRadius = const BorderRadius.all(Radius.circular(16.33)),
  });

  @override
  Widget build(BuildContext context) {

    return InkWell(
      splashFactory: NoSplash.splashFactory,
      onTap: onTap,
      child: Container(
        height: height,
        width: width ?? MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: color,
        ),
        child: TextButton(
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(
              color: textcolor,
              fontSize: fontsize,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}