import 'dart:ui';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';

import 'components/player.dart';

class GameController extends Game{

  //vars to hold size values
  Size _screenSize;
  double _tileSize;

  //holds player data
  Player player;

  GameController(){
    initialise();
  }

  void initialise() async {
    resize(await Flame.util.initialDimensions());
    player = Player(this);
  }

  //order in which these objects are called into the render matter.
  @override
  void render(Canvas canvas) {
    // TODO: implement render
    Rect _backgroundRect = Rect.fromLTWH(0, 0, _screenSize.width, _screenSize.height);
    Paint _backgroundPaint = Paint()..color = Color(0xFFFAFAFA);
    canvas.drawRect(_backgroundRect, _backgroundPaint);
    player.render(canvas);
  }

  @override
  void update(double t) {
    // TODO: implement update

  }

  void resize(Size size){
    //todo implement resize
    _screenSize = size;
    _tileSize = _screenSize.width / 10;
  }

  void onTapDown(TapDownDetails details){
    print(details.globalPosition);
  }

  //getter for tilesize
  get tilesize =>  _tileSize;

  //getter for screensize
  get screensize => _screenSize;

}