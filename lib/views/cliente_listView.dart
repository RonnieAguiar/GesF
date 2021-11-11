import 'package:flutter/material.dart';
import 'package:medicao/components/cliente_widget.dart';
import 'package:medicao/models/cliente_model.dart';
import 'package:medicao/routes/app_routes.dart';
import 'package:medicao/services/clientes_service.dart';

class ClienteList extends StatefulWidget {
  @override
  State<ClienteList> createState() => _ClienteListState();
}

class _ClienteListState extends State<ClienteList> {
  final clienteKey = GlobalKey<_ClienteListState>();
  Future<List<Cliente>>? clientes;

  @override
  void initState() {
    super.initState();
    clientes = ClienteServerList.getClienteList();
    print(clientes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: clienteKey,
      appBar: AppBar(
        title: Text("Lista de Clientes"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.CLIENTE_FORM);
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Cliente>>(
        future: clientes,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(
                color: Colors.red[100],
              ),
            );
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (ctx, i) {
                return ClienteTag(snapshot.data[i]);
              });
        },
      ),
    );
  }
}
