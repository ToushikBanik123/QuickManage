class RegisterRequest {
  String email;
  String password;

  RegisterRequest({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}

class RegisterResponse {
  int id;
  String token;

  RegisterResponse({required this.id, required this.token});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      id: json['id'],
      token: json['token'],
    );
  }
}

