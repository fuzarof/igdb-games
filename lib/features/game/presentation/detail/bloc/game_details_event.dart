part of 'game_details_bloc.dart';

abstract class GameDetailsEvent extends Equatable {
  const GameDetailsEvent();

  @override
  List<Object> get props => [];
}

class LoadRelatedGameListEvent extends GameDetailsEvent {
  final List<int>? ids;

  const LoadRelatedGameListEvent({this.ids});
}
