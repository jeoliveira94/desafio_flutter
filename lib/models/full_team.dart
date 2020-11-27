import 'package:desafio_front/models/models.dart';
import 'package:equatable/equatable.dart';

class FullTeam extends Equatable {
  final Team team;
  final List<Player> players;
  const FullTeam({this.team, this.players});
  @override
  List<Object> get props => [team, players];

  static FullTeam fromMap(Map<String, dynamic> map) {
    return FullTeam(team: map['team'], players: map['players']);
  }

  Map toMap() => {'team': team, 'players': players};
}
