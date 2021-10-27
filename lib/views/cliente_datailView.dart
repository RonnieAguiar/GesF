import 'package:flutter/material.dart';
import 'package:medicao/models/cliente_model.dart';
import 'package:maps_launcher/maps_launcher.dart';

class ClienteDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    final cliente = args as Cliente;

    return Scaffold(
      appBar: AppBar(
        title: Text("Contatos do Cliente"),
        actions: [
          IconButton(
            icon: Icon(Icons.group_add),
            onPressed: () {},
          ),
        ],
      ),
      body: Card(
        color: Colors.blueGrey.shade50,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
                title: Text(cliente.nome),
                subtitle: Text(Cliente.enderecador(cliente)),
                trailing: IconButton(
                  icon: Icon(
                    Icons.location_on_outlined,
                    color: Colors.blue,
                  ),
                  onPressed: () => MapsLauncher.launchQuery(Cliente.enderecador(cliente)),
                )),
          ],
        ),
      ),
    );
  }
}
