import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:igdb_games/features/game/data/models/game_model.dart';
import 'package:igdb_games/features/game/domain/repositories/igame_repository.dart';

part 'game_details_event.dart';
part 'game_details_state.dart';

class GameDetailsBloc extends Bloc<GameDetailsEvent, GameDetailsState> {
  final IGameRepository _gameRepository;

  GameDetailsBloc(this._gameRepository) : super(GameDetailsPendingState()) {
    on<LoadRelatedGameListEvent>((event, emit) async {
      emit(GameDetailsPendingState());
      try {
        final response = await _gameRepository.getGames(page: 1, inIds: event.ids);
        if (response.isNotEmpty) {
          emit(GameDetailsLoadedState(similarGames: response));
        } else {
          emit(GameDetailsEmptyState());
        }
      } catch (e) {
        emit(const GameDetailsRejectedState(message: 'Error'));
      }
    });
  }
}
