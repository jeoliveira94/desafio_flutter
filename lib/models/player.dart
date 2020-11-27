import 'package:equatable/equatable.dart';

class Player extends Equatable {
  final int id;
  final String firstName;
  final int heightFeet;
  final int heightInches;
  final String lastName;
  final String position;
  final int teamId;
  final int weightPounds;

  const Player(
      {this.id,
      this.firstName,
      this.lastName,
      this.heightFeet,
      this.heightInches,
      this.weightPounds,
      this.position,
      this.teamId});

  @override
  List<Object> get props => [
        id,
        firstName,
        lastName,
        heightFeet,
        heightInches,
        weightPounds,
        position,
        teamId
      ];

  static Player fromJson(Map<String, dynamic> map) {
    return Player(
        id: map['id'],
        firstName: map['first_name'],
        lastName: map['last_name'],
        heightFeet: map['height_feet'],
        heightInches: map['height_inchees'],
        weightPounds: map['weight_pounds'],
        position: map['position'],
        teamId: map['team']['id']);
  }

  static Player fromMap(Map<String, dynamic> map) {
    return Player(
        id: map['id'],
        firstName: map['first_name'],
        lastName: map['last_name'],
        heightFeet: map['height_feet'],
        heightInches: map['height_inchees'],
        weightPounds: map['weight_pounds'],
        position: map['position'],
        teamId: map['team_id']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'height_feet': heightFeet,
      'height_inches': heightInches,
      'weight_pounds': weightPounds,
      'position': position,
      'team_id': teamId
    };
  }
}
