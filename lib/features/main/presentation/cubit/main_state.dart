abstract class MainState {}

class MainInitial extends MainState {
  final int index;

  MainInitial(this.index);
}

class MainTabChanged extends MainState {
  final int index;

  MainTabChanged(this.index);
}