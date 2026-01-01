// ------------------------------------------------------------
// Classe Hero : représente Pac-Man
// ------------------------------------------------------------
class Hero {
  // Position en pixels (sur l'écran)
  PVector _position;

  // Position en cellules (sur le plateau)
  int _cellX, _cellY;

  // Taille d'affichage de Pac-Man
  float _size = 30;

  // Infos du plateau
  int _cellSize;
  float _departX;
  float _departY;

  // Mouvement fluide
  PVector _direction = new PVector(0, 0);     // direction actuelle
  PVector _nextDirection = new PVector(0, 0); // direction voulue
  float _speed = 2.0;                         // pixels par frame

  // ------------------------------------------------------------
  // Constructeur
  // ------------------------------------------------------------
  Hero(Board plateau, int cellSize) {
    _cellSize = cellSize;
    _departX  = plateau._position.x;
    _departY  = plateau._position.y;

    // position initiale définie dans Board
    _cellX = plateau._pacX;
    _cellY = plateau._pacY;

    _position = new PVector(0, 0);
    updateposPac(); // calcule la position pixel initiale
  }

  // ------------------------------------------------------------
  // Définir la prochaine direction (appelée par keyPressed)
  // ------------------------------------------------------------
  void move(Board plateau, int dirX, int dirY) {
    _nextDirection.set(dirX, dirY);
  }

  // ------------------------------------------------------------
  // Mise à jour de la position pixel en fonction de la cellule
  // ------------------------------------------------------------
  void updateposPac() {
    _position.x = _departX + (_cellX * _cellSize) + (_cellSize / 2);
    _position.y = _departY + (_cellY * _cellSize) + (_cellSize / 2);
  }

