import 'dart:ui';

import 'package:flameproject/game_controller.dart';

class Player {
  final GameController gameController;
  int maxhealth;
  int currentHealth;
  Rect playerRect;
  bool isDead = false;

  Player(this.gameController){
    maxhealth = currentHealth = 300;
    //size of player is 1.5 the size of a game tile which is itself
    // the tenth the size of of the screen
    final _size = gameController.tilesize * 1.5;
    //create rect object
    playerRect = Rect.fromLTWH(
        gameController.screensize.width / 2 - _size / 2,
        gameController.screensize.height / 2 - _size / 2,
        _size,
        _size
    );
  }
  void render(Canvas canvas){
    Paint colour = Paint()..color = Color(0xFF0000FF);
    canvas.drawRect(playerRect, colour);
  }

  void update(double t){

  }

}