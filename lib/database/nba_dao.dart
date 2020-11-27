import 'dart:convert';

import 'package:desafio_front/database/database_provider.dart';
import 'package:desafio_front/models/full_team.dart';
import 'package:desafio_front/models/models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NbaDao {
  final DatabaseProvider databaseProvider = DatabaseProvider();
  final http.Client httpClient;
  final baseUrl = 'https://www.balldontlie.io/api/v1';

  NbaDao({@required this.httpClient});

  refreshAllData() async {
    try {
      await clearDatabase();
      await loadPlayers();
      await loadTeams();
    } catch (_) {}
  }

  clearDatabase() async {
    final db = await databaseProvider.database;
    try {
      await db.execute('DELETE FROM ${databaseProvider.teamTableName}');
      await db.execute('DELETE FROM ${databaseProvider.playerTableName}');
    } catch (e) {
      print(e);
    }
  }

  loadTeams() async {
    final db = await databaseProvider.database;
    final teamsUrl = baseUrl + '/teams';

    final response = await this.httpClient.get(teamsUrl);

    final json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      for (dynamic rawTeam in json['data']) {
        try {
          await db.insert(databaseProvider.teamTableName, rawTeam);
        } catch (e) {}
      }
    }
  }

  loadPlayers() async {
    final String playersUrl = baseUrl + '/players?per_page=100';

    http.Response response = await this.httpClient.get(playersUrl);
    dynamic json = jsonDecode(response.body);

    if (response.statusCode == 200) {
      for (dynamic rawPlayer in json['data']) {
        try {
          await _insertRawPlayer(rawPlayer);
        } catch (e) {}
      }
    }

    dynamic meta = json['meta'];
    int page = meta['current_page'];
    int totalPages = meta['total_pages'];
    String playersUrlWithPage;

    while (page <= totalPages) {
      playersUrlWithPage = baseUrl + '/players?per_page=100&page=$page';
      response = await this.httpClient.get(playersUrlWithPage);

      json = jsonDecode(response.body);

      if (response.statusCode == 200) {
        for (dynamic rawPlayer in json['data']) {
          try {
            await _insertRawPlayer(rawPlayer);
          } catch (e) {}
        }
      }
      page += 1;
    }
  }

  _insertRawPlayer(Map rawPLayer) async {
    final db = await databaseProvider.database;
    try {
      await db.insert(
          databaseProvider.playerTableName, Player.fromJson(rawPLayer).toMap());
    } catch (e) {}
  }

  Future<List<Player>> getPlayersByTeam(int teamId) async {
    final db = await databaseProvider.database;
    var rows = await db.rawQuery(
        "SELECT * FROM ${databaseProvider.playerTableName} WHERE team_id=$teamId");

    List<Player> players =
        rows.map((rawPlayer) => Player.fromMap(rawPlayer)).toList();
    return players;
  }

  Future<List<Team>> getNextTeams(int lastId) async {
    final db = await databaseProvider.database;
    var rows = await db.rawQuery(
        'SELECT * FROM ${databaseProvider.teamTableName} WHERE id BETWEEN ${lastId + 1} AND ${lastId + 2}');
    var teams = rows.map((rawTeam) => Team.fromMap(rawTeam)).toList();
    return teams;
  }

  Future<List<FullTeam>> getFullTeams(int lastId) async {
    var teams = await getNextTeams(lastId);
    List<FullTeam> fullTeamsMap = [];
    for (Team team in teams) {
      var players = await getPlayersByTeam(team.id);
      fullTeamsMap.add(FullTeam(team: team, players: players));
    }

    return fullTeamsMap;
  }
}
