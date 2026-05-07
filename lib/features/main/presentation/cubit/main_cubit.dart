import 'package:flutter_bloc/flutter_bloc.dart';
import 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial(0));

  int currentIndex = 0;

  void changeTab(int index) {
    currentIndex = index;
    emit(MainTabChanged(index));
  }
}