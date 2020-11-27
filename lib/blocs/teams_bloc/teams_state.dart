part of 'teams_bloc.dart';

abstract class TeamsState extends Equatable {
  const TeamsState();
}

class LoadingData extends TeamsState {
  @override
  List<Object> get props => [];
}

class DataLoaded extends TeamsState {
  final List<FullTeam> teams;

  const DataLoaded({this.teams = const []});

  @override
  List<Object> get props => [teams];
}
