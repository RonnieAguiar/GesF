import 'package:flutter/material.dart';
import 'package:medicao/components/menu_widget.dart';
import 'package:medicao/routes/app_routes.dart';

class MenuInicial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          ('Gestor Fantini').toUpperCase(),),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: GridView.count(
          crossAxisCount: 2,
          primary: false,
          padding: EdgeInsets.all(10),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: [
            MenuItem(
              nome: 'clientes',
              icone: Icons.apartment_outlined,
              route: AppRoutes.CLIENTES,
            ),
            MenuItem(
              nome: 'contatos',
              icone: Icons.people_alt,
              route: AppRoutes.CONTATOS,
            ),
            MenuItem(
              nome: 'medição',
              icone: Icons.square_foot_outlined,
            ),
            MenuItem(
              nome: 'parâmetros',
              icone: Icons.settings_outlined,
            ),
          ],
        ),
      ),
    );
  }
}
