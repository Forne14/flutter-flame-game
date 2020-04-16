import 'package:flutter/cupertino.dart';
import 'package:flameproject/game_controller.dart';
import 'package:flutter/material.dart';
class ScoreText{
  final GameController gamecontroller;
  TextPainter painter;
  Offset position;

  ScoreText(this.gamecontroller){
    painter = TextPainter(textAlign: TextAlign.center, textDirection: TextDirection.ltr,);
    position = Offset.zero;
  }

  void render(Canvas canvas){
    painter.paint(canvas, position);
  }

  void update(double t){
    if((painter.text ?? ' ') != gamecontroller.score.toString()){
      painter.text = TextSpan(
        text: gamecontroller.score.toString(),
        style: TextStyle(
          color: Colors.black,
          fontSize: 70.0,
        ),
      );
      painter.layout();

      position = Offset(
          (gamecontroller.screensize.width / 2) - (painter.width / 2),
          (gamecontroller.screensize.height * 0.85) - (painter.height / 2),
      );
    }
  }

}