  // ------------------------------------------------------------
  // Déplacement fluide
  // ------------------------------------------------------------
  /*void update(Board board) {
    // cellule actuelle estimée
    int cx = int((_position.x - _departX) / _cellSize);
    int cy = int((_position.y - _departY) / _cellSize);

    // centre de la cellule
    float centerX = _departX + cx * _cellSize + _cellSize/2;
    float centerY = _departY + cy * _cellSize + _cellSize/2;

    boolean isCentered =
      abs(_position.x - centerX) < 1 &&
      abs(_position.y - centerY) < 1;

    if (isCentered) {
      // recaler Pac-Man au centre exact
      _position.x = centerX;
      _position.y = centerY;

      // mettre à jour la cellule
      _cellX = cx;
      _cellY = cy;

      // manger une gomme si présente
      eatDot(board);

      // essayer de tourner (si la prochaine direction est libre)
      int nx = cx + int(_nextDirection.x);
      int ny = cy + int(_nextDirection.y);
      
      // Autoriser si ce n'est pas un mur OU si c'est en dehors des limites horizontales (tunnel)
boolean isWall = board.getTypeCell(nx, ny) == TypeCell.WALL;
boolean isTunnel = (nx < 0 || nx >= board._nbCellsY);

      if (!isWall || isTunnel) {
        _direction.set(_nextDirection);
      }

      // vérifier si on peut continuer dans la direction actuelle
      int tx = cx + int(_direction.x);
      int ty = cy + int(_direction.y);

      if (board.getTypeCell(tx, ty) == TypeCell.WALL) {
        _direction.set(0, 0); // stop si mur
      }
    }

    // déplacement fluide (pixels par frame)
    _position.x += _direction.x * _speed;
    _position.y += _direction.y * _speed;
    
    
    // --- AJOUT TÉLÉPORTATION ---
float minX = _departX + (_cellSize / 2);
float maxX = _departX + (board._nbCellsY - 1) * _cellSize + (_cellSize / 2);

if (_position.x < minX - _cellSize) {
    _position.x = maxX; // Sort à gauche, arrive à droite
} else if (_position.x > maxX + _cellSize) {
    _position.x = minX; // Sort à droite, arrive à gauche
}
  }*/
  
  
  // hero.pde

/*void update(Board board) {
  // 1. Calcul de la cellule actuelle et du centre [cite: 134, 135, 136]
  int cx = int((_position.x - _departX) / _cellSize);
  int cy = int((_position.y - _departY) / _cellSize);

  float centerX = _departX + cx * _cellSize + _cellSize/2;
  float centerY = _departY + cy * _cellSize + _cellSize/2;

  // Tolérance pour le centrage [cite: 137]
  boolean isCentered = abs(_position.x - centerX) < 2 && abs(_position.y - centerY) < 2;

  if (isCentered) {
    // Recalage au centre [cite: 138, 139]
    _position.x = centerX;
    _position.y = centerY;
    _cellX = cx;
    _cellY = cy;

    eatDot(board); // [cite: 140]

    // --- LOGIQUE DE TUNNEL ET TÉLÉPORTATION ---
    
    // Calcul de la cellule visée par la direction voulue (next) [cite: 141, 142]
    int nx = cx + int(_nextDirection.x);
    int ny = cy + int(_nextDirection.y);

    // Vérifier si la prochaine cellule est en dehors des limites (Tunnel)
    boolean isTunnelNext = (nx < 0 || nx >= board._nbCellsY);

    // On autorise le changement de direction si c'est le tunnel OU si ce n'est pas un mur
    if (isTunnelNext || board.getTypeCell(nx, ny) != TypeCell.WALL) {
      _direction.set(_nextDirection); // [cite: 142]
    }

    // Calcul de la cellule devant dans la direction actuelle [cite: 143, 144]
    int tx = cx + int(_direction.x);
    int ty = cy + int(_direction.y);
    
    boolean isTunnelCurrent = (tx < 0 || tx >= board._nbCellsY);

    // On s'arrête si on tape un mur, sauf si on est dans le tunnel
    if (!isTunnelCurrent && board.getTypeCell(tx, ty) == TypeCell.WALL) {
      _direction.set(0, 0); // [cite: 144]
    }
  }

  // 2. Mouvement fluide [cite: 145, 146]
  _position.x += _direction.x * _speed;
  _position.y += _direction.y * _speed;

  // 3. EXÉCUTION DE LA TÉLÉPORTATION
  // Calcul des limites physiques du plateau
  float limitLeft = _departX; 
  float limitRight = _departX + (board._nbCellsY * _cellSize);

  // Si Pac-Man dépasse totalement la limite gauche
  if (_position.x < limitLeft - _cellSize/2) {
    _position.x = limitRight + _cellSize/2;
  } 
  // Si Pac-Man dépasse totalement la limite droite
  else if (_position.x > limitRight + _cellSize/2) {
    _position.x = limitLeft - _cellSize/2;
  }
} */


// Dans hero.pde

void update(Board board) {
  // 1. Calcul de la cellule actuelle et du centre
  int cx = int((_position.x - _departX) / _cellSize);
  int cy = int((_position.y - _departY) / _cellSize);

  float centerX = _departX + cx * _cellSize + _cellSize/2;
  float centerY = _departY + cy * _cellSize + _cellSize/2;

  // Tolérance pour le centrage (indispensable pour le changement de direction)
  boolean isCentered = abs(_position.x - centerX) < 2 && abs(_position.y - centerY) < 2;

  if (isCentered) {
    // Recalage au centre exact pour éviter les décalages cumulés
    _position.x = centerX;
    _position.y = centerY;
    _cellX = cx;
    _cellY = cy;

    eatDot(board); 

    // --- LOGIQUE DE TUNNEL ET CHANGEMENT DE DIRECTION ---
    
    int nx = cx + int(_nextDirection.x);
    int ny = cy + int(_nextDirection.y);

    // Est-ce que la case visée est en dehors du plateau (Tunnel) ?
    boolean isTunnelNext = (nx < 0 || nx >= board._nbCellsY);

    // On autorise de tourner si c'est le tunnel OU si ce n'est pas un mur
    if (isTunnelNext || board.getTypeCell(nx, ny) != TypeCell.WALL) {
      _direction.set(_nextDirection);
    }

    // Vérification du chemin actuel (pour s'arrêter devant un mur)
    int tx = cx + int(_direction.x);
    int ty = cy + int(_direction.y);
    boolean isTunnelCurrent = (tx < 0 || tx >= board._nbCellsY);

    // On stoppe si on tape un mur, sauf si on est en train de sortir par le tunnel
    if (!isTunnelCurrent && board.getTypeCell(tx, ty) == TypeCell.WALL) {
      _direction.set(0, 0);
    }
  }

  // 2. Mouvement fluide
  _position.x += _direction.x * _speed;
  _position.y += _direction.y * _speed;

  // 3. LOGIQUE DE TÉLÉPORTATION SÉCURISÉE
  float limitLeft = _departX; 
  float limitRight = _departX + (board._nbCellsY * _cellSize);

  // Si Pac-Man sort à gauche
  if (_position.x < limitLeft) {
    _position.x = limitRight - _cellSize/2; // On le place au centre de la case la plus à droite
    _cellX = board._nbCellsY - 1;           // On force la mise à jour de sa cellule
  } 
  // Si Pac-Man sort à droite
  else if (_position.x > limitRight) {
    _position.x = limitLeft + _cellSize/2;  // On le place au centre de la case la plus à gauche
    _cellX = 0;                             // On force la mise à jour de sa cellule
  }
}
  

  // ------------------------------------------------------------
  // Dessin de Pac-Man
  // ------------------------------------------------------------
  void drawIt() {
    fill(255, 255, 0);
    noStroke();
    ellipseMode(CENTER);
    ellipse(_position.x, _position.y, _size, _size);
  }

  // ------------------------------------------------------------
  // Direction voulue (alternative à move)
  // ------------------------------------------------------------
  void setNextDirection(int dx, int dy) {
    _nextDirection.set(dx, dy);
  }

  // ------------------------------------------------------------
  // Manger les gommes
  // ------------------------------------------------------------
  int eatDot(Board board) {
    TypeCell c = board.getTypeCell(_cellX, _cellY);

    if (c == TypeCell.DOT) {
      board._cells[_cellY][_cellX] = TypeCell.EMPTY;
      _score += 10;
      return 10;
    }

    if (c == TypeCell.SUPER_DOT) {
      board._cells[_cellY][_cellX] = TypeCell.EMPTY;
      _score += 50;
       // --- ACTIVATION DU SUPER MODE ---
      superMode = true;
      superTimer = superDuration;

      return 50;
    }
    println("SUPER MODE ACTIVÉ !");

    return 0;
  }
}
