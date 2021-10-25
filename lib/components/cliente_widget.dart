import 'package:flutter/material.dart';
import 'package:medicao/models/cliente_model.dart';
import 'package:medicao/provider/provider_clientes.dart';
import 'package:medicao/routes/app_routes.dart';
import 'package:provider/provider.dart';

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
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    AppRoutes.CLIENTE_FORM,
                    arguments: cliente,
                  );
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.red.shade700,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text(
                        "Excluir Cliente",
                        style: TextStyle(color: Colors.red.shade700),
                      ),
                      content: Text("Confirma exclusão?"),
                      actions: [
                        TextButton(
                          child: Text("Não"),
                          onPressed: () => Navigator.of(context).pop(false),
                        ),
                        TextButton(
                          child: Text("Sim"),
                          onPressed: () => Navigator.of(context).pop(true),
                        )
                      ],
                    ),
                  ).then((confirmed) {
                    if (confirmed) {
                      Provider.of<Clientes>(context, listen: false)
                          .remove(cliente);
                    }
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
