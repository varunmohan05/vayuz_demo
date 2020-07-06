import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseConnection {
  setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'db');
    var database =
        await openDatabase(path, version: 1, onCreate: _onCreatingDatabase);
    return database;
  }

  _onCreatingDatabase(Database database, int version) async {
    await database.execute(
        "CREATE TABLE Radhika(id INTEGER PRIMARY KEY, isMe INTEGER, msg TEXT, time TEXT)");
    await database.execute(
        "CREATE TABLE Mayank(id INTEGER PRIMARY KEY, isMe INTEGER, msg TEXT, time TEXT)");
    await database.execute(
        "CREATE TABLE Samarth(id INTEGER PRIMARY KEY, isMe INTEGER, msg TEXT, time TEXT)");
    await database.execute(
        "CREATE TABLE Tanvi(id INTEGER PRIMARY KEY, isMe INTEGER, msg TEXT, time TEXT)");
  }
}
