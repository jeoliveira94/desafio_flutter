import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static final DatabaseProvider databaseProvider = DatabaseProvider();

  Database _database;

  get teamTableName => 'teams';
  get playerTableName => 'players';

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await createDatabase();
    return _database;
  }

  createDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "NBA.db");
    var database = await openDatabase(
      path,
      version: 1,
      onCreate: initDB,
    );
    return database;
  }

  void initDB(Database database, int version) async {
    await database.execute('''
      CREATE TABLE $teamTableName (
          id INTEGER PRIMARY KEY, 
          name TEXT, 
          full_name TEXT, 
          abbreviation TEXT, 
          city TEXT, 
          conference TEXT, 
          division TEXT
        )
        ''');

    await database.execute('''
        CREATE TABLE $playerTableName (
            id INTEGER PRIMARY KEY,
            first_name TEXT, 
            last_name TEXT, 
            position TEXT, 
            height_feet INTEGER, 
            height_inches INTEGER, 
            weight_pounds INTEGER,
            team_id INTEGER
        )
      ''');
  }
}
