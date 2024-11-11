import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/common_widgets/common_button.dart';
import 'package:untitled/common_widgets/common_textfield.dart';
import 'package:untitled/screen/login_screen/bloc/login_bloc.dart';
import 'package:untitled/utils/color_constant.dart';
import 'package:untitled/utils/size_constant.dart';
import 'package:untitled/utils/string_constants.dart';

class LoginContainer extends StatelessWidget {
  const LoginContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    bool obscureText = false;
    LoginBloc? bloc = context.read<LoginBloc>();
    TextEditingController mobileNumberController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.only(
        left: PaddingConstant.maximumPadding,
        right: PaddingConstant.maximumPadding,
      ),
      child: Form(
        key: formKey,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(
                    bottom: PaddingConstant.maximumPadding, top: 0),
                child: Text(
                  StringConstant.login,
                  style: TextStyle(
                      fontSize: FontConstant.maxBigFont,
                      fontWeight: FontWeight.bold,
                      color: AppColor.whiteColor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: PaddingConstant.mainPagePadding,
                    bottom: 0,
                    right: PaddingConstant.mainPagePadding),
                child: Center(
                  child: CustomTextFormField(
                      hintText: StringConstant.mobileNumberHintTxt,
                      controller: mobileNumberController,
                      fillColorBool: true,
                      fillColor: AppColor.grey,
                      isPhone: true,
                      textInputType: TextInputType.phone),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: PaddingConstant.mainPagePadding,
                  bottom: 0,
                  top: PaddingConstant.mainPagePadding,
                  right: PaddingConstant.mainPagePadding,
                ),
                child: Center(
                  child: BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, currentState) {
                      if (currentState is ShowPwdState) {
                        obscureText = !currentState.showPwd;
                      }
                      return CustomTextFormField(
                        obscureText: obscureText,
                        fillColorBool: true,
                        fillColor: AppColor.grey,
                        suffixImage: GestureDetector(
                          onTap: () {
                            bloc.add(ShowPassEvent(showPwd: obscureText));
                          },
                          child: Icon(
                            obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: AppColor.whiteColor,
                          ),
                        ),
                        hintText: StringConstant.passwordHintTxt,
                        isPassword: true,
                        controller: passwordController,
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: PaddingConstant.mainPagePadding),
                child: CustomButton(
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? false) {
                      bloc.add(LoginButtonOnPressedEvent(
                          mobileNumber: mobileNumberController.text,
                          password: passwordController.text));
                    }
                  },
                  text: StringConstant.login,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}