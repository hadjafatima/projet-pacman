// ------------------------------------------------------------
// Classe Game : ancienne structure du jeu
// ------------------------------------------------------------
// NOTE : Cette classe n'est plus utilisée comme moteur principal,
// mais on la garde propre pour éviter les erreurs de compilation.
// ------------------------------------------------------------

class Game {

  Board _board;
  Hero _hero;
  int _score;

  // Le superMode global est utilisé ici aussi
  // pour éviter les erreurs d'appel à drawIt(superMode)
  Game() {
    _board = new Board(new PVector(0, 0), 30);
    _hero = new Hero(_board, 30);
    _score = 0;
  }

  // ------------------------------------------------------------
  // Mise à jour du héros
  // ------------------------------------------------------------
  void update() {
    _hero.update(_board);
  }

  // ------------------------------------------------------------
  // Dessin du plateau + héros
  // ------------------------------------------------------------
  void drawIt(boolean superMode) {

    // IMPORTANT : on passe superMode à Board
    _board.drawIt(superMode);

    // Dessin du héros
    _hero.drawIt();

    // Affichage du score
    fill(255);
    textSize(20);
    text("Score : " + _score, 10, height - 10);
  }

  // ------------------------------------------------------------
  // Gestion des touches
  // ------------------------------------------------------------
  void handleKey(int k, int kcode) {

    // ZQSD
    if (k == 'z') _hero.setNextDirection(0, -1);
    if (k == 's') _hero.setNextDirection(0, 1);
    if (k == 'q') _hero.setNextDirection(-1, 0);
    if (k == 'd') _hero.setNextDirection(1, 0);

    // Flèches
    if (k == CODED) {
      if (kcode == UP)    _hero.setNextDirection(0, -1);
      if (kcode == DOWN)  _hero.setNextDirection(0, 1);
      if (kcode == LEFT)  _hero.setNextDirection(-1, 0);
      if (kcode == RIGHT) _hero.setNextDirection(1, 0);
    }
  }
}
