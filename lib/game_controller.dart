import 'dart:math';
import 'dart:ui';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flameproject/components/healthbar.dart';
import 'package:flameproject/components/score.dart';
import 'package:flameproject/state.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/enemies.dart';
import 'components/player.dart';
import 'enemy_spawner.dart';

class GameController extends Game{
  final SharedPreferences storage;

  Random rnd;

  //vars to hold size values
  Size _screenSize;
  double _tileSize;


  //holds player data
  Player player;
  List<Enemy> enemies;
  HealthBar healthbar;
  EnemySpawner enemySpawner;
  ScoreText scoretext;
  int score;

  GameState state;

  GameController(this.storage){
    initialise();
  }

  get width => screensize.width;

  void initialise() async {
    resize(await Flame.util.initialDimensions());
    state = GameState.menu;
    rnd = Random();
    player = Player(this);
    enemies = List();
    healthbar = HealthBar(this);
    enemySpawner = EnemySpawner(this);
    score = 0;
    scoretext = ScoreText(this);
  }

  //order in which these objects are called into the render matter.
  @override
  void render(Canvas canvas) {
    // TODO: implement render
    Rect _backgroundRect = Rect.fromLTWH(0, 0, _screenSize.width, _screenSize.height);
    Paint _backgroundPaint = Paint()..color = Color(0xFFFAFAFA);
    canvas.drawRect(_backgroundRect, _backgroundPaint);
    player.render(canvas);
    if(state == GameState.menu){

    }
    enemies.forEach((Enemy enemy) => enemy.render(canvas));
    healthbar.render(canvas);
    scoretext.render(canvas);
  }

  @override
  void update(double t) {
    // TODO: implement update
    enemySpawner.update(t);
    enemies.forEach((Enemy enemy) => enemy.update(t));
    enemies.removeWhere((Enemy enemy) => enemy.isDead);
    healthbar.update(t);
    scoretext.update(t);
    player.update(t);
    if(player.isDead){
      initialise();
    }
  }

  void resize(Size size){
    //todo implement resize
    _screenSize = size;
    _tileSize = _screenSize.width / 10;
  }

  void onTapDown(TapDownDetails details){
    enemies.forEach((Enemy enemy) => enemy.accrueDamage(1));
  }

  void spawnEnemies(int numberOfEnemies){
    for(int i = 0; i < numberOfEnemies; i++){
      double x, y;
      switch(rnd.nextInt(4)){
        case 0:
        //top
          x = rnd.nextDouble() * screensize.width;
          y = -tilesize * 2.5;
          break;
        case 1:
        //right
          x = screensize.width * tilesize * 2.5;
          y = rnd.nextDouble() * screensize.height;
          break;
        case 2:
        //bottom
          x = rnd.nextDouble() * screensize.width;
          y = screensize.height * tilesize * 2.5;
          break;
        case 3:
          x = -tilesize * 2.5;
          y = rnd.nextDouble() * screensize.height;
          break;
      }
      enemies.add(Enemy(this, x, y));
    }
  }


  //getter for tilesize
  get tilesize =>  _tileSize;

  //getter for screensize
  get screensize => _screenSize;

}