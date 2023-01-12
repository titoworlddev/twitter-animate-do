import 'dart:math';

import 'package:flutter/material.dart';

import 'src/pages/navegacion_page.dart';
import 'src/pages/pagina1_page.dart';
import 'src/pages/twitter_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Diseños App',
      home: HomePage(
        routes: {
          'Pagina1Page': Pagina1Page(),
          'TwitterPage': TwitterPage(),
          'NavegacionPage': NavegacionPage(),
        },
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final Map<String, Widget> routes;

  const HomePage({super.key, required this.routes});

  @override
  Widget build(BuildContext context) {
    final rnd = Random();
    final r = rnd.nextInt(255);
    final g = rnd.nextInt(255);
    final b = rnd.nextInt(255);

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Curso flutter intermedio diseños',
              style: TextStyle(
                  color: ((r + g + b) < 400) ? Colors.white : Colors.black)),
          backgroundColor: Color.fromRGBO(r, g, b, 1),
        ),
        body: _MenuPrincipal(
          routes: routes,
        ));
  }
}

class _MenuPrincipal extends StatelessWidget {
  final Map<String, Widget> routes;

  const _MenuPrincipal({required this.routes});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: routes.length,
        itemBuilder: (context, index) {
          return _MenuPrincipalBoton(routes: routes, index: index);
        },
      ),
    );
  }
}

class _MenuPrincipalBoton extends StatelessWidget {
  final Map<String, Widget> routes;
  final int index;

  const _MenuPrincipalBoton({
    required this.routes,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final rnd = Random();
    final r = rnd.nextInt(255);
    final g = rnd.nextInt(255);
    final b = rnd.nextInt(255);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
              builder: (BuildContext context) =>
                  routes.values.elementAt(index)),
        );
      },
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(10),
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(50)),
            color: Color.fromRGBO(r, g, b, 1),
            boxShadow: const [
              BoxShadow(color: Colors.black38, blurRadius: 10, spreadRadius: -5)
            ]),
        child: Text(
          routes.keys.elementAt(index),
          style: TextStyle(
              color: ((r + g + b) < 400) ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
