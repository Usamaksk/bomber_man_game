import 'dart:async';

import 'package:bomber_man/botton.dart';
import 'package:bomber_man/pixel.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int numberofSquares = 130;
  int playerposition = 0;
  int bombposition = -1;
  List<int> barriers = [
    11,
    13,
    15,
    17,
    18,
    31,
    33,
    35,
    37,
    38,
    51,
    53,
    55,
    57,
    58,
    71,
    73,
    75,
    77,
    78,
    91,
    93,
    95,
    97,
    98,
    111,
    113,
    115,
    117,
    118
  ];

  List<int> boxes = [
    12,
    14,
    16,
    28,
    21,
    41,
    61,
    81,
    101,
    112,
    114,
    116,
    119,
    127,
    123,
    103,
    83,
    63,
    65,
    67,
    47,
    39,
    19,
    1,
    30,
    50,
    70,
    121,
    100,
    96,
    79,
    99,
    107,
    7,
    3,
  ];

  void moveup() {
    setState(() {
      if (playerposition - 10 >= 0 &&
          !barriers.contains(playerposition - 10) &&
          !boxes.contains(playerposition - 10)) {
        playerposition -= 10;
      }
    });
  }

  void moveleft() {
    setState(() {
      if (!(playerposition % 10 == 0) &&
          !barriers.contains(playerposition - 1) &&
          !boxes.contains(playerposition - 1)) {
        playerposition -= 1;
      }
    });
  }

  void moveright() {
    setState(() {
      if (!(playerposition % 10 == 9) &&
          !barriers.contains(playerposition + 1) &&
          !boxes.contains(playerposition + 1)) {
        playerposition += 1;
      }
    });
  }

  void movedown() {
    setState(() {
      if (playerposition + 10 < numberofSquares &&
          !barriers.contains(playerposition + 10) &&
          !boxes.contains(playerposition + 10)) {
        playerposition += 10;
      }
    });
  }

  List<int> fire = [-1];

  void placebomb() {
    setState(() {
      bombposition = playerposition;
      fire.clear();
      Timer(Duration(milliseconds: 1000), () {
        setState(() {
          fire.add(bombposition);
          fire.add(bombposition - 1);
          fire.add(bombposition + 1);
          fire.add(bombposition - 10);
          fire.add(bombposition + 10);
          fire.add(bombposition - 2);
          fire.add(bombposition + 2);
          fire.add(bombposition - 20);
          fire.add(bombposition + 20);
        });
        clearFire();
        bombposition = -1;
      });
    });
  }

  void clearFire() {
    setState(() {
      Timer(Duration(milliseconds: 500), () {
        setState(() {
          for (int i = 0; i < fire.length; i++) {
            if (boxes.contains(fire[i])) {
              boxes.remove(fire[i]);
            }
          }
          fire.clear();
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Column(
        children: [
          Expanded(
              flex: 2,
              child: Container(
                child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: numberofSquares,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 10),
                    itemBuilder: (BuildContext context, int index) {
                      if (fire.contains(index)) {
                        return MyPixels(
                            innerColor: Colors.red,
                          outerColor: Colors.red[900],
                        );
                      } else if (bombposition == index) {
                        return MyPixels(
                          innerColor: Colors.green,
                          outerColor: Colors.green[800],
                          child: Padding(
                            padding: EdgeInsets.all(4),
                            child: Image.asset(
                              "lib/images/bang.png",
                            ),
                          ),
                        );
                      } else if (playerposition == index) {
                        return MyPixels(
                          innerColor: Colors.green,
                          outerColor: Colors.green[800],
                          child: Padding(
                            padding: EdgeInsets.all(4),
                            child: Image.asset(
                              "lib/images/man.png",
                            ),
                          ),
                        );
                      } else if (barriers.contains(index)) {
                        return MyPixels(
                          innerColor: Colors.black,
                          outerColor: Colors.black,
                        );
                      } else if (boxes.contains(index)) {
                        return MyPixels(
                          innerColor: Colors.brown,
                          outerColor: Colors.brown[800],
                        );
                      } else {
                        return MyPixels(
                          innerColor: Colors.green,
                          outerColor: Colors.green[800],
                        );
                      }
                    }),
              )),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyButton(),
                  MyButton(
                    function: moveup,
                    color: Colors.grey,
                    child: Icon(
                      Icons.arrow_drop_up,
                      size: 70,
                    ),
                  ),
                  MyButton()
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyButton(
                    function: moveleft,
                    color: Colors.grey,
                    child: Icon(
                      Icons.arrow_left,
                      size: 70,
                    ),
                  ),
                  MyButton(
                    function: placebomb,
                    color: Colors.grey[700],
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Image.asset(
                        "lib/images/bomb.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  MyButton(
                    function: moveright,
                    color: Colors.grey,
                    child: Icon(
                      Icons.arrow_right,
                      size: 70,
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyButton(),
                  MyButton(
                    function: movedown,
                    color: Colors.grey,
                    child: Icon(
                      Icons.arrow_drop_down,
                      size: 70,
                    ),
                  ),
                  MyButton()
                ],
              )
            ],
          )),
        ],
      ),
    );
  }
}
