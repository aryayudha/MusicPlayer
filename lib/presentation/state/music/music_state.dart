part of 'music_cubit.dart';

@immutable
abstract class MusicState extends Equatable{
  const MusicState();

  @override
  List<Object?> get props => [];
}

class MusicInitial extends MusicState {}

class MusicLoading extends MusicState {}

class MusicResult extends MusicState {
  final List<Artist> res;

  const MusicResult(this.res);
}

class MusicEmpty extends MusicState {}