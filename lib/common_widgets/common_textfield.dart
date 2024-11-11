import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled/utils/color_constant.dart';
import 'package:untitled/utils/common_validators.dart';
import 'package:untitled/utils/size_constant.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final TextInputType? textInputType;
  final int? maxLine;
  final FocusNode? focusNode;
  final FocusNode? nextNode;
  final TextInputAction? textInputAction;
  final bool isPhoneNumber;
  final AutovalidateMode? autovalidateMode;
  final bool obscureText;
  final String? validatorMessage;
  final Color? fillColor;
  final TextCapitalization capitalization;
  final bool isBorder;
  final String? labelText;
  final Widget? suffixImage;
  final String? prefixImage;
  final TextStyle? hintstyle;
  final TextStyle? textStyle;
  final OutlineInputBorder? outlineInputBorder;
  final OutlineInputBorder? focusBorder;
  final bool readonly;
  final bool fillColorBool;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final bool? isOptional;
  final bool? isPhone;
  final bool? isPassword;
  final bool? isRupee;

  const CustomTextFormField({
    super.key,
    this.controller,
    this.hintstyle,
    this.textStyle,
    this.hintText,
    this.textInputType,
    this.maxLine,
    this.focusNode,
    this.nextNode,
    this.textInputAction,
    this.isPhoneNumber = false,
    this.fillColorBool = false,
    this.readonly = false,
    this.validator,
    this.obscureText = false,
    this.validatorMessage,
    this.capitalization = TextCapitalization.none,
    this.fillColor,
    this.isBorder = false,
    this.labelText,
    this.inputFormatters,
    this.onChanged,
    this.outlineInputBorder,
    this.focusBorder,
    this.autovalidateMode,
    this.prefixImage,
    this.onTap,
    this.suffixImage,
    this.isOptional = false,
    this.isPhone = false,
    this.isPassword = false,
    this.isRupee = false,
  });

  @override
  Widget build(context) {
    return Row(
      children: [
        Flexible(
          child: TextFormField(
            cursorColor: AppColor.buttonSecondary,
            onTap: onTap,
            readOnly: readonly,
            onChanged: onChanged,
            style: textStyle ??
                const TextStyle(
                    fontSize: FontConstant.headingFont,
                    color: AppColor.whiteColor,
                    fontWeight: FontWeight.w500),
            obscureText: obscureText,
            textAlign: isBorder ? TextAlign.center : TextAlign.start,
            controller: controller,
            maxLines: maxLine ?? 1,
            textCapitalization: capitalization,
            maxLength: isPhoneNumber ? 15 : null,
            focusNode: focusNode,
            keyboardType: textInputType ?? TextInputType.text,
            initialValue: null,
            textInputAction: textInputAction ?? TextInputAction.next,
            onFieldSubmitted: (v) {
              FocusScope.of(context).requestFocus(nextNode);
            },
            inputFormatters: inputFormatters,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onTapOutside: (event) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            validator: (value) {
              return isOptional!
                  ? null
                  : isPhone!
                      ? CommonValidators.validateMobile(value)
                      : isPassword!
                          ? CommonValidators.validatePassword(value)
                          : isRupee!
                              ? CommonValidators.validateRupee(value)
                              : CommonValidators.validateName(value, labelText);
            },
            decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                fillColor: fillColor,
                filled: fillColorBool,
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 1,
                    color: AppColor.redColor,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                contentPadding: const EdgeInsets.only(left: 10),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 1,
                    color: AppColor.redColor,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                suffixIcon: suffixImage,
                suffixIconConstraints:
                    const BoxConstraints(maxHeight: 20, minWidth: 59),
                prefixIcon: prefixImage != null
                    ? Padding(
                        padding: const EdgeInsets.only(
                            left: 10.64, top: 15, bottom: 15, right: 10.64),
                        child: Image.asset(
                          height: 10,
                          width: 10,
                          prefixImage!,
                        ),
                      )
                    : null,
                // Add prefix image
                hintText: hintText ?? '',
                hintStyle: hintstyle ??
                    const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColor.lightBlack,
                        fontSize: FontConstant.defaultFont),
                focusedBorder: focusBorder != null
                    ? OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 1, color: Colors.transparent),
                        borderRadius: BorderRadius.circular(12),
                      )
                    : null,
                errorStyle: const TextStyle(fontWeight: FontWeight.bold),
                enabledBorder: outlineInputBorder != null
                    ? OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 1, color: Colors.transparent),
                        borderRadius: BorderRadius.circular(12),
                      )
                    : null),
          ),
        ),
      ],
    );
  }
}
