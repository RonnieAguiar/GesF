import 'package:http/http.dart' as http;
import 'package:medicao/models/consulta_cep.dart';

class ViaCep {
  static Future<ConsultaCep> fetchCep({required String cep}) async {
    final url = Uri.https('viacep.com.br', '/ws/$cep/json/');
    
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return ConsultaCep.fromJson(response.body);
    } else {
      throw Exception('Requisição inválida!');
    }
  }
}
