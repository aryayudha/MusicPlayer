part of 'player_cubit.dart';

@immutable
abstract class PlayerState {}

class PlayerInitial extends PlayerState {}

class PlayerOnPlay extends PlayerState {
  final Artist songSelected;
  final int index;

  PlayerOnPlay(this.index, this.songSelected);
}

class PlayerOnStop extends PlayerState {}

class PlayerOnPrev extends PlayerState {}

class PlayerOnNext extends PlayerState {}
