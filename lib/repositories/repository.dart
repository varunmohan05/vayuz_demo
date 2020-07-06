import 'package:sqflite/sqflite.dart';
import 'package:vayuzdemo/constants.dart';
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
  insertData(String table, data) async {
    var connection = await database;
    return await connection.insert(table, data);
  }

  // Read data from Table
  Future<List<Map<String, dynamic>>> readData(String table) async {
    Database connection = await database;
    return await connection.query(table);
  }

  Future<void> initialLastTextandTime() async {
    List<Map<String, dynamic>> records = await readData('Radhika');
    if (records.length == 0) {
      await insertMockChats();
    }
    records = await readData('Radhika');
    Map<String, dynamic> lastRecord = records.last;
    String lastTime = lastRecord['time'];
    String lastText = lastRecord['msg'];
    last.insert(0, lastTime);
    last.insert(1, lastText);
    records = await readData('Mayank');
    lastRecord = records.last;
    lastTime = lastRecord['time'];
    lastText = lastRecord['msg'];
    last.insert(2, lastTime);
    last.insert(3, lastText);
    records = await readData('Samarth');
    lastRecord = records.last;
    lastTime = lastRecord['time'];
    lastText = lastRecord['msg'];
    last.insert(4, lastTime);
    last.insert(5, lastText);
    records = await readData('Tanvi');
    lastRecord = records.last;
    lastTime = lastRecord['time'];
    lastText = lastRecord['msg'];
    last.insert(6, lastTime);
    last.insert(7, lastText);
  }

  Future<List<String>> lastTextAndTime() async {
    List<Map<String, dynamic>> records = await readData(
        firstnames[currentIndex]);
    Map<String, dynamic> lastRecord = records.last;

    String lastTime = lastRecord['time'];
    String lastText = lastRecord['msg'];
    last.insert(currentIndex * 2, lastTime);
    last.insert(currentIndex * 2 + 1, lastText);
  }

  Future<void> insertMockChats() async {
    var _message = Message();
    var _messageService = MessageService();
    _message.msg = 'hello';
    _message.isMe = 1;
    await _messageService.saveMessage('Radhika', _message);
    await _messageService.saveMessage('Mayank', _message);
    await _messageService.saveMessage('Samarth', _message);
    await _messageService.saveMessage('Tanvi', _message);
    _message.msg = 'how are you ?';
    _message.isMe = 1;
    await _messageService.saveMessage('Radhika', _message);
    await _messageService.saveMessage('Mayank', _message);
    await _messageService.saveMessage('Samarth', _message);
    await _messageService.saveMessage('Tanvi', _message);
    _message.msg = 'Im good thank you!';
    _message.isMe = 0;
    await _messageService.saveMessage('Radhika', _message);
    await _messageService.saveMessage('Mayank', _message);
    await _messageService.saveMessage('Samarth', _message);
    await _messageService.saveMessage('Tanvi', _message);
    _message.msg = 'What abt u';
    _message.isMe = 0;
    await _messageService.saveMessage('Radhika', _message);
    await _messageService.saveMessage('Mayank', _message);
    await _messageService.saveMessage('Samarth', _message);
    await _messageService.saveMessage('Tanvi', _message);
    _message.msg = 'friend';
    _message.isMe = 0;
    await _messageService.saveMessage('Radhika', _message);
    await _messageService.saveMessage('Mayank', _message);
    await _messageService.saveMessage('Samarth', _message);
    await _messageService.saveMessage('Tanvi', _message);
    _message.msg = 'Where have you been?';
    _message.isMe = 0;
    await _messageService.saveMessage('Radhika', _message);
    await _messageService.saveMessage('Mayank', _message);
    await _messageService.saveMessage('Samarth', _message);
    await _messageService.saveMessage('Tanvi', _message);
  }
}
