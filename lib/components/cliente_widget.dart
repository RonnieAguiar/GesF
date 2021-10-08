import 'package:flutter/material.dart';
import 'package:medicao/models/cliente_model.dart';

class ClienteTag extends StatelessWidget {
  final Cliente cliente;
  const ClienteTag(this.cliente);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(cliente.nome),
        subtitle: Text(cliente.logradouro +
            ", " +
            cliente.numero +
            ' - ' +
            cliente.bairro),
        trailing: Container(
          width: 80,
          child: Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Colors.green,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
