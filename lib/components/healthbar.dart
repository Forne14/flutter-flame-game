import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' ;
import '../game_controller.dart';

class HealthBar {
  final GameController gameController;
  Rect healthBarRect;
  Rect remainingHealthRect;

  HealthBar(this.gameController){
    double barWidth = gameController.screensize.width / 1.75;
    healthBarRect = Rect.fromLTWH(
        gameController.width / 2 - barWidth / 2,
        gameController.screensize.height * 0.19,
        barWidth,
        gameController.tilesize * 0.5);
    remainingHealthRect = Rect.fromLTWH(
        gameController.width / 2 - barWidth / 2,
        gameController.screensize.height * 0.19,
        barWidth,
        gameController.tilesize * 0.5);
  }

  void render(Canvas canvas){
    Paint healthBarPaint = Paint()..color = Colors.red;
    Paint remainingHealthBatPaint = Paint()..color = Colors.green;
    canvas.drawRect(healthBarRect, healthBarPaint);
    canvas.drawRect(remainingHealthRect, remainingHealthBatPaint);

  }
  void update(double t){
   double barWidth = gameController.screensize.width / 1.75;
   double percentageHealth = gameController.player.currentHealth /  gameController.player.maxhealth;
   remainingHealthRect = Rect.fromLTWH(
       gameController.width / 2 - barWidth / 2,
       gameController.screensize.height * 0.19,
       barWidth * percentageHealth,
       gameController.tilesize * 0.5);
  }
}