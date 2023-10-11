class MessageModel {
  final String message;
  final String chatId;
  final int uid;
  final bool isEdited;
  final DateTime wroteAt;

  MessageModel({
    required this.message,
    this.chatId = "",
    this.uid = 0,
    this.isEdited = false,
    final DateTime? wroteAt,
  }) : wroteAt = wroteAt ?? DateTime.now();

  factory MessageModel.fromJson(Map<String, Object?> json) => MessageModel(
        message: json["message"] != null ? json["message"] as String : "",
        chatId: json["chat_id"] as String,
        uid: json["uid"] as int,
        isEdited: json["is_edited"] as bool,
        wroteAt: json["wrote_at"] != null
            ? DateTime.parse(json["wrote_at"] as String)
            : null,
      );

  Map<String, Object?> toJson() => {
        "message": message,
        "chat_id": chatId,
        "uid": uid,
        "is_edited": isEdited,
        "wrote_at": wroteAt.toIso8601String(),
      };

  @override
  String toString() =>
      "MessageModel(chatId: $chatId, uid: $uid, message: $message, isEdited: $isEdited, wroteAt: $wroteAt)";
}
