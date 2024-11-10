part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class ShowPassEvent extends LoginEvent {
  final bool showPwd;

  ShowPassEvent({required this.showPwd});
}
