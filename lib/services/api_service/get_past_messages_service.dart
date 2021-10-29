import 'dart:convert';
import 'package:chat/amplifyconfiguration.dart';
import 'package:chat/constants.dart';
import 'package:http/http.dart' as http;
import 'package:chat/models/message_model.dart';
//import 'dart:typed_data';
//import 'package:amplify_api/amplify_api.dart';
//import 'package:amplify_flutter/amplify.dart';
//import 'package:chat/constants.dart';

// Future<dynamic> getPastAndWelcomeMessages(
//     MessageModel classInstanceToPOST) async {
//   try {
//     final encoder = const Utf8Encoder(); // 日本語文字化け解決用

//     RestOptions options = RestOptions(
//         path: REST_API_RESOURCE_PATH,
//         body: Uint8List.fromList(encoder.convert(classInstanceToPOST
//             .toString()))); // 日本語の文字化けを解消するために文字列をUTF8でエンコードする
//     RestOperation restOperation = Amplify.API.post(restOptions: options);
//     RestResponse response = await restOperation.response;
//     print('POST call succeeded');

//     final responseFromREST = new String.fromCharCodes(response.data);
//     //print("flowId  ${classInstanceToPOST.flowId}");
//     //print("sessionId  ${classInstanceToPOST.sessionId}");

//     Iterable decodedJson = jsonDecode(responseFromREST);
//     print('decodedJson \n $decodedJson');
//     List<MessageModel> messages = List<MessageModel>.from(
//         decodedJson.map((element) => classInstanceToPOST.fromJson(element)));
//     return messages;
//   } on ApiException catch (e) {
//     print('POST call failed: $e');
//     var messageContent = "Something is wrong! Try Again.";
//     var errorMessage = MessageModel(
//         id: "",
//         userId: "",
//         sessionId: "",
//         flowId: "",
//         isMe: false,
//         messageContent: messageContent,
//         createdAt: "");
//     return [errorMessage];
//   }
// }

Future<List<MessageModel>> getPastAndWelcomeMessages(
    MessageModel classInstanceToPost) async {
  String zaichatbotURLWithResource = zaichatbotURL + REST_API_RESOURCE_PATH;
  final response = await http
      .post(
        Uri.parse(zaichatbotURLWithResource),
        headers: <String, String>{
          headerString: zaichatbotApiKey,
        },
        body: jsonEncode(<String, String>{
          "id": classInstanceToPost.id,
          "userId": classInstanceToPost.userId,
          "sessionId": classInstanceToPost.sessionId,
          "flowId": classInstanceToPost.flowId,
          "isMe": classInstanceToPost.isMe ? "true" : "false",
          "messageContent": classInstanceToPost.messageContent,
          "createdAt": classInstanceToPost.createdAt
        }),
      )
      .timeout(const Duration(seconds: CHAT_TIMEOUT_DURATION_SECONDS));
  if (response.statusCode == 200) {
    var responseBody = response.body;
    //print('responseBody $responseBody');

    Iterable decodedJson = jsonDecode(responseBody);
    print(decodedJson);
    List<MessageModel> messages = List<MessageModel>.from(
        decodedJson.map((element) => MessageModel.fromJson(element)));
    return messages;
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    print('Failed to get messages from db.');
    var messageContent = "Something is wrong! Try Again.";
    var errorMessage = MessageModel(
        id: "",
        userId: "",
        sessionId: "",
        flowId: "",
        isMe: false,
        messageContent: messageContent,
        createdAt: "");
    return [errorMessage];
  }
}
