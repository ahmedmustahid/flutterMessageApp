class MessageModel {
  MessageModel({
    required this.id,
    required this.userId,
    required this.isMe,
    required this.message,
    required this.createdAt,
  });
  late final String id;
  late final String userId;
  late final bool isMe;
  late final String message;
  late final String createdAt;

  MessageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    isMe = json['isMe'];
    message = json['message'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['userId'] = userId;
    _data['isMe'] = isMe;
    _data['message'] = message;
    _data['createdAt'] = createdAt;
    return _data;
  }
}
