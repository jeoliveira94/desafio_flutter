part of 'teams_bloc.dart';

abstract class TeamsEvent extends Equatable {
  const TeamsEvent();
}

class TeamsStarted extends TeamsEvent {
  @override
  List<Object> get props => [];
}

class MoreTeamsRequired extends TeamsEvent {
  @override
  List<Object> get props => [];
}
