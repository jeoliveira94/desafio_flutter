import 'package:flutter/material.dart';
import 'package:desafio_front/models/models.dart';

import 'package:desafio_front/shared/app_colors.dart';
import 'package:desafio_front/shared/ui_helpers.dart';

class FullTeamItem extends StatelessWidget {
  final Team team;
  final List<Player> players;

  const FullTeamItem({this.team, this.players});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TeamSummary(
            teamName: team.fullName,
            countPlayers: players.length,
          ),
          UIHelper.verticalSpaceMedium,
          PlayerList(this.players),
        ],
      ),
    );
  }
}

class TeamSummary extends StatelessWidget {
  final String teamName;
  final int countPlayers;

  const TeamSummary({this.teamName, this.countPlayers});

  @override
  Widget build(BuildContext context) {
    double fontSize = 16;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: RichText(
          textAlign: TextAlign.left,
          text: TextSpan(
              style: TextStyle(
                fontSize: fontSize,
                color: primaryTextColor,
              ),
              children: [
                TextSpan(
                    text: teamName,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: '  '),
                TextSpan(
                  text: countPlayers.toString(),
                )
              ]),
        ),
      ),
    );
  }
}

class PlayerList extends StatelessWidget {
  final List<Player> players;

  const PlayerList(this.players);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: players
            .map(
              (player) => Padding(
                padding: const EdgeInsets.all(10),
                child: PlayerListItem(player),
              ),
            )
            .toList(),
      ),
    );
  }
}

class PlayerListItem extends StatelessWidget {
  final Player player;
  const PlayerListItem(this.player);
  @override
  Widget build(BuildContext context) {
    double heightposition = 60;
    double widthPosition = 60;
    double fontSizePosition = 25;
    double fontSizeIdPlayer = 16;
    double fontSizeFullNamePlayer = 20;

    return Row(
      children: [
        Container(
          height: heightposition,
          width: widthPosition,
          decoration:
              BoxDecoration(color: primaryColor, shape: BoxShape.circle),
          child: Center(
            child: Text(
              player.position.isEmpty ? '-' : player.position,
              style: TextStyle(
                  fontSize: fontSizePosition, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        UIHelper.horizontalSpaceMedium,
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                player.id.toString(),
                style: TextStyle(
                    fontSize: fontSizeIdPlayer, color: secondaryTextColor),
              ),
              Text(
                '${player.firstName} ${player.lastName}',
                style: TextStyle(
                    fontSize: fontSizeFullNamePlayer,
                    fontWeight: FontWeight.bold,
                    color: primaryTextColor),
              )
            ],
          ),
        )
      ],
    );
  }
}
