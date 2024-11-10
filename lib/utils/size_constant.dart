import 'package:flutter/material.dart';

class SizeConstant {
  static const double imageSize = 50.0;
  static const double borderRadiusSize = 10.0;
  static const double borderRadiusMaxSize = 30.0;
  static const double buttonSize = 50.0;
  static const double appBarLeadingButtonSize = 18.0;
}

class BorderRadiusConstant {
  static BorderRadius borderRadiusSize = BorderRadius.circular(10);
  static BorderRadius borderRadiusMediumSize = BorderRadius.circular(18);
  static BorderRadius borderRadiusMaxSize = BorderRadius.circular(25);
  static BorderRadius radius  = BorderRadius.circular(30);
}

class PaddingConstant {
  static const double widgetPaddingSmall = 5.0;
  static const double genericPadding = 8.0;
  static const double widgetPadding = 10.0;
  static const double mainPagePadding = 15.0;
  static const double mainPagePadding18 = 18.0;
  static const double mediumPadding = 20.0;
  static const double medium25Padding = 25.0;
  static const double maximumPadding = 30.0;
  static const double extraMaximumPadding = 40.0;

  static SizedBox verticalSpace({double? height = 10}) {
    return SizedBox(
      height: height,
    );
  }

  static SizedBox horizontalSpace({double? height = 10}) {
    return SizedBox(
      width: height,
    );
  }
}

class FontConstant {
  static const double extraSmallFont = 10.0;
  static const double smallFont = 12.0;
  static const double defaultFont = 14.0;
  static const double mediumFont = 15.0;
  static const double headingFont = 16.0;
  static const double bigFont = 18.0;
  static const double extraBigFont = 20.0;
  static const double extraBigFont23 = 23.0;
  static const double maxBigFont = 25.0;
  static const double appBarFontSize = 16.0;
}
