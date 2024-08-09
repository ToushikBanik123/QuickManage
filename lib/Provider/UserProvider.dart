import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Api/Models/UserModel.dart';
import '../conts/Widgits/ColoredToast.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  Future<void> fetchUserInfo(String token, BuildContext context) async {
    final userId = token.substring(token.length - 1); // Extract user ID from token
    final url = 'https://reqres.in/api/users/$userId';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _user = UserModel.fromJson(data);
        notifyListeners();
      } else {
        ColoredToast.show(context, 'Failed to fetch user info.', false);
      }
    } catch (e) {
      ColoredToast.show(context, 'An error occurred: $e', false);
    }
  }
}
