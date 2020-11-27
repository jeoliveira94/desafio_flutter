import 'package:equatable/equatable.dart';

class Team extends Equatable {
  final int id;
  final String abbreviation;
  final String city;
  final String conference;
  final String division;
  final String fullName;
  final String name;

  const Team(
      {this.id,
      this.abbreviation,
      this.city,
      this.conference,
      this.division,
      this.fullName,
      this.name});

  @override
  List<Object> get props {
    return [id, abbreviation, city, conference, division, fullName, name];
  }

  static Team fromMap(Map map) {
    return Team(
        id: map['id'],
        abbreviation: map['abbreviation'],
        city: map['city'],
        conference: map['conference'],
        division: map['division'],
        fullName: map['full_name'],
        name: map['name']);
  }
}
