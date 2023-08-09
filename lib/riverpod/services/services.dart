import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:uiwithcomponent/clonewithriverpod/model/user_model.dart';

class ApiServices {
  final String endpoint = 'https://jsonplaceholder.typicode.com/users';

  Future<List<Users>> getUsers() async {
    Response response = await get(Uri.parse(endpoint));

    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body);
      return result.map((e) => Users.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}

// Provier api for get user data
final apiProvider = Provider<ApiServices>(
  (ref) => ApiServices(),
);

// sample string provide not need
final userString = Provider<String>((ref) {
  return 'Hi I am rahul';
});

// data provider for updata user provider
final userDataProvider = FutureProvider<List<Users>>(
  (ref) => ref.watch(apiProvider).getUsers(),
);
