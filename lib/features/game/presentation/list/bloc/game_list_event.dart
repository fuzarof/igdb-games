part of 'game_list_bloc.dart';

abstract class GameListEvent extends Equatable {
  const GameListEvent();

  @override
  List<Object> get props => [];
}

class LoadGameListEvent extends GameListEvent {
  final String? search;
  final int page;

  const LoadGameListEvent({this.search, required this.page});
}
