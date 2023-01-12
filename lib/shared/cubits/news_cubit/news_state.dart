part of 'news_cubit.dart';

@immutable
abstract class NewsState {}

class NewsInitial extends NewsState {}

// for business
/// Business Loading State
class BusinessGetLoadingState extends NewsState {
  final bool isRefresh;
  BusinessGetLoadingState({this.isRefresh = false});
}

/// Business Success GET State

class BusinessGetSuccessState extends NewsState {
  final List? data;
  BusinessGetSuccessState(this.data);
}

/// Business Failed GET State
class BusinessGetFailedState extends NewsState {
  final String error;
  BusinessGetFailedState(this.error);
}

// for Sports
/// Sports Loading State
class SportsGetLoadingState extends NewsState {
  final bool isRefresh;
  SportsGetLoadingState({this.isRefresh = false});
}

/// Sports Success GET State

class SportsGetSuccessState extends NewsState {
  final List? data;
  SportsGetSuccessState(this.data);
}

/// Sports Failed GET State
class SportsGetFailedState extends NewsState {
  final String error;
  SportsGetFailedState(this.error);
}

// for Science
/// Science Loading State
class ScienceGetLoadingState extends NewsState {
  final bool isRefresh;
  ScienceGetLoadingState({this.isRefresh = false});
}

/// Sports Success GET State

class ScienceGetSuccessState extends NewsState {
  final List? data;
  ScienceGetSuccessState(this.data);
}

/// Sports Failed GET State
class ScienceGetFailedState extends NewsState {
  final String error;
  ScienceGetFailedState(this.error);
}
