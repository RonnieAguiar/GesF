import 'package:medicao/routes/app_routes.dart';
import 'package:medicao/views/cliente_datailView.dart';
import 'package:medicao/views/cliente_form.dart';
import 'package:medicao/views/contato_listView.dart';
import 'package:medicao/views/cliente_listView.dart';
import 'package:medicao/views/menu_inicial.dart';


class MyRoutes {
  final routes = {
    AppRoutes.HOME: (_) => MenuInicial(),
    AppRoutes.CLIENTES: (_) => ClienteList(),
    AppRoutes.CLIENTESDETALHE: (_) => ClienteDetail(),
    AppRoutes.CLIENTE_FORM: (_) => ClienteForm(),
    AppRoutes.CONTATOS: (_) => ContatoList(),
  };
}
