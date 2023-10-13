class ChatsModel {
  final String chatId;
  final String firstUser;
  final String secondUser;

  ChatsModel({
    required this.chatId,
    required this.firstUser,
    required this.secondUser,
  });

  factory ChatsModel.fromJson(Map<String, Object?> json) => ChatsModel(
        chatId: json["chat_id"] as String,
        firstUser: json["first_user"] as String,
        secondUser: json["second_user"] as String,
      );

  Map<String, Object?> toJson() => {
        "chat_id": chatId,
        "first_user": firstUser,
        "second_user": secondUser,
      };
}
