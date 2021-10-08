import 'package:flutter/material.dart';
import 'package:medicao/components/cliente_widget.dart';
import 'package:medicao/provider/provider_clientes.dart';
import 'package:provider/provider.dart';

class ClienteList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Clientes clientes = Provider.of(context);

    return Scaffold(
        appBar: AppBar(
          title: Text("Lista de Clientes"),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                
              },
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: clientes.count,
          itemBuilder: (ctx, i) => ClienteTag(clientes.byIndex(i)),
        ));
  }
}
