class Message {
  final String message;
  dynamic id;

  Message(this.message, this.id);
  factory Message.fromJson(jsonData) {
    return Message(jsonData['message'], jsonData["id"]);
  }
}
