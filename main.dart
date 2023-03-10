import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:snake/score.dart';
import 'package:snake/snake.dart';

void main() {
  runApp(const myApp());
}

class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'main': (context) => myApp(),
        'snake': (context) => const Snakie(),
        'score': (context) => score(),
      },
      initialRoute: 'main',
      debugShowCheckedModeBanner: true,
      home: Scaffold(
        backgroundColor: Color(121212),
        body: Menu(),
      ),
    );
  }
}

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(121212),
      body: Column(
        children: [
          Container(
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(0, 110.0, 0.0, 0.0),
                  child: Text(
                    'The Snake 🐍',
                    style: GoogleFonts.nunito(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 200,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(30.0, 0.0, 0.0, 0.0),
            height: 50,
            width: 300,
            child: Material(
              borderRadius: BorderRadius.circular(10.0),
              shadowColor: Colors.greenAccent,
              color: Colors.green,
              elevation: 7.0,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'snake');
                },
              child: Center(
                child: Text('Nouvelle Partie',
                style: GoogleFonts.nunito(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
                ),
              ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(30.0, 40.0, 0.0, 0.0),
            height: 50,
            width: 300,
            child: Material(
              borderRadius: BorderRadius.circular(10.0),
              shadowColor: Colors.greenAccent,
              color: Colors.green,
              elevation: 7.0,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'snake');
                },
              child: Center(
                child: Text('Scores',
                style: GoogleFonts.nunito(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
                ),
              ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
