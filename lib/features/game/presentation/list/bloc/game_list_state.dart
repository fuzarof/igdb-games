part of 'game_list_bloc.dart';

abstract class GameListState extends Equatable {
  const GameListState();

  @override
  List<Object> get props => [];
}

class GameListEmptyState extends GameListState {}

class GameListPendingState extends GameListState {}

class GameListLoadedState extends GameListState {
  final List<Game> games;

  const GameListLoadedState({required this.games});

  @override
  List<Object> get props => [games];
}

class GameListRejectedState extends GameListState {
  final String message;

  const GameListRejectedState({required this.message});

  @override
  List<Object> get props => [message];
}
