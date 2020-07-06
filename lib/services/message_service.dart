import 'package:vayuzdemo/models/message.dart' as C;
import 'package:vayuzdemo/repositories/repository.dart';

class MessageService {
  Repository _repository;

  MessageService() {
    _repository = Repository();
  }

  // Create data
  saveMessage(String table, C.Message message) async {
    return await _repository.insertData(table, message.messageMap());
  }

  // Read data from table
  Future<List<Map<String, dynamic>>> readMessages(String table) async {
    return await _repository.readData(table);
  }

  Future<void> lastShow() async {
    return await _repository.lastTextAndTime();
  }

  Future<void> initialLastShow() async {
    return await _repository.initialLastTextandTime();
  }
}
