import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:desafio_front/models/models.dart';
import 'package:desafio_front/repositories/nba_respository.dart';

part 'teams_events.dart';
part 'teams_state.dart';

class TeamsBloc extends Bloc<TeamsEvent, TeamsState> {
  TeamsBloc(initialState) : super(initialState);

  final NbaRepository repository = NbaRepository();

  @override
  Stream<TeamsState> mapEventToState(event) async* {
    if (event is TeamsStarted) {
      yield* _mapTeamStartedToState(event, state);
    } else if (event is MoreTeamsRequired) {
      yield* _mapTeamRequiredToState(event, state);
    }
  }

  Stream<TeamsState> _mapTeamStartedToState(
      TeamsStarted event, TeamsState state) async* {
    yield LoadingData();
    try {
      await repository.refreshAllData();
      List<FullTeam> teams = await repository.getMoreTeams(0);
      yield DataLoaded(teams: teams);
    } catch (_) {}
  }

  Stream<TeamsState> _mapTeamRequiredToState(
      MoreTeamsRequired event, TeamsState state) async* {
    if (state is DataLoaded) {
      // Como os dados estão armazenados localmente a recuperação é bem rápida
      // eu coloquei esse delay de 2 segundos pra animação ser vista
      await Future.delayed(const Duration(milliseconds: 2000));
      List<FullTeam> currentTeams =
          await repository.getMoreTeams(state.teams.length);
      List<FullTeam> newTeams = List.of(state.teams)..addAll(currentTeams);
      yield DataLoaded(teams: newTeams);
    }
  }
}
