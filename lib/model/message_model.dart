// ignore_for_file: prefer_typing_uninitialized_variables, unnecessary_this

class MessagesModel{
  var messages;
  var senderId;
  var recieverId;
  MessagesModel({
    this.messages,
    this.senderId,
    this.recieverId,
  });

  factory MessagesModel.fromJson(Map<String, dynamic> parsedJson) {
    return MessagesModel(
      messages: parsedJson['messages'] ?? "",
      senderId: parsedJson['senderId'] ?? "",
      recieverId: parsedJson['recieverId'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "messages": this.messages,
      "senderId": this.senderId,
      "recieverId": this.recieverId
    };
  }
}

