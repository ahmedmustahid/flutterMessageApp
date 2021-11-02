class MessageModel {
  MessageModel({
    required this.id,
    required this.userId,
    required this.sessionId,
    required this.flowId,
    required this.isMe,
    required this.messageContent,
    required this.createdAt,
  });
  late final String id;
  late final String userId;
  late final String sessionId;
  late final String flowId;
  late final bool isMe;
  late final String messageContent;
  late final String createdAt;

  MessageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    sessionId = json['sessionId'];
    flowId = json['flowId'];
    isMe = json['isMe'];
    messageContent = json['messageContent'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['userId'] = userId;
    _data['sessionId'] = sessionId;
    _data['flowId'] = flowId;
    _data['isMe'] = isMe;
    _data['messageContent'] = messageContent;
    _data['createdAt'] = createdAt;
    return _data;
  }

  @override
  String toString() {
    //return super.toString();
    return '{\"id\": \"$id\",\"userId": \"$userId\",\"sessionId\": \"$sessionId\",\"flowId\": \"$flowId\",\"isMe\": $isMe,\"messageContent\":\"${messageContent.toString()}\",\"createdAt\": \"$createdAt\"}';
  }

  fromJson(jsonDecodedFile) {
    return MessageModel.fromJson(jsonDecodedFile);
  }
}
