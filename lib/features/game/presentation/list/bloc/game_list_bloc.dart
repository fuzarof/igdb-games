import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:igdb_games/features/game/data/models/game_model.dart';
import 'package:igdb_games/features/game/domain/repositories/igame_repository.dart';

part 'game_list_event.dart';
part 'game_list_state.dart';

class GameListBloc extends Bloc<GameListEvent, GameListState> {
  final IGameRepository _gameRepository;

  GameListBloc(this._gameRepository) : super(GameListEmptyState()) {
    on<LoadGameListEvent>((event, emit) async {
      if (event.page == 1) {
        emit(GameListPendingState());
      } else {
        emit(GameListPendingMoreState());
      }
      try {
        final response = await _gameRepository.getGames(search: event.search, page: event.page);
        emit(GameListLoadedState(games: response));
      } catch (e) {
        emit(const GameListRejectedState(message: 'Error'));
      }
    });
  }
}
