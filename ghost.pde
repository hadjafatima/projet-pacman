// ------------------------------------------------------------
// Classe Ghost : représente un fantôme avec intelligence artificielle
// ------------------------------------------------------------
class Ghost {

  float x, y;          // position pixel 
  int cellX, cellY;    // position cellule
  int cellSize;
  color ghostColor;
  float speed;
  int dirX = 0;        
  int dirY = 0;
  
  String name;         // "Blinky", "Pinky", "Inky" ou "Clyde"
  boolean eaten = false; 

  Ghost(Board board, int startX, int startY, int cellSize, color ghostColor, float speed, String name) {
    this.cellX = startX; 
    this.cellY = startY; 
    this.cellSize = cellSize;
    this.ghostColor = ghostColor;
    this.speed = speed;
    this.name = name; // Affectation du comportement
    
    // Positionnement initial au centre de la case
    this.x = board._position.x + cellX * cellSize + cellSize/2;
    this.y = board._position.y + cellY * cellSize + cellSize/2;
  }

  void reset(Board board) {
    this.cellX = 11; 
    this.cellY = 10; 
    this.x = board._position.x + cellX * cellSize + cellSize/2; 
    this.y = board._position.y + cellY * cellSize + cellSize/2; 
    this.eaten = false; 
    this.dirX = 0;
    this.dirY = 0;
  }

  void update(Board board, Hero pacman) {
    // 1. Calcul du centre de la cellule actuelle
    float cx = board._position.x + cellX * cellSize + cellSize/2;
    float cy = board._position.y + cellY * cellSize + cellSize/2;

    // On ne change de direction QUE si on est proche du centre
    if (abs(x - cx) < speed && abs(y - cy) < speed) {
      x = cx; // On force la position au centre exact
      y = cy;
      
      // On choisit la nouvelle direction ici
      chooseDirection(board, pacman);
      
      // ANTICIPATION : Si la direction choisie tape un mur immédiatement, on stoppe
      int nx = cellX + dirX;
      int ny = cellY + dirY;
      
      // On vérifie si c'est un tunnel pour ne pas bloquer à l'entrée
      boolean isTunnel = (nx < 0 || nx >= board._nbCellsY);
      if (!isTunnel && board.getTypeCell(nx, ny) == TypeCell.WALL) {
        dirX = 0;
        dirY = 0;
      }
    }

    // 2. Déplacement (seulement si la voie est libre)
    x += dirX * speed;
    y += dirY * speed;

    // --- TÉLÉPORTATION TUNNEL ---
    float limitLeft = board._position.x;
    float limitRight = board._position.x + (board._nbCellsY * cellSize);

    // Si le fantôme sort complètement à gauche
    if (x < limitLeft - cellSize/2) {
        x = limitRight + cellSize/2;
    } 
    // Si le fantôme sort complètement à droite
    else if (x > limitRight + cellSize/2) {
        x = limitLeft - cellSize/2;
    }

    // --- MISE À JOUR SÉCURISÉE DES CELLULES ---
    cellX = floor((x - board._position.x) / cellSize);
    cellY = floor((y - board._position.y) / cellSize);

    // Empêcher les crashs d'indexation
    if (cellX < 0) cellX = 0;
    if (cellX >= board._nbCellsY) cellX = board._nbCellsY - 1;
    if (cellY < 0) cellY = 0;
    if (cellY >= board._nbCellsX) cellY = board._nbCellsX - 1;
  }

  void chooseDirection(Board board, Hero pacman) {
  int[][] dirs = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}};
  float bestDist = 1000000;
  int nextDX = 0;
  int nextDY = 0;
  boolean foundPath = false;

  // 1. On cherche d'abord la meilleure direction vers Pac-Man sans faire demi-tour
  for (int[] d : dirs) {
    int nx = cellX + d[0];
    int ny = cellY + d[1];

    boolean isTunnel = (nx < 0 || nx >= board._nbCellsY);
    if (isTunnel || board.getTypeCell(nx, ny) != TypeCell.WALL) {
      
      // On ignore le demi-tour ici
      if (!(d[0] == -dirX && d[1] == -dirY)) {
        float dCible = dist(nx, ny, pacman._cellX, pacman._cellY);
        if (dCible < bestDist) {
          bestDist = dCible;
          nextDX = d[0];
          nextDY = d[1];
          foundPath = true;
        }
      }
    }
  }

  // 2. SÉCURITÉ : Si on est dans un cul-de-sac (foundPath est resté false)
  // on force le fantôme à faire demi-tour au lieu de s'arrêter
  if (!foundPath) {
    nextDX = -dirX;
    nextDY = -dirY;
    
    // Si même le demi-tour est bloqué (ne devrait pas arriver), on cherche n'importe quelle case vide
    if (board.getTypeCell(cellX + nextDX, cellY + nextDY) == TypeCell.WALL) {
       for (int[] d : dirs) {
         if (board.getTypeCell(cellX + d[0], cellY + d[1]) != TypeCell.WALL) {
           nextDX = d[0]; nextDY = d[1];
           break;
         }
       }
    }
  }

  dirX = nextDX;
  dirY = nextDY;
}

  void drawIt() {
    if (superMode && !eaten) {
      fill(0, 0, 255); // Bleu en super mode
    } else {
      fill(ghostColor);
    }
    noStroke(); 
    ellipseMode(CENTER); 
    ellipse(x, y, cellSize * 0.8, cellSize * 0.8);
  }
}
