import 'dart:math';

import 'package:flutter/material.dart';
import 'package:medicao/models/cliente_model.dart';
import 'package:medicao/services/clientes_service.dart';

class Clientes with ChangeNotifier {
  final _items = await ClienteServerList.getClienteList();

  List<Cliente> get all {
    return _items.values;
  }

  int get count {
    return _items.length;
  }

  Cliente byIndex(int i) {
    return _items.values.elementAt(i);
  }

  void put(Cliente cliente) {
    if (cliente.id != -1 && _items.containsKey(cliente.id)) {
      _items.update(cliente.id, (_) => cliente);
    } else {
      final id = Random().nextInt(1000);
      _items.putIfAbsent(
        id,
        () => Cliente(
          id: id,
          nome: cliente.nome,
          cep: cliente.cep,
          logradouro: cliente.logradouro,
          numero: cliente.numero,
          cidade: cliente.cidade,
          estado: cliente.estado,
          bairro: cliente.bairro,
        ),
      );
    }

    notifyListeners();
  }

  void remove(Cliente cliente) {
    _items.remove(cliente.id);
    notifyListeners();
  }
}
