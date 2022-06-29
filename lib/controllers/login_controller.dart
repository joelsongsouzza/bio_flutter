import 'package:dio/dio.dart';

Future<Map<String, dynamic>> signIn(String email, String password) async {
  try {
    final response = await Dio().post(
      "http://10.0.0.101:3005/usuario-login",
      options: Options(
        validateStatus: (status) {
          return status == 201 || status == 500;
        },
      ),
      data: {
        'email': email,
        'senha': password,
      },
    );

    bool status = response.data['result'];
    String message = response.data['message'];

    return {
      'status': status,
      'message': message,
    };
  } catch (error) {
    return {
      'status': false,
      'message': 'error',
    };
  }
}
