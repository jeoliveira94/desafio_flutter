import 'dart:async';

import 'package:desafio_front/database/nba_dao.dart';
import 'package:desafio_front/models/models.dart';

import 'package:http/http.dart';

class NbaRepository {
  final NbaDao nbaDao = NbaDao(httpClient: Client());

  refreshAllData() async {
    await nbaDao.refreshAllData();
  }

  Future<List<FullTeam>> getMoreTeams(int lastId) async {
    return await nbaDao.getFullTeams(lastId);
  }
}
