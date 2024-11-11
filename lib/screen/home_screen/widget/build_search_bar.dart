import 'package:flutter/material.dart';
import 'package:untitled/common_widgets/common_textfield.dart';
import 'package:untitled/utils/color_constant.dart';
import 'package:untitled/utils/common_helpers.dart';
import 'package:untitled/utils/string_constants.dart';

class BuildSearchBar extends StatelessWidget {
  const BuildSearchBar({super.key,
    required this.searchController,
    this.filterUsersListCallBack});

  final TextEditingController searchController;
  final Function(String query)? filterUsersListCallBack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomTextFormField(
        controller: searchController,
        // isBorder: true,
        isOptional: true,
        fillColorBool: true,
        fillColor: AppColor.whiteColor.withOpacity(.1),
        hintstyle: TextStyle(
            color: AppColor.whiteColor.withOpacity(.5)
        ),
        hintText: StringConstant.filterSearchTitle,
        suffixImage: const Icon(Icons.search, color: AppColor.whiteColor,),
        onChanged: (query) {
          timerCommonFunction(
            query,
                () {
              filterUsersListCallBack?.call(query);
            },
          );
        },
      ),
    );
  }
}
