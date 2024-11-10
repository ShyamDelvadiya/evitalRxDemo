import 'package:flutter/material.dart';
import 'package:untitled/common_widgets/common_button.dart';
import 'package:untitled/common_widgets/common_textfield.dart';
import 'package:untitled/utils/color_constant.dart';
import 'package:untitled/utils/image_constants.dart';
import 'package:untitled/utils/size_constant.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = false;

  @override
  Widget build(BuildContext context) {
    return _mainView(context);
  }

  Widget _mainView(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.blackColor,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            child: Image.asset(
              Images.bottomBackground,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Positioned(
            bottom: 0,
            child: Image.asset(
              Images.homeBackground,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 29, right: 29, top: 00),
            child: Form(
              key: _formKey,
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 30, top: 0),
                      child: Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: AppColor.whiteColor),
                      ),
                    ),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadiusConstant.radius,
                          color: AppColor.suggestionColor2),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15, bottom: 0),
                        child: Center(
                          child: CustomTextFormField(
                            hintText: 'Enter Your Username',
                            controller: email,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadiusConstant.radius,
                            color: AppColor.suggestionColor2),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, bottom: 0),
                          child: Center(
                            child: CustomTextFormField(
                              obscureText: _obscureText,
                              suffixImage: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                                child: Icon(
                                  _obscureText
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: AppColor.whiteColor,
                                ),
                              ),
                              hintText: 'Enter Your Password',
                              validator: (p0) {
                                return null;
                              },
                              controller: password,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: CustomButton(
                        onPressed: () {},
                        text: 'Login',
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
