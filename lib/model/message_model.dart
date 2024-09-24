enum SenderEnum { chef, you }

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
}
