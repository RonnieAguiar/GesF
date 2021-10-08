import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final String nome;
  final IconData icone;
  final String route;

  const MenuItem({
    @required this.nome,
    @required this.icone,
    this.route,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        route == null
            ? print(Text('Sem caminho!'))
            : Navigator.of(context).pushNamed(route);
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: route == null ? Colors.black12 : const Color(0xffDAA520),
        ),
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(
              icone,
              size: 40.0,
            ),
            Text(
              nome.toUpperCase(),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
