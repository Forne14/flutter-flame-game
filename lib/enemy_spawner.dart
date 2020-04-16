import 'package:flameproject/game_controller.dart';

import 'components/enemies.dart';

class EnemySpawner{
  final GameController gameController;
  //max time between spawns. 3000 milliseconds
  final int maxSpawnInterval = 3000;
  //min time between spawns 700 milliseconds
  final int minSpawnInterval = 700;
  //interval changes by 3
  final int intervalChange = 3;
  //maximum enemies on the screen
  final int maxEnemies = 20;
  //current interval we are at
  int currentInterval;

  int nextSpawn;

  EnemySpawner(this.gameController){
    initialise();
  }

  void initialise() {
    killAllEnemies();
    currentInterval = maxSpawnInterval;
    nextSpawn = DateTime.now().millisecondsSinceEpoch + currentInterval;
  }

  void update(double t){
    int now = DateTime.now().millisecondsSinceEpoch;
    if(gameController.enemies.length < maxEnemies && now >= nextSpawn){
      gameController.spawnEnemies(4);
      if(currentInterval > minSpawnInterval){
        currentInterval -= intervalChange;
        currentInterval -= (currentInterval * 0.1).toInt();
      }
      nextSpawn = now + currentInterval;
    }
  }


  void killAllEnemies(){
    //sets all enemies in the gamecontrollers enemy list to dead. the update meathod in the gamecontroller will then dispatch
    gameController.enemies.forEach((Enemy enemy)=> enemy.isDead = true);
  }
}