import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class NavegacionPage extends StatelessWidget {
  const NavegacionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _NotificationModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Notifications page'),
          backgroundColor: Colors.pink,
        ),
        floatingActionButton: const BotonFlotante(),
        bottomNavigationBar: const BottomNavigation(),
      ),
    );
  }
}

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final int numero = Provider.of<_NotificationModel>(context).numero;

    return BottomNavigationBar(
      currentIndex: 0,
      selectedItemColor: Colors.pink,
      items: [
        const BottomNavigationBarItem(
            label: 'Bones', icon: FaIcon(FontAwesomeIcons.bone)),
        BottomNavigationBarItem(
            label: 'Bell',
            icon: Stack(
              children: [
                const FaIcon(FontAwesomeIcons.bell),
                Positioned(
                    top: 0,
                    right: 0,
                    // child: Icon(Icons.brightness_1, size: 8, color: Colors.redAccent,)
                    child: BounceInDown(
                      from: 10,
                      animate: (numero > 0) ? true : false,
                      child: Bounce(
                        controller: (controller) =>
                            Provider.of<_NotificationModel>(context)
                                .bounceController = controller,
                        from: 5,
                        child: Container(
                          alignment: Alignment.center,
                          height: 14,
                          width: 14,
                          decoration: const BoxDecoration(
                              color: Colors.redAccent, shape: BoxShape.circle),
                          child: Text(
                            '$numero',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 9),
                          ),
                        ),
                      ),
                    ))
              ],
            )),
        const BottomNavigationBarItem(
            label: 'My Dog', icon: FaIcon(FontAwesomeIcons.dog)),
      ],
    );
  }
}

class BotonFlotante extends StatelessWidget {
  const BotonFlotante({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.pink,
      child: const FaIcon(
        FontAwesomeIcons.play,
      ),
      onPressed: () {
        final notiModel =
            Provider.of<_NotificationModel>(context, listen: false);
        int numero = notiModel.numero;
        numero++;
        notiModel.numero = numero;
        // notiModel.numero ++;
        if (numero >= 2) {
          final controller = notiModel.bounceController;
          controller.forward(from: 0.0);
        }
      },
    );
  }
}

class _NotificationModel with ChangeNotifier {
  int _numero = 0;

  int get numero => _numero;
  set numero(int valor) {
    _numero = valor;
    notifyListeners();
  }

  late AnimationController bounceController;
}
