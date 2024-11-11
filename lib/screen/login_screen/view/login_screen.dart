import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/common_widgets/common_bottom_background.dart';
import 'package:untitled/common_widgets/common_button.dart';
import 'package:untitled/common_widgets/common_home_background.dart';
import 'package:untitled/common_widgets/common_textfield.dart';
import 'package:untitled/route/route_path.dart';
import 'package:untitled/screen/login_screen/bloc/login_bloc.dart';
import 'package:untitled/utils/color_constant.dart';
import 'package:untitled/utils/dialog_utils.dart';
import 'package:untitled/utils/size_constant.dart';
import 'package:untitled/utils/string_constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = false;
  LoginBloc? bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc = context.read<LoginBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return _mainView(context);
  }

  Widget _mainView(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.blackColor,
      body: _body(context),
    );
  }

  Widget _body(context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, currentState) {
        if (currentState is LoginLoadingState) {
          DialogUtils.showLoader(context);
        } else if (currentState is LoginSuccessState) {
          DialogUtils.hideLoader(context);
          DialogUtils.showMessage(context, currentState.successMsg.toString());
          Navigator.pushNamedAndRemoveUntil(
            context,
            homeScreen,
            (route) => false,
          );
        } else if (currentState is LoginErrorState) {
          DialogUtils.hideLoader(context);
          DialogUtils.showErrorMessage(context, currentState.error.toString());
        }
      },
      child: Stack(
        children: [
          const CommonHomeBackground(),
          const CommonBottomBackground(),
          Padding(
            padding: const EdgeInsets.only(
              left: PaddingConstant.maximumPadding,
              right: PaddingConstant.maximumPadding,
            ),
            child: Form(
              key: _formKey,
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
                              _obscureText = !currentState.showPwd;
                            }
                            return CustomTextFormField(
                              obscureText: _obscureText,
                              fillColorBool: true,
                              fillColor: AppColor.grey,
                              suffixImage: GestureDetector(
                                onTap: () {
                                  bloc?.add(
                                      ShowPassEvent(showPwd: _obscureText));
                                },
                                child: Icon(
                                  _obscureText
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
                      padding: const EdgeInsets.only(top: 15),
                      child: CustomButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            bloc?.add(LoginButtonOnPressedEvent(
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
          ),
        ],
      ),
    );
  }
}
