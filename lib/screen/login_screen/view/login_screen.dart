import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/common_widgets/common_bottom_background.dart';
import 'package:untitled/common_widgets/common_home_background.dart';
import 'package:untitled/route/route_path.dart';
import 'package:untitled/screen/login_screen/bloc/login_bloc.dart';
import 'package:untitled/screen/login_screen/widget/login_container.dart';
import 'package:untitled/utils/color_constant.dart';
import 'package:untitled/utils/dialog_utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
      child: const Stack(
        children: [
          CommonHomeBackground(),
          CommonBottomBackground(),
          LoginContainer()
        ],
      ),
    );
  }
}
