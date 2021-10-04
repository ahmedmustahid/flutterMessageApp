class ChatRoomModel {
  final String id;
  final String userID;
  final String otherUserId;
  final String otherUserName;
  final String chatId;
  final int version;

  ChatRoomModel({
    required this.id,
    required this.userID,
    required this.otherUserId,
    required this.otherUserName,
    required this.version,
    required this.chatId,
  });
  ChatRoomModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userID = json['userID'],
        otherUserId = json['otherUserId'],
        otherUserName = json['otherUserName'],
        version = json['_version'],
        chatId = json['chatId'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userID,
        'otherUserId': otherUserId,
        'otherUserName': otherUserName,
        'version': version,
        'chatId': chatId,
      };
}
