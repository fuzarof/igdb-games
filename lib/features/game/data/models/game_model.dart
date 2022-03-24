import 'package:equatable/equatable.dart';

class Game extends Equatable {
  final int id;
  final String name;
  final String? summary;

  const Game({required this.id, required this.name, this.summary});

  factory Game.fromJson(Map<String, dynamic> json) =>
      Game(id: json['id'], name: json['name'], summary: json['summary']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'summary': summary,
      };

  @override
  List<Object?> get props => [id, name, summary];
}
