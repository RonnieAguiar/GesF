import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:medicao/data/url_apiDB.dart';
import 'package:medicao/models/cliente_model.dart';

final url = Uri.https(UrlApiDB.urlPrefix, "/gesfapi/cliente.php");

class ClienteServerList {
  static Future<List<Cliente>> getClienteList() async {
    final response = await http.post(url,
        body: {'funcao': 'list'});

    if (response.statusCode == 200) {
      try {
        final items = json.decode(response.body).cast<Map<String, dynamic>>();
        List<Cliente> clientes = items.map<Cliente>((json) {
          return Cliente.fromJson(json);
        }).toList();
        print(clientes);
        return clientes;
      } on Exception catch (e) {
        return Future.error(e);
      }
    } else {
      return Future.error("Consulta indisponível");
    }
  }

  List<Cliente> clienteFromJson(String str) {
    final data = json.decode(str);
    return List<Cliente>.from(data.map((item) => Cliente.fromJson(item)));
  }

  Future<List<Cliente>> getCliente() async {
    final response = await http.post(url, body: {'funcao': 'list'});
    if (response.statusCode == 200) {
      List<Cliente> list = clienteFromJson(response.body);
      return list;
    } else {
      return List.empty();
    }
  }
}

class ClienteServerPut {
  static Future<String> Update(Cliente cliente) async {
    final response = await http.post(url, body: {
      'funcao': 'update',
      'id': cliente.id,
      'nome': cliente.nome,
      'cep': cliente.cep,
      'logradouro': cliente.logradouro,
      'numero': cliente.numero,
      'cidade': cliente.cidade,
      'estado': cliente.estado,
      'bairro': cliente.bairro,
    });
    return response.statusCode == 200
        ? "Atualizado com sucesso"
        : "Erro: tente novamente";
  }
}

class ClienteServiceDelete {
  static Future<String> Delete(Cliente cliente) async {
    final response = await http.post(url, body: {
      'funcao': 'delete',
      'id': cliente.id,
    });
    return response.statusCode == 200
        ? "Apagado com sucesso"
        : "Erro: tente novamente";
  }
}
