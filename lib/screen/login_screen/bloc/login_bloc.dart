import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>(_mapEventToState);
  }

  FutureOr<void> _mapEventToState(LoginEvent event, Emitter<LoginState> emit) {
    if (event is ShowPassEvent) {
      emit(ShowPwdState(showPwd: event.showPwd));
    }
  }
}
