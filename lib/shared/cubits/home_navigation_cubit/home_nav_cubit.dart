import 'package:bloc/bloc.dart';

/// Navigation Integer Index Cubit
class HomeNavCubit extends Cubit<int> {
  HomeNavCubit() : super(0);
  @override

  /// Getting Current Index
  int get state => super.state;

  /// Setting New Index
  setIndex(int newState) => emit(newState);
}
