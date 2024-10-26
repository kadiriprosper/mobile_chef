enum SenderEnum {
  chef,
  you,
}

class MessageModel {
  MessageModel({
    required this.message,
    required this.sender,
    required this.timeSent,
    this.attachmentPath,
  });
  String message;
  String? attachmentPath;
  SenderEnum sender;
  String timeSent;

  factory MessageModel.fromMap(Map<String, dynamic> data) {
    return MessageModel(
      message: data['message'],
      sender: data['sender'] == SenderEnum.chef.toString()
          ? SenderEnum.chef
          : SenderEnum.you,
      timeSent: data['timesent'],
      attachmentPath: data['attachmentpath'],
    );
  }

  Map<String, dynamic> messageToStorageModel() => {
        'message': message,
        'sender': sender.toString(),
        'timesent': timeSent,
        'attachmentpath': attachmentPath,
      };
}

class ChatModel {
  ChatModel({
    required this.date,
    required this.title,
    this.chats,
  }) : _date = date;

  String date;
  //The datetime the first message was sent
  final String _date;
  //The title of the chat
  String title;
  //The mesages in the chat of the form [{sender: {message: '', dateSent: ''}}]
  List<MessageModel>? chats;

  factory ChatModel.fromStorageModel(Map<String, dynamic> data) {
    final response = ChatModel(
      date: data.entries.elementAt(1).key == 'title' ? data.entries.elementAt(0).key : data.entries.elementAt(1).key,
      title: data['title'],
    );
    final List chatList = data.entries.elementAt(1).key == 'title'
        ? data.entries.elementAt(0).value
        : data.entries.elementAt(1).value;
    final messageHolder =
        chatList.map((element) => MessageModel.fromMap(element)).toList();
    response.chats = messageHolder;
    return response;
  }

  Map<String, dynamic> chatToStorageModel() {
    var chatList = <Map<String, dynamic>>[];
    chats?.forEach(
      (element) => chatList.add(element.messageToStorageModel()),
    );
    return {
      'title': title,
      _date: chatList,
    };
  }

  bool compareToOther(ChatModel other) {
    return _date == other._date && title == other.title;
  }
}
