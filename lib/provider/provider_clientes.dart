import 'package:flutter/material.dart';
import 'package:medicao/models/cliente_model.dart';
import 'package:medicao/services/clientes_service.dart';

class Clientes with ChangeNotifier {
  final List<Cliente> _items = ClienteServerList().getCliente() as List<Cliente>;

  List<Cliente> get all {
    print(_items);
    return [..._items];
  }

  int get count {
    return _items.length;
  }

  Cliente byIndex(int i) {
    return _items.elementAt(i);
  }

  void put(Cliente cliente) {
    ClienteServerPut.Update(cliente);
    notifyListeners();
  }

  void remove(Cliente cliente) {
    ClienteServiceDelete.Delete(cliente);
    notifyListeners();
  }
}
