import 'package:http/http.dart' as http;
import 'package:medicao/models/cliente_model.dart';

class Env {
  static String urlPrefix = 'engenhariafantini.com.br/gesfapi/';
}

class ClienteServerList {
  static Future<Cliente> getClienteList() async {
    final url = Uri.https(Env.urlPrefix, "list.phpp");
    final response = await http.post(url);

    if (response.statusCode == 200) {
      return Cliente.fromJson(response.body);
    } else {
      return Future.error("Consulta indisponível");
    }
  }
}


