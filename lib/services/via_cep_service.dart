import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:medicao/models/consulta_cep.dart';

class ViaCep {
  static Future<ConsultaCep> fetchCep({required String cep}) async {
    final url = Uri.https('viacep.com.br', '/ws/$cep/json/');

    final response = await http.get(url);
    var jsonResponse;

    if (response.statusCode == 200) {
      jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      return Future.error("Consulta indisponível");
    }

    if (jsonResponse["erro"] == null) {
      return ConsultaCep.fromJson(response.body);
    } else {
      return Future.error('CEP não encontrado!');
    }
  }
}
