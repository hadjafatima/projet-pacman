// ------------------------------------------------------------
// Type de chaque cellule du plateau
// ------------------------------------------------------------
enum TypeCell {
  EMPTY, WALL, DOT, SUPER_DOT, PAC
}

// ------------------------------------------------------------
// Classe Board : gère la carte, les murs, les gommes, etc.
// ------------------------------------------------------------
class Board {

  TypeCell _cells[][];
  PVector _position;

  int _nbCellsX;
  int _nbCellsY;
  int _cellSize;

  int _pacX;
  int _pacY;

  float _departX, _departY;

  // ------------------------------------------------------------
  // Constructeur général : charge un fichier de niveau
  // ------------------------------------------------------------
  Board(PVector position, int cellSize, String levelFile) {

    _position = position;
    _cellSize = cellSize;

    // Charger le fichier du niveau
    String[] map = loadStrings(levelFile);

    // Dimensions du plateau
    _nbCellsX = map.length - 1;      // lignes
    _nbCellsY = map[1].length();     // colonnes

    println("Chargement :", levelFile, " → ", _nbCellsX, "x", _nbCellsY);

    // Allocation du tableau
    _cells = new TypeCell[_nbCellsX][_nbCellsY];

    // Lecture ligne par ligne
    for (int j = 0; j < _nbCellsX; j++) {

      String cur_line = map[j + 1];

      for (int i = 0; i < _nbCellsY; i++) {

        char c = cur_line.charAt(i);

        if (c == 'V') {
          _cells[j][i] = TypeCell.EMPTY;
        }
        else if (c == 'x') {
          _cells[j][i] = TypeCell.WALL;
        }
        else if (c == 'o') {
          _cells[j][i] = TypeCell.DOT;
        }
        else if (c == 'O') {
          _cells[j][i] = TypeCell.SUPER_DOT;
        }
        else if (c == 'P') {
          _cells[j][i] = TypeCell.PAC;

          // Position initiale de Pac-Man
          _pacY = j;
          _pacX = i;

          _departX = _position.x + (i * _cellSize);
          _departY = _position.y + (j * _cellSize);
        }
        else {
          _cells[j][i] = TypeCell.EMPTY;
        }
      }
    }
  }

  // ------------------------------------------------------------
  // Constructeur par défaut → charge automatiquement level1.txt
  // ------------------------------------------------------------
  Board(PVector position, int cellSize) {
    this(position, cellSize, "levels/level" + level + ".txt");
  }

  // ------------------------------------------------------------
  // Récupérer le type d'une case
  // ------------------------------------------------------------
  TypeCell getTypeCell(int x, int y) {

    // Hors limites → mur
    if (x < 0 || x >= _nbCellsY || y < 0 || y >= _nbCellsX) {
      return TypeCell.WALL;
    }

    return _cells[y][x];
  }

  // ------------------------------------------------------------
  // Modifier une case
  // ------------------------------------------------------------
  void setCellType(int x, int y, TypeCell type) {
    if (x >= 0 && x < _nbCellsY && y >= 0 && y < _nbCellsX) {
      _cells[y][x] = type;
    }
  }

  // ------------------------------------------------------------
  // Dessin du plateau
  // ------------------------------------------------------------
  void drawIt(boolean superMode) {

    TypeCell c;
    float px, py;

    for (int x = 0; x < _nbCellsY; x++) {
      for (int y = 0; y < _nbCellsX; y++) {

        c = _cells[y][x];

        px = _position.x + x * _cellSize;
        py = _position.y + y * _cellSize;

        // Fond noir
        fill(0);
        noStroke();
        rect(px, py, _cellSize, _cellSize);

        // Affichage selon type
        if (c == TypeCell.WALL) {

          if (superMode) fill(255);
          else fill(0, 0, 255);

          strokeWeight(5);
          stroke(0);
          rect(px, py, _cellSize, _cellSize);
        }

        else if (c == TypeCell.DOT) {
          fill(255, 0, 100);
          ellipse(px + _cellSize/2, py + _cellSize/2, _cellSize/4, _cellSize/4);
        }

        else if (c == TypeCell.SUPER_DOT) {
          fill(255, 0, 100);
          ellipse(px + _cellSize/2, py + _cellSize/2, _cellSize/2, _cellSize/2);
        }
      }
    }
  }

  // ------------------------------------------------------------
  // Vérifier s'il reste des gommes
  // ------------------------------------------------------------
  boolean hasDotsLeft() {
    for (int y = 0; y < _nbCellsX; y++) {
      for (int x = 0; x < _nbCellsY; x++) {
        if (_cells[y][x] == TypeCell.DOT || _cells[y][x] == TypeCell.SUPER_DOT) {
          return true;
        }
      }
    }
    return false;
  }
}
