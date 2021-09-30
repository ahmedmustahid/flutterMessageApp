/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// ignore_for_file: public_member_api_docs

import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the ChatRoom type in your schema. */
@immutable
class ChatRoom extends Model {
  static const classType = const _ChatRoomModelType();
  final String id;
  final String? _userID;
  final String? _chatId;
  final String? _untitledfield;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String? get userID {
    return _userID;
  }
  
  String? get chatId {
    return _chatId;
  }
  
  String? get untitledfield {
    return _untitledfield;
  }
  
  const ChatRoom._internal({required this.id, userID, chatId, untitledfield}): _userID = userID, _chatId = chatId, _untitledfield = untitledfield;
  
  factory ChatRoom({String? id, String? userID, String? chatId, String? untitledfield}) {
    return ChatRoom._internal(
      id: id == null ? UUID.getUUID() : id,
      userID: userID,
      chatId: chatId,
      untitledfield: untitledfield);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChatRoom &&
      id == other.id &&
      _userID == other._userID &&
      _chatId == other._chatId &&
      _untitledfield == other._untitledfield;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("ChatRoom {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("userID=" + "$_userID" + ", ");
    buffer.write("chatId=" + "$_chatId" + ", ");
    buffer.write("untitledfield=" + "$_untitledfield");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  ChatRoom copyWith({String? id, String? userID, String? chatId, String? untitledfield}) {
    return ChatRoom(
      id: id ?? this.id,
      userID: userID ?? this.userID,
      chatId: chatId ?? this.chatId,
      untitledfield: untitledfield ?? this.untitledfield);
  }
  
  ChatRoom.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _userID = json['userID'],
      _chatId = json['chatId'],
      _untitledfield = json['untitledfield'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'userID': _userID, 'chatId': _chatId, 'untitledfield': _untitledfield
  };

  static final QueryField ID = QueryField(fieldName: "chatRoom.id");
  static final QueryField USERID = QueryField(fieldName: "userID");
  static final QueryField CHATID = QueryField(fieldName: "chatId");
  static final QueryField UNTITLEDFIELD = QueryField(fieldName: "untitledfield");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "ChatRoom";
    modelSchemaDefinition.pluralName = "ChatRooms";
    
    modelSchemaDefinition.authRules = [
      AuthRule(
        authStrategy: AuthStrategy.PUBLIC,
        operations: [
          ModelOperation.CREATE,
          ModelOperation.UPDATE,
          ModelOperation.DELETE,
          ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: ChatRoom.USERID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: ChatRoom.CHATID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: ChatRoom.UNTITLEDFIELD,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
  });
}

class _ChatRoomModelType extends ModelType<ChatRoom> {
  const _ChatRoomModelType();
  
  @override
  ChatRoom fromJson(Map<String, dynamic> jsonData) {
    return ChatRoom.fromJson(jsonData);
  }
}