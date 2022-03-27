import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'game_details_event.dart';
part 'game_details_state.dart';

class GameDetailsBloc extends Bloc<GameDetailsEvent, GameDetailsState> {
  GameDetailsBloc() : super(GameDetailsPendingState()) {
    on<GameDetailsEvent>((event, emit) {});
  }
}
