import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@entity
class GamePlatform extends Equatable {
  @primaryKey
  final int id;
  final String abbreviation;
  final String name;

  const GamePlatform({required this.id, required this.abbreviation, required this.name});

  factory GamePlatform.fromJson(Map<String, dynamic> json) => GamePlatform(
        id: json['id'],
        abbreviation: json['abbreviation'] ?? '',
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'abbreviation': abbreviation,
        'name': name,
      };

  @override
  List<Object?> get props => [id, abbreviation, name];
}
