import 'package:sqflite/sqflite.dart';
import 'package:vayuzdemo/models/message.dart';
import 'package:vayuzdemo/repositories/database_connection.dart';
import 'package:vayuzdemo/services/message_service.dart';

class Repository {
  DatabaseConnection _databaseConnection;

  Repository() {
    // initialize database connection
    _databaseConnection = DatabaseConnection();
  }

  static Database _database;

  // Check if database is exist or not
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _databaseConnection.setDatabase();
    return _database;
  }

  // Inserting data to Table
  insertData(table, data) async {
    var connection = await database;
    return await connection.insert(table, data);
  }

  // Read data from Table
  Future<List<Map<String, dynamic>>> readData(table) async {
    Database connection = await database;
    return await connection.query(table);
  }

  Future<List<String>> lastTextandTime(table) async {
    List<Map<String, dynamic>> records = await readData(table);
    if (records.length == 0) {
      await insertMockChats();
    }
    records = await readData(table);
    Map<String, dynamic> lastRecord = records.last;

    String lastTime = lastRecord['time'];
    String lastText = lastRecord['msg'];
    List<String> lastTextandTime = [lastTime, lastText];
    return lastTextandTime;
  }

  Future<void> insertMockChats() async {
    var _message = Message();
    var _messageService = MessageService();
    _message.msg = 'hello';
    _message.isMe = 1;
    await _messageService.saveMessage(_message);
    _message.msg = 'how are you ?';
    _message.isMe = 1;
    await _messageService.saveMessage(_message);
    _message.msg = 'Im good thank you!';
    _message.isMe = 0;
    await _messageService.saveMessage(_message);
    _message.msg = 'What abt u';
    _message.isMe = 0;
    await _messageService.saveMessage(_message);
    _message.msg = 'friend';
    _message.isMe = 0;
    await _messageService.saveMessage(_message);
    _message.msg = 'Where have you been?';
    _message.isMe = 0;
    await _messageService.saveMessage(_message);
  }
}
