part of 'game_list_bloc.dart';

abstract class GameListEvent extends Equatable {
  const GameListEvent();

  @override
  List<Object> get props => [];
}

class LoadGameListEvent extends GameListEvent {
  final String? search;

  const LoadGameListEvent({this.search});
}
