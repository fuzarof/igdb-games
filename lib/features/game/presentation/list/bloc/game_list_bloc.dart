import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:igdb_games/features/game/data/models/game_model.dart';
import 'package:igdb_games/features/game/domain/repositories/igame_repository.dart';

part 'game_list_event.dart';
part 'game_list_state.dart';

class GameListBloc extends Bloc<GameListEvent, GameListState> {
  final IGameRepository _gameRepository;

  GameListBloc(this._gameRepository) : super(GameListEmptyState()) {
    on<GameListEvent>((event, emit) async {
      emit(GameListPendingState());
      try {
        final response = await _gameRepository.getGames();
        emit(GameListLoadedState(games: response));
      } catch (e) {
        emit(const GameListRejectedState(message: 'Error'));
      }
    });
  }
}
