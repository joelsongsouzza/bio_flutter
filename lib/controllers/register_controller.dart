import 'package:dio/dio.dart';
import 'package:validators/validators.dart' as validator;

bool validaInputs(String email, String password) {
  bool emailIsValid = validator.isEmail(email);
  bool passwordIsValid = password.isNotEmpty;

  return emailIsValid && passwordIsValid;
}

Future<Map<String, dynamic>> sendAccountCreationRequest(String email, String password, String cpf) async {
  try {
    final response = await Dio().post(
      "http://10.0.0.101:3005/usuario",
      data: {
        'nome': 'Joelson',
        'sobrenome': 'Goncalves',
        'email': email,
        'senha': password,
        'data_de_nascicmento': DateTime(1995, 1, 14).toString(),
        'documento': cpf,
        'cep': '42722020',
        'logradouro': 'Rua dos Bobos',
        'numero': '0',
        'complemento': 'Uma casa sem teto',
        'bairro': 'Aquele',
        'cidade': 'O outro',
        'estado': 'BA',
        'situacao_lesao': '',
        'nivel_lesao': '6',
        'detalhe_lesao': '1',
        'telefone': '71993120478',
        'foto_documento': '',
        'foto_documento64': '',
        'foto_com_documento': '',
        'foto_com_documento64': '',
        'ativo': 0,
      },
    );

    print(response.data);

    return {
      'status': true,
      'message': 'success',
    };
  } catch (error) {
    if (error is DioError) {
      print(error.response);
      return {
        'status': false,
        'message': error.response.toString().contains("duplicate") ? 'duplicate' : 'unkown',
      };
    } else {
      return {
        'status': false,
        'message': 'unkown',
      };
    }
  }
}
