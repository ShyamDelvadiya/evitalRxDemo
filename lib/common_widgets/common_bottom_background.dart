import 'package:flutter/material.dart';
import 'package:untitled/utils/image_constants.dart';

class CommonBottomBackground extends StatelessWidget {
  const CommonBottomBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Image.asset(
        Images.bottomBackground,
        width: MediaQuery.of(context).size.width,
      ),
    );
  }
}
