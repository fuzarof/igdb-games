part of 'game_details_bloc.dart';

abstract class GameDetailsState extends Equatable {
  const GameDetailsState();

  @override
  List<Object> get props => [];
}

class GameDetailsEmptyState extends GameDetailsState {}

class GameDetailsPendingState extends GameDetailsState {}

class GameDetailsPendingMoreState extends GameDetailsState {}

class GameDetailsLoadedState extends GameDetailsState {
  // final List<Game> games;

  // const GameDetailsLoadedState({required this.games});

  // @override
  // List<Object> get props => [games];
}

class GameDetailsRejectedState extends GameDetailsState {
  final String message;

  const GameDetailsRejectedState({required this.message});

  @override
  List<Object> get props => [message];
}
