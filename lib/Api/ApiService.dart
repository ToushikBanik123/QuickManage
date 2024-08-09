import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../conts/Widgits/ColoredToast.dart';
import 'Models/ApiUserModel.dart';
import 'Models/LoginRequest.dart';
import 'Models/RegisterRequest.dart';
import 'Models/TaskModel.dart';
import 'Models/UserModel.dart';

class ApiService {

  Future<RegisterResponse?> registerUser(RegisterRequest request,BuildContext context) async {
    final String url = 'https://reqres.in/api/register';
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200) {
      return RegisterResponse.fromJson(jsonDecode(response.body));
    } else {
      ColoredToast.show(
          context,
          'Failed to register user: ${jsonDecode(response.body)['error']}',
          false
      );
      print('Failed to register user: ${response.body}');
      return null;
    }
  }

  Future<LoginResponse?> loginUser(LoginRequest request,BuildContext context) async {
    final String url = 'https://reqres.in/api/login';
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200) {
      return LoginResponse.fromJson(jsonDecode(response.body));
    } else {
      ColoredToast.show(
          context,
          'Failed to login user: ${jsonDecode(response.body)['error']}',
          false
      );
      print('Failed to login user: ${response.body}');
      return null;
    }
  }

  final String _taskBaseUrl = 'https://jsonplaceholder.typicode.com/todos';

  Future<List<Task>> getTasks() async {
    final response = await http.get(Uri.parse(_taskBaseUrl));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((task) => Task.fromJson(task)).toList();
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  Future<void> createTask(Task task) async {
    final response = await http.post(
      Uri.parse(_taskBaseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(task.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to create task');
    }
  }

  Future<void> updateTask(Task task) async {
    final response = await http.put(
      Uri.parse('$_taskBaseUrl/${task.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(task.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update task');
    }
    print(response.body);
  }



  Future<void> deleteTask(int id,BuildContext context) async {
    final response = await http.delete(Uri.parse('$_taskBaseUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete task');
    }else{
      ColoredToast.show(context, 'Deleted the task', true);
    }
  }

  Future<List<ApiUserModel>> getUsers() async {
    final response = await http.get(Uri.parse('https://reqres.in/api/users'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> usersJson = data['data']; // Access 'data' key

      return usersJson.map((json) => ApiUserModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

}
