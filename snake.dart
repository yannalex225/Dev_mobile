
// ignore_for_file: non_constant_identifier_names

import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main(){
  runApp(const Snakie());
}
class Snakie extends StatelessWidget {
  const Snakie({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Snake(),
      ),
    );
  }
}

class Snake extends StatefulWidget {
  const Snake({Key? key}) : super(key: key);

  @override
  State<Snake> createState() => _SnakeState();
}

class _SnakeState extends State<Snake> {
  final int carParLigne = 20;
  final int carParColonne = 40;
  final fontStyle = const TextStyle(color: Colors.white, fontSize: 30);
  final randomGen = Random();
  var snake = [
    [0, 1],
    [0, 0]
  ];
  var food = [0, 2];
  var direction = 'up';
  var isPlaying = false;

  void StartGame() {
    const duree = Duration(milliseconds: 500);
    snake = [
      [(carParLigne / 2).floor(), (carParColonne / 2).floor()]
    ];
    snake.add([snake.first[0], snake.first[1] + 1]);
    createFood();
    isPlaying = true;
    Timer.periodic(duree, (Timer timer) {
      movesnake();
      if (checkGameOver()) {
        timer.cancel();
        endGame();
      }
    });
  }

  movesnake() {
    setState(() {
      switch (direction) {
        case 'up':
          snake.insert(0, [snake.first[0], snake.first[1] - 1]);
          break;
        case 'down':
          snake.insert(0, [snake.first[0], snake.first[1] + 1]);
          break;
        case 'left':
          snake.insert(0, [snake.first[0] - 1, snake.first[1]]);
          break;
        case 'right':
          snake.insert(0, [snake.first[0] + 1, snake.first[1]]);
          break;
      }
      if (snake.first[0] == food[0] || snake.first[1] == food[1]) {
        snake.removeLast();
      } else {
        createFood();
      }
    });
  }

  createFood() {
    food = [
      randomGen.nextInt(carParLigne),
      randomGen.nextInt(carParColonne),
    ];
  }

  bool checkGameOver() {
    if (!isPlaying ||
        snake.first[0] < 0 ||
        snake.first[1] < 0 ||
        snake.first[0] > carParLigne ||
        snake.first[1] >= carParColonne) {
      return true;
    }

    for (int i = 0; i < snake.length; ++i) {
      if (snake[1][0] == snake.first[0] && snake[1][1] == snake.first[1]) {
        return true;
      }
    }

    return false;
  }

  void endGame() {
    isPlaying = false;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Game Over'),
          content: Text(
            'Score: ${snake.length - 2}',
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Fermer'))
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
              child: GestureDetector(
            onVerticalDragUpdate: ((details) {
              if (direction != 'up' && details.delta.dy > 0) {
                direction = 'down';
              } else if (direction != 'down' && details.delta.dy < 0) {
                direction = 'up';
              }
            }),
            onHorizontalDragUpdate: ((details) {
              if (direction != 'left' && details.delta.dx > 0) {
                direction = 'right';
              } else if (direction != 'right' && details.delta.dy < 0) {
                direction = 'left';
              }
            }),
            child: AspectRatio(
              aspectRatio: carParLigne / (carParColonne + 2),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: carParLigne),
                itemCount: carParLigne * carParColonne,
                itemBuilder: (BuildContext context, int index) {
                  var color;
                  var x = index % carParLigne;
                  var y = (index / carParLigne).floor();
                  bool isSnakeBody = false;
                  for (var pos in snake) {
                    if (pos[0] == x && pos[1] == y) {
                      isSnakeBody = true;
                      break;
                    }
                  }
                  if (snake.first[0] == x && snake.first[1] == y) {
                    color = Colors.green;
                  } else if (isSnakeBody) {
                    color = Color.fromRGBO(165, 214, 167, 1);
                  } else if (food[0] == x && food[1] == y) {
                    color = Colors.red;
                  } else {
                    color = Colors.grey[100];
                  }
                  return Container(
                    margin: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  );
                },
              ),
            ),
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: isPlaying ? Colors.red : Colors.blue,
                ),
                onPressed: () {
                  if (isPlaying) {
                    isPlaying = false;
                  } else {
                    StartGame();
                  }
                },
                child: Text(
                  isPlaying ? 'Fin' : 'Commencer',
                  style: GoogleFonts.nunito(),
                ),
              ),
              Container(
                child: Text('Score: ${max(snake.length - 2, 0)}'),
              )
            ],
          ),
        ],
      ),
    );
  }
}
