import 'package:appscrip_task_management_app/Screens/WelcomePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Api/ApiService.dart';
import '../Api/Models/LoginRequest.dart';
import '../Api/Models/RegisterRequest.dart';
import '../Provider/UserProvider.dart';
import '../conts/Widgits/ColoredToast.dart';
import '../Screens/HomeScreen.dart';
import '../Screens/LoginScreen.dart';
import '../Screens/RegistrationScreen.dart';
import 'TaskProvider.dart';

class AuthProvider with ChangeNotifier {
  TextEditingController _emailLoginScreenController = TextEditingController();
  TextEditingController _passwordLoginScreenController = TextEditingController();
  TextEditingController _emailRegisterScreenController = TextEditingController();
  TextEditingController _passwordRegisterScreenController = TextEditingController();
  bool _obscureTextlogin = true;

  get emailLoginScreenController => _emailLoginScreenController;
  get passwordLoginScreenController => _passwordLoginScreenController;
  get emailRegisterScreenController => _emailRegisterScreenController;
  get passwordRegisterScreenController => _passwordRegisterScreenController;
  get obscureTextlogin => _obscureTextlogin;


  final ApiService _apiService = ApiService();

  // LoginPage
  void setObscureTextlogin(bool value) {
    _obscureTextlogin = value;
    notifyListeners();
  }

  void submitRegisterInfo(BuildContext context) async {
    RegisterRequest request = RegisterRequest(
      email: _emailRegisterScreenController.text,
      password: _passwordRegisterScreenController.text,
    );

    try {
      final response = await _apiService.registerUser(request,context);
      if (response != null) {
        ColoredToast.show(context, 'Registered successfully', true);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    } catch (e) {
      ColoredToast.show(context, 'An error occurred: $e', false);
    }
  }

  void submitLoginInfo(BuildContext context) async {
    LoginRequest request = LoginRequest(
      email: _emailLoginScreenController.text,
      password: _passwordLoginScreenController.text,
    );

    try {
      final response = await _apiService.loginUser(request,context);
      if (response != null) {
        ColoredToast.show(context, 'Logged in successfully', true);

        // Save token to shared preferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', response.token);

        // Fetch user info using the token
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        await userProvider.fetchUserInfo(response.token,context);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    } catch (e) {
      ColoredToast.show(context, 'An error occurred: $e', false);
    }
  }

  Future<void> checkLoginStatus(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      await userProvider.fetchUserInfo(token, context);

      // final taskProvider = Provider.of<TaskProvider>(context, listen: false);
      // await taskProvider.fetchTasks();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WelcomePage()),
      );
    }
  }

  void logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

}
