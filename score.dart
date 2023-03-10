import 'package:flutter/material.dart';

void main() {
  runApp(score());
}

class score extends StatelessWidget {
  const score({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Gscores(),
    );
  }
}

class Gscores extends StatefulWidget {
  const Gscores({super.key});

  @override
  State<Gscores> createState() => _GscoresState();
}

class _GscoresState extends State<Gscores> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Bonjour'),
    );
  }
}
