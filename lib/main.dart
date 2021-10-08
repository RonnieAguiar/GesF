import 'package:flutter/material.dart';
import 'package:medicao/components/theme.dart';
import 'package:medicao/provider/provider_clientes.dart';
import 'package:medicao/provider/users.dart';
import 'package:medicao/routes/routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Users(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Clientes(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'GesF',
        theme: GesFTheme().theme,
        routes: MyRoutes().routes,
      ),
    );
  }
}
