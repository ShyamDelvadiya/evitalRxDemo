import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:untitled/utils/pref_constants.dart';
import 'package:untitled/utils/preference_utils.dart';
import 'package:untitled/utils/string_constants.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>(_mapEventToState);
  }

  FutureOr<void> _mapEventToState(
      LoginEvent event, Emitter<LoginState> emit) async {
    if (event is ShowPassEvent) {
      emit(ShowPwdState(showPwd: event.showPwd));
    } else if (event is LoginButtonOnPressedEvent) {
      emit(LoginLoadingState());
      await Future.delayed(const Duration(seconds: 3));

      if ((event.mobileNumber == StringConstant.mobileNumber) &&
          (event.password == StringConstant.password)) {
        await setBool(PrefConstants.isUserLoggedIn, true);
        emit(LoginSuccessState(successMsg: 'Login Successful'));
      } else {
        emit(LoginErrorState(error: StringConstant.loginErrorMsg));
      }
    }
  }
}
