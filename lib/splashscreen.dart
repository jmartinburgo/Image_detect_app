import 'package:flutter/material.dart';
import'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:first_app/home.dart';

class MySplash extends StatefulWidget {
  const MySplash({super.key});

  @override
  State<MySplash> createState() => _MySplashState();
}

class _MySplashState extends State<MySplash> {
  @override
  Widget build(BuildContext context) {
    return
      AnimatedSplashScreen(
        splash: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Classifer',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 16
              ),
              Image.asset(
                  'assets/Amarillo Negro Solo Tipografía Festival de Cine Evento Logotipo.png',
                width: 50,
                height: 50,

              ),
            ],

          ),
        ),
        splashTransition: SplashTransition.scaleTransition,
        backgroundColor: Colors.yellow,
        duration: 3000,

        nextScreen: Home(),
      );
  }
}
