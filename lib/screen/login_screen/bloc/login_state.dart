part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

class ShowPwdState extends LoginState {
  final bool showPwd;

  ShowPwdState({required this.showPwd});
}
