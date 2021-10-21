import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify.dart';

Future<void> getImageApi() async {
  try {
    RestOptions options = RestOptions(path: '/');
    RestOperation restOperation = Amplify.API.get(restOptions: options);
    RestResponse response = await restOperation.response;
    print('GET call succeeded');
  } on ApiException catch (e) {
    print('GET call failed: $e');
  }
}
