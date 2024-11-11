import 'package:flutter/material.dart';
import 'package:untitled/utils/image_constants.dart';

class CommonHomeBackground extends StatelessWidget {
  const CommonHomeBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return  Positioned(
      top: 0,
      child: Image.asset(
        Images.homeBackground,
        width: MediaQuery.of(context).size.width,
      ),
    );
  }
}
