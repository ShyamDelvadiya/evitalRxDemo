part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

class ShowPwdState extends LoginState {
  final bool showPwd;

  ShowPwdState({required this.showPwd});
}

class LoginLoadingState extends LoginState {
  LoginLoadingState();
}

class LoginSuccessState extends LoginState {
  final String? successMsg;

  LoginSuccessState({this.successMsg});
}

class LoginErrorState extends LoginState {
  final String? error;

  LoginErrorState({this.error});
}
