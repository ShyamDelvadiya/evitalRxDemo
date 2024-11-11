part of 'home_bloc.dart';

sealed class HomeEvent {}

class LoadUsersEvent extends HomeEvent {}

class UpdateRupeeEvent extends HomeEvent {
  final UserModel user;
  final int newRupee;

  UpdateRupeeEvent(this.user, this.newRupee);
}

class FilterUsersEvent extends HomeEvent {
  final String query;

  FilterUsersEvent(this.query);
}
class LoadMoreUsersEvent extends HomeEvent {

  LoadMoreUsersEvent();
}
