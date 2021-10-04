import 'chat_room_model.dart';

class UserModel {
  final String id;
  final String username;

  final bool isVerified;
  final DateTime createdAt;
  final List<ChatRoomModel> chatRooms;
  final int version;

  UserModel(
    this.id,
    this.username,
    this.isVerified,
    this.createdAt,
    this.chatRooms,
    this.version,
  );

  UserModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        version = json['_version'],
        username = json['username'],
        isVerified = json['isVerified'],
        createdAt = DateTime.parse(json['createdAt']),
        chatRooms = [] {
    if (json['ChatRooms'] != null)
      json['ChatRooms']['items'].forEach(
        (item) {
          if (item['_deleted'] == null) {
            return chatRooms.add(ChatRoomModel.fromJson(item));
          }
        },
      );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'isVerified': isVerified,
        'createdAt': createdAt,
        'chatRooms': chatRooms.toString(),
        'version': version,
      };
}
