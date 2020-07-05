import 'package:vayuzdemo/models/message.dart' as C;
import 'package:vayuzdemo/repositories/repository.dart';

class MessageService {
  Repository _repository;

  MessageService() {
    _repository = Repository();
  }

  // Create data
  saveMessage(C.Message message) async {
    return await _repository.insertData('messages', message.messageMap());
  }

  // Read data from table
  Future<List<Map<String, dynamic>>> readMessages() async {
    return await _repository.readData('messages');
  }

  Future<List<String>> lastShow() async {
    return await _repository.lastTextandTime('messages');
  }
}
