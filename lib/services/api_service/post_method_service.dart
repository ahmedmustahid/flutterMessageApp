import 'dart:convert';
import 'dart:typed_data';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:chat/constants.dart';
import 'package:chat/models/message_model.dart';

Future<MessageModel?> postApi(MessageModel classInstanceToPOST) async {
  try {
    RestOptions options = RestOptions(
        path: REST_API_RESOURCE_PATH,
        body: Uint8List.fromList(classInstanceToPOST.toString().codeUnits));
    RestOperation restOperation = Amplify.API.post(restOptions: options);
    RestResponse response = await restOperation.response;
    print('POST call succeeded');

    final responseFromREST = new String.fromCharCodes(response.data);
    final classInstanceFromJson =
        classInstanceToPOST.fromJson(jsonDecode(responseFromREST));

    print('String response from REST is \n $responseFromREST');
    return classInstanceFromJson;
  } on ApiException catch (e) {
    print('POST call failed: $e');
  }
}
