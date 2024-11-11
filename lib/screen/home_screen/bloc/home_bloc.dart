import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/screen/home_screen/models/user_model.dart';
import 'package:untitled/service/hive_service.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final hiveService = HiveService();
  List<UserModel> userList = [];
  String? _lastQuery;
  bool isPageLoading= false;

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
      // Check if there's a last query to filter by
      if (_lastQuery != null && _lastQuery!.isNotEmpty) {
        final filteredUsersList = userList.where(
          (user) {
            final nameMatch = user.name.toLowerCase().contains(_lastQuery!);
            final phoneMatch = user.phone.contains(_lastQuery!);
            final cityMatch = user.city.toLowerCase().contains(_lastQuery!);
            return nameMatch || phoneMatch || cityMatch;
          },
        ).toList();
        emit(UserFilteredState(filteredUsersList));
      } else {
        emit(UserLoadedState(users: userList));
      }
    } else if (event is FilterUsersEvent) {
      emit(UserLoadingState());
      await Future.delayed(const Duration(milliseconds: 700));

      final query = event.query.toLowerCase();
      _lastQuery = event.query.toLowerCase();

      final filteredUsersList = userList.where(
        (user) {
          final nameMatch = user.name.toLowerCase().contains(query);
          final phoneMatch = user.phone.contains(query);
          final cityMatch = user.city.toLowerCase().contains(query);
          return nameMatch || phoneMatch || cityMatch;
        },
      ).toList();
      emit(UserFilteredState(filteredUsersList));
    } else if (event is LoadMoreUsersEvent) { // New event for loading more users
      if (!isPageLoading) {
        isPageLoading = true;
        emit(UserPageLoadingState(users: userList)); // Emit loading state with current data
        await Future.delayed(const Duration(seconds: 2));
        final newUsers = hiveService.userBox.values.toList();
        userList.addAll(newUsers);
        isPageLoading = false;
        emit(UserLoadedState(users: userList));
      }
    }
  }
}
