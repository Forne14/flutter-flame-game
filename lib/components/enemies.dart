import 'dart:ui';

import 'package:flameproject/game_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' ;

class Enemy{

  final GameController gameController;
  int health;
  int damage;
  double speed;
  Rect enemyRect;
  bool isDead = false;

  Enemy(this.gameController, double xPosition, double yPosition){
    health = 3;
    damage = 2;
    speed = gameController.tilesize * 2;
    enemyRect = Rect.fromLTWH(
        xPosition,
        yPosition,
        gameController.tilesize * 1.2,
        gameController.tilesize * 1.2);
  }

  void render(Canvas canvas){
    Color colour;
    switch(health){
      case 3:
        colour = Colors.amber;
        break;
      case 2:
        colour = Colors.deepOrangeAccent;
        break;
      case 1:
        colour = Colors.red;
        break;
      default:
        colour = Colors.black54;
        break;
    }
    Paint enemyPaint = Paint()..color = colour;
    canvas.drawRect(enemyRect, enemyPaint);
  }

  void update(double t){
    if(!isDead){
      double stepDistance = speed * t;
      Offset toPlayer = gameController.player.playerRect.center - enemyRect.center;
      if(stepDistance <= toPlayer.distance - gameController.tilesize * 1.25){
        Offset stepToPlayer = Offset.fromDirection(toPlayer.direction, stepDistance);
        enemyRect = enemyRect.shift(stepToPlayer);
      }else{
        attack();
      }
    }
  }

  void attack(){
    if(!gameController.player.isDead){
      gameController.player.accrueDamage(1);
    }
  }

  void accrueDamage(int damage){
    if(!isDead){
      health = health - damage;
      if(health <= 0){
        isDead = true;
        gameController.score += 1;
        if(gameController.score > gameController.storage.getInt('Highscore ') ?? 0){
          gameController.storage.setInt('Highscore ', gameController.score);
        }
      }
    }else{
      return null;
    }
  }

}