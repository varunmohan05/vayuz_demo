class Message {
  int id;
  int isMe;
  String msg = 'This is a sample message';
  String time = '${DateTime.now().hour>9?DateTime.now().hour:'0''${DateTime.now().hour}'}:${DateTime.now().minute>9?DateTime.now().minute:'0''${DateTime.now().minute}'}';

  messageMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id;
    mapping['isMe'] = isMe;
    mapping['msg'] = msg;
    mapping['time'] = time;

    return mapping;
  }
}
