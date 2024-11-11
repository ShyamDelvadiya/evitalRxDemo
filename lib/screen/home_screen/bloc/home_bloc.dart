import 'dart:async';


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/screen/home_screen/models/user_model.dart';
import 'package:untitled/service/hive_service.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final hiveService = HiveService();
  List<UserModel> userList = [];

  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>(_mapEventToState);
  }

  FutureOr<void> _mapEventToState(
      HomeEvent event, Emitter<HomeState> emit) async {
    if (event is LoadUsersEvent) {
      emit(UserLoadingState());
      await Future.delayed(const Duration(seconds: 2));
      userList = hiveService.userBox.values.toList();
      emit(UserLoadedState(users: userList));
    } else if (event is UpdateRupeeEvent) {
      event.user.rupee = event.newRupee;
      await event.user.save();
      userList = hiveService.userBox.values.toList();
      emit(UserLoadedState(users: userList));
    } else if (event is FilterUsersEvent) {
      emit(UserLoadingState());
      await Future.delayed(const Duration(milliseconds: 700));

      final query = event.query.toLowerCase();
      final filteredUsersList = userList.where(
        (user) {
          final nameMatch = user.name.toLowerCase().contains(query);
          final phoneMatch = user.phone.contains(query);
          final cityMatch = user.city.toLowerCase().contains(query);
          return nameMatch || phoneMatch || cityMatch;
        },
      ).toList();

      emit(UserLoadedState(users: filteredUsersList));
    }
  }
}
