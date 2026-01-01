class Menu {

  Menu() {
  }

  void drawIt() {
    // Fond semi-transparent
    fill(0, 0, 0, 180);
    rect(0, 0, width, height);

    // Fenêtre centrale
    fill(50);
    rect(width/2 - 200, height/2 - 150, 400, 300, 20);

    fill(255);
    textAlign(CENTER, CENTER);
    textSize(32);
    text("Pause", width/2, height/2 - 100);

    textSize(22);
    text("1. Recommencer", width/2, height/2 - 30);
    text("2. Sauvegarder", width/2, height/2 + 10);
    text("3. Charger", width/2, height/2 + 50);
    text("4. Meilleurs scores", width/2, height/2 + 90);
    
    text("5. Quitter", width/2, height/2 + 130);
  }
}
