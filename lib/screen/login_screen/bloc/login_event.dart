part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class ShowPassEvent extends LoginEvent {
  final bool showPwd;

  ShowPassEvent({required this.showPwd});
}

class LoginButtonOnPressedEvent extends LoginEvent {
  final String? mobileNumber;
  final String? password;

  LoginButtonOnPressedEvent({this.mobileNumber, this.password});
}
