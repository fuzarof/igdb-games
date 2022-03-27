part of 'game_details_bloc.dart';

abstract class GameDetailsState extends Equatable {
  const GameDetailsState();

  @override
  List<Object> get props => [];
}

class GameDetailsEmptyState extends GameDetailsState {}

class GameDetailsPendingState extends GameDetailsState {}

class GameDetailsLoadedState extends GameDetailsState {
  final List<Game> similarGames;

  const GameDetailsLoadedState({required this.similarGames});

  @override
  List<Object> get props => [similarGames];
}

class GameDetailsRejectedState extends GameDetailsState {
  final String message;

  const GameDetailsRejectedState({required this.message});

  @override
  List<Object> get props => [message];
}
