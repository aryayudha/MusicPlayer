
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:musicplayer_fita/domain/entities/artist.dart';

part 'player_state.dart';

class PlayerCubit extends Cubit<PlayerState> {

  PlayerCubit() : super(PlayerInitial());

}
