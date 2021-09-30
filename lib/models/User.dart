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

import 'ModelProvider.dart';
import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the User type in your schema. */
@immutable
class User extends Model {
  static const classType = const _UserModelType();
  final String id;
  final String? _username;
  final bool? _isVerified;
  final TemporalDateTime? _createdAt;
  final String? _chats;
  final List<ChatRoom>? _ChatRooms;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get username {
    try {
      return _username!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  bool? get isVerified {
    return _isVerified;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  String? get chats {
    return _chats;
  }
  
  List<ChatRoom>? get ChatRooms {
    return _ChatRooms;
  }
  
  const User._internal({required this.id, required username, isVerified, createdAt, chats, ChatRooms}): _username = username, _isVerified = isVerified, _createdAt = createdAt, _chats = chats, _ChatRooms = ChatRooms;
  
  factory User({String? id, required String username, bool? isVerified, TemporalDateTime? createdAt, String? chats, List<ChatRoom>? ChatRooms}) {
    return User._internal(
      id: id == null ? UUID.getUUID() : id,
      username: username,
      isVerified: isVerified,
      createdAt: createdAt,
      chats: chats,
      ChatRooms: ChatRooms != null ? List<ChatRoom>.unmodifiable(ChatRooms) : ChatRooms);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is User &&
      id == other.id &&
      _username == other._username &&
      _isVerified == other._isVerified &&
      _createdAt == other._createdAt &&
      _chats == other._chats &&
      DeepCollectionEquality().equals(_ChatRooms, other._ChatRooms);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("User {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("username=" + "$_username" + ", ");
    buffer.write("isVerified=" + (_isVerified != null ? _isVerified!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("chats=" + "$_chats");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  User copyWith({String? id, String? username, bool? isVerified, TemporalDateTime? createdAt, String? chats, List<ChatRoom>? ChatRooms}) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      isVerified: isVerified ?? this.isVerified,
      createdAt: createdAt ?? this.createdAt,
      chats: chats ?? this.chats,
      ChatRooms: ChatRooms ?? this.ChatRooms);
  }
  
  User.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _username = json['username'],
      _isVerified = json['isVerified'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _chats = json['chats'],
      _ChatRooms = json['ChatRooms'] is List
        ? (json['ChatRooms'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => ChatRoom.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'username': _username, 'isVerified': _isVerified, 'createdAt': _createdAt?.format(), 'chats': _chats, 'ChatRooms': _ChatRooms?.map((ChatRoom? e) => e?.toJson()).toList()
  };

  static final QueryField ID = QueryField(fieldName: "user.id");
  static final QueryField USERNAME = QueryField(fieldName: "username");
  static final QueryField ISVERIFIED = QueryField(fieldName: "isVerified");
  static final QueryField CREATEDAT = QueryField(fieldName: "createdAt");
  static final QueryField CHATS = QueryField(fieldName: "chats");
  static final QueryField CHATROOMS = QueryField(
    fieldName: "ChatRooms",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (ChatRoom).toString()));
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "User";
    modelSchemaDefinition.pluralName = "Users";
    
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
      key: User.USERNAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.ISVERIFIED,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.CREATEDAT,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.CHATS,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: User.CHATROOMS,
      isRequired: false,
      ofModelName: (ChatRoom).toString(),
      associatedKey: ChatRoom.USERID
    ));
  });
}

class _UserModelType extends ModelType<User> {
  const _UserModelType();
  
  @override
  User fromJson(Map<String, dynamic> jsonData) {
    return User.fromJson(jsonData);
  }
}