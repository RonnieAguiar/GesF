import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:medicao/models/cliente_model.dart';
import 'package:medicao/provider/provider_clientes.dart';
import 'package:medicao/routes/app_routes.dart';
import 'package:provider/provider.dart';

class ClienteTag extends StatelessWidget {
  final Cliente cliente;
  const ClienteTag(this.cliente);

  @override
  Widget build(BuildContext context) {
    final String endereco = cliente.logradouro +
        ", " +
        cliente.numero +
        ' - ' +
        cliente.bairro +
        ', ' +
        cliente.cidade +
        '/' +
        cliente.estado;

    return Card(
        color: Colors.blueGrey.shade50,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cliente.nome,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              Text(endereco),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
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
                                    onPressed: () =>
                                        Navigator.of(context).pop(false),
                                  ),
                                  TextButton(
                                    child: Text("Sim"),
                                    onPressed: () =>
                                        Navigator.of(context).pop(true),
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
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
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
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        IconButton(
                          icon: Icon(Icons.search, color: Colors.blue.shade800),
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                              AppRoutes.CLIENTESDETALHE,
                              arguments: cliente,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.location_on_outlined,
                            color: Colors.blue,
                          ),
                          onPressed: () => MapsLauncher.launchQuery(endereco),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
