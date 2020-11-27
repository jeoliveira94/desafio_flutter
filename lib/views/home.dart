import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:desafio_front/blocs/blocs.dart';
import 'package:desafio_front/shared/app_colors.dart';
import 'package:desafio_front/shared/ui_helpers.dart';
import 'animated_loading_Icon.dart';
import 'full_team_item.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TeamsBloc teamsBloc;

  final listScrollController = ScrollController();
  final appBarScrollController = ScrollController();

  @override
  void initState() {
    teamsBloc = BlocProvider.of<TeamsBloc>(context)..add(TeamsStarted());
    listScrollController.addListener(linkScrollListener);
    super.initState();
  }

  @override
  void dispose() {
    teamsBloc.close();
    listScrollController.dispose();
    appBarScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      controller: appBarScrollController,
      headerSliverBuilder: (BuildContext contex, bool innerBoxIsScrolled) {
        return [
          SliverAppBar(
            expandedHeight: 100,
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'NBA Teams',
                style: TextStyle(color: primaryTextColor),
                textAlign: TextAlign.center,
              ),
              titlePadding: const EdgeInsets.all(20),
            ),
            pinned: true,
            floating: true,
          )
        ];
      },
      body: BlocBuilder<TeamsBloc, TeamsState>(
        builder: (context, state) {
          if (state is LoadingData) {
            return _buildLoadingCard();
          }
          if (state is DataLoaded) {
            return _buildTeams(state);
          }
          return Text('Error');
        },
      ),
    );
  }

  Widget _buildTeams(DataLoaded state) {
    return ListView.builder(
        controller: listScrollController,
        itemCount: state.teams.length + 1,
        itemBuilder: (BuildContext context, index) {
          if (index < state.teams.length) {
            return Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: FullTeamItem(
                team: state.teams[index].team,
                players: state.teams[index].players,
              ),
            );
          } else {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 32.0),
              child: Center(child: AnimatedLoadingIcon()),
            );
          }
        });
  }

  Widget _buildLoadingCard() {
    return Card(
      child: Center(
        child: Column(
          children: [
            UIHelper.verticalSpaceMedium,
            Text(
              'Carregando dados...',
              style: TextStyle(fontSize: 18),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }

  linkScrollListener() {
    double maxScrollExtend = listScrollController.position.maxScrollExtent;
    double offset = listScrollController.offset;

    if (maxScrollExtend == offset) {
      teamsBloc.add(MoreTeamsRequired());
    }

    double appBarMaxScrollExtent =
        appBarScrollController.position.maxScrollExtent;
    double appBarMinScrollExtent =
        appBarScrollController.position.minScrollExtent;
    double listScrollOffset = listScrollController.offset;

    if (listScrollOffset > appBarMinScrollExtent &&
        listScrollOffset < appBarMaxScrollExtent) {
      appBarScrollController.jumpTo(listScrollOffset);
    }
  }
}
