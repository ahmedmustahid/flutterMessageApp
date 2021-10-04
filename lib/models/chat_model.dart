class ChatModel {
  final String id;
  final String chatRoomId;
  final int version;
  final String message;
  final String senderId;
  final DateTime updatedAt;
  final DateTime createdAt;

  ChatModel({
    required this.id,
    required this.chatRoomId,
    required this.version,
    required this.message,
    required this.senderId,
    required this.updatedAt,
    required this.createdAt,
  });

  ChatModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        chatRoomId = json['chatRoomId'],
        version = json['_version'],
        message = json['message'],
        senderId = json['senderId'],
        updatedAt = DateTime.parse(json['updatedAt']),
        createdAt = DateTime.parse(json['createdAt']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'chatRoomId': chatRoomId,
        'version': version,
        'message': message,
        'senderId': senderId,
        'updatedAt': updatedAt,
        'createdAt': createdAt,
      };
}
