import 'package:flutter/material.dart';
import 'package:untitled/utils/color_constant.dart';
import 'package:untitled/utils/image_constants.dart';
import 'package:untitled/utils/size_constant.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subtitle; // Add a subtitle property
  final bool showLeading;
  final bool centerTitle;

  const CustomAppBar({super.key,
    required this.title,
    this.subtitle, // Initialize the subtitle
    this.showLeading = true,
    this.centerTitle = true,
  });

  @override
  Size get preferredSize => const Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      centerTitle: centerTitle,
      scrolledUnderElevation: 0,
      backgroundColor: AppColor.blackColor,
      title: centerTitle
          ? Image.asset(
        Images.appBarLogo,
        height: 40,
        width: 149,
      )
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            Images.appBarLogo,
            height: 40,
            width: 149,
          ),
          if (subtitle != null)
            Text(
              subtitle!,
              style: const TextStyle(
                color: AppColor.buttonSecondary,
                fontSize: FontConstant.headingFont,
                fontWeight: FontWeight.w400,
              ),
            ),
        ],
      ),
      leading: showLeading
          ? Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
      )
          : const SizedBox(),
    );
  }
}