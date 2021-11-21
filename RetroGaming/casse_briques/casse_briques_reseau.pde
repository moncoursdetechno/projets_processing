import processing.net.*;

Config config;

String HTTP_HEADER = "HTTP/1.0 200 OK\nContent-Type: text/html\n\n";
Server s;
Client c;
String msgClient="";
String Value="";
String Adresse="Essayez d'envoyer une requête";
int index=-1;
PFont font;
int r=0;


void setup() {
  size(800, 500);
  background(0, 0, 0);
  fill(255, 255, 255);
  setNiveau(round(random(1, 7)));
  s = new Server(this, 8080);
  font = createFont("COPRGTL.TTF", 20);
}


void draw() {
  background(0);
   ////////////////////////////////////////
    c = s.available();
     if (c != null) {
  Adresse="Ip Valide vous pouvez continuer";
  msgClient=c.readString();
   if( (msgClient.indexOf ("servo") != -1) && (msgClient.length()>=msgClient.indexOf ("servo")+7) ) {
       index=msgClient.indexOf ("servo");
    Value=msgClient.substring(index+6,index+7);
         if ( Value.charAt(0) == 'g' ) config.Left = true;
    else if ( Value.charAt(0) == 'h' ) config.Left = false;
    else if ( Value.charAt(0) == 'd' ) config.Right = true;
    else if ( Value.charAt(0) == 'f' ) config.Right = false;
    else if ( Value.charAt(0) == 's' ) config.Start = true;
   }
 }
  ////////////////////////////////////////
  print(intro);
  print(" ");
  println(game_over);
  
  if (intro == 1) {
    intro();
  } 
  else if (game_over == 0) {
    gameOver();
  } else {  
     ////////////////////////////////////////
    c = s.available();
     if (c != null) {
  Adresse="Ip Valide vous pouvez continuer";
  msgClient=c.readString();
   if( (msgClient.indexOf ("servo") != -1) && (msgClient.length()>=msgClient.indexOf ("servo")+7) ) {
       index=msgClient.indexOf ("servo");
    Value=msgClient.substring(index+6,index+7);
         if ( Value.charAt(0) == 'g' ) config.Left = true;
    else if ( Value.charAt(0) == 'h' ) config.Left = false;
    else if ( Value.charAt(0) == 'd' ) config.Right = true;
    else if ( Value.charAt(0) == 'f' ) config.Right = false;
    else if ( Value.charAt(0) == 's' ) config.Start = true;
   }
 }
  ////////////////////////////////////////
    
    afficheBric();
    barre();
    balle();
    test_num_brique();//test le nombre de brique restante
    afficheBonus();

    if (active_bonus == 1)activeBonus();
    //affichage du score
    fill(255, 255, 255);
    textSize(20);
    text("Score: "+score, 10, 480);
  } 
   
  
  if ((game_over == 0 || intro == 1)){
    intro=0; 
    game_over = 1;
    setNiveau(round(random(1, 7)));
    balleX = 400;
    balleY = 250;
  } 
}

void afficheBric() {
  for (int y = 0; y <= 4; y++) {
    for (int x = 0; x <= 9; x++) {
      if (niv[y][x] != 0 && niv[y][x] == 1)fill(255, 255, 255);
      if (niv[y][x] != 0 && niv[y][x] == 2)fill(0, 0, 255);
      if (niv[y][x] != 0 && niv[y][x] == 3)fill(0, 255, 0);
      if (niv[y][x] != 0 && niv[y][x] == 4)fill(255, 0, 0);

      if (niv[y][x] != 0)rect((x*80), (y*40), 78, 38);
    }
  }
}

void barre() {
  fill(255, 255, 255);
  rect(barX, barY-12, taille_bar, 10); c = s.available();
     if (c != null) {
  Adresse="Ip Valide vous pouvez continuer";
  msgClient=c.readString();
   if( (msgClient.indexOf ("servo") != -1) && (msgClient.length()>=msgClient.indexOf ("servo")+7) ) {
       index=msgClient.indexOf ("servo");
    Value=msgClient.substring(index+6,index+7);
         if ( Value.charAt(0) == 'g' ) config.Left = true;
    else if ( Value.charAt(0) == 'h' ) config.Left = false;
    else if ( Value.charAt(0) == 'd' ) config.Right = true;
    else if ( Value.charAt(0) == 'f' ) config.Right = false;
    else if ( Value.charAt(0) == 's' ) config.Start = true;
   }
 }
  


 // if (keyPressed == true) {
       
    if (config.Right == true ) barX += 5;
    if ( config.Left == true ) barX -= 5;      
 //}

  if (barX > (800 - taille_bar)) barX = 800-taille_bar;
  if (barX < 0) barX = 0;
}

void balle() {
  if (type_bonus == 3) fill(255, 0, 0);
  else fill(255, 255, 255);

  ellipse(balleX, balleY, 15, 15);

  int vitesseX = 1;
  int vitesseY = 1;

  if (angleBall == 1) {
    vitesseX = 3; 
    vitesseY = 1;
  }
  if (angleBall == 2) {
    vitesseX = 2; 
    vitesseY = 2;
  }
  if (angleBall == 3) {
    vitesseX = 1; 
    vitesseY = 3;
  }

  if (direc_ball == 1) {
    balleX += vitesseX;
    balleY += vitesseY;
  }
  if (direc_ball == 2) {
    balleX += vitesseX;
    balleY -= vitesseY;
  }
  if (direc_ball == 3) {
    balleX -= vitesseX;
    balleY -= vitesseY;
  }
  if (direc_ball == 4) {
    balleX -= vitesseX;
    balleY += vitesseY;
  }

  //mur haut
  if (balleY < 7 && direc_ball == 3)direc_ball = 4;
  if (balleY < 7 && direc_ball == 2)direc_ball = 1;

  //mur droit
  if (balleX > 793 && direc_ball == 2)direc_ball = 3;
  if (balleX > 793 && direc_ball == 1)direc_ball = 4;

  //mur gauche
  if (balleX < 7 && direc_ball == 3)direc_ball = 2;
  if (balleX < 7 && direc_ball == 4)direc_ball = 1;

  //barre en bas
  if (type_bonus != 4) {
    if (balleY > 480 && balleX > barX && balleX < (barX + (taille_bar / 2)))direc_ball = 3;
    else if (balleY > 480 && balleX > (barX + (taille_bar/2)) && balleX < (barX + taille_bar))direc_ball = 2;
    else if (balleY > 480) {
      game_over = 0;
      delay(1000);
    }
  } else {
    if (balleY > 480 && direc_ball == 4)direc_ball = 3;
    else if (balleY > 480 && direc_ball == 1)direc_ball = 2;
  }
  if (balleY > 480 && balleX > barX && balleX < (barX + taille_bar)) {
    int X_ball_bar = balleX - barX;//position de la balle par rapport à la barre
    X_ball_bar /= 10;
    if (X_ball_bar <= 2)angleBall = 1;
    if (X_ball_bar > 2 && X_ball_bar <= 5)angleBall = 2;
    if (X_ball_bar > 5 && X_ball_bar <= 8)angleBall = 2;
    if (X_ball_bar > 8 && X_ball_bar <= 10)angleBall = 1;
    print(angleBall);
  }

  int caseX = balleX / 80;
  int caseY = balleY / 40;
  if (balleY < 200 && niv[caseY][caseX] != 0) {
    niv[caseY][caseX] = 0;
    score += 10;
    if (type_bonus != 3) { 

      if (balleX < ((caseX * 80)+5) || balleX > ((caseX * 80)+75)) {

        if (direc_ball == 3)direc_ball = 2;
        else if (direc_ball == 4)direc_ball = 1;
        else if (direc_ball == 2)direc_ball = 3;
        else if (direc_ball == 1)direc_ball = 4;
      } else {
        if (direc_ball == 3)direc_ball = 4;
        else if (direc_ball == 4)direc_ball = 3;
        else if (direc_ball == 2)direc_ball = 1;
        else if (direc_ball == 1)direc_ball = 2;
      }
    }
  }
}

void gameOver() {
  background(0);
  bonus = 0;
  score = 0;
  active_bonus = 1;
  tmp_bonus = 0;
  fill(255, 255, 255);
  rect(0, 0, 800, 500);
  PImage image;
  image = loadImage("game_over.png");
  image(image, 0, 0, 800, 500);
  textSize(15);
  text("Appuyez sur Rejouez", 200, 400);


}

void setNiveau(int niveau) {
  for (int y = 0; y <= 4; y++) {
    for (int x = 0; x <= 9; x++) {

      if (niveau==1)niv[y][x] = niva[y][x];
      if (niveau==2)niv[y][x] = nivb[y][x];
      if (niveau==3)niv[y][x] = nivc[y][x];
      if (niveau==4)niv[y][x] = nivd[y][x];
      if (niveau==5)niv[y][x] = nive[y][x];
      if (niveau==6)niv[y][x] = nivf[y][x];
      if (niveau==7)niv[y][x] = nivg[y][x];
    }
  }
}

void test_num_brique() {
  int brique = 0;
  for (int y = 0; y <= 4; y++) {
    for (int x = 0; x <= 9; x++) {
      if (niv[y][x] != 0)brique++;
    }
  }
  if (brique < 2) {
    balleX = 400;
    balleY = 250;
    setNiveau(round(random(1, 7)));
    delay(1000);
  }
}

void intro() {
  background(0);
  //afficheBric();
  textSize(20);
  textFont(font, 40);
  text("CASSE-BRIQUES", width/2, 50);
  textSize(15);
  text("Le but du jeu est de casser le plus de briques possibles!!!", width/2, 80);
  fill(255, 255, 255);
  PImage intro1;
  intro1 = loadImage("intro.jpg");
  image(intro1,width/2-129, 100);
  textAlign(CENTER);
  textFont(font, 15);
  text("Envoyez une requête http pour commencer", width/2, 320); 
  text("mon IP : " + s.ip(), width/2, 340) ;
  text("requête http : " + Value, width/2, 370) ;
  textFont(font, 12);
  text("Projet requête HTTP CASSE-BRIQUES : ", width/2, 420);
  textFont(font, 12);
  text("L.Chastain : Ac.LIMOGES / K.THOMAS : Ac.CRETEIL", width/2, 440);
   c = s.available();
     if (c != null) {
  Adresse="Ip Valide vous pouvez continuer";
  msgClient=c.readString();
   if( (msgClient.indexOf ("servo") != -1) && (msgClient.length()>=msgClient.indexOf ("servo")+7) ) {
       index=msgClient.indexOf ("servo");
    Value=msgClient.substring(index+6,index+7);
    if ( config.Start == true ) intro=0;
  }}
    
}

void afficheBonus() {
  if (bonus == 0) {
    int ran = 0;
    ran = round(random(0, 1000));
    if (ran == 5) {
      bonus = 1;
      bonusX = round(random(0, 790));
      bonusY = 0;
    }
  }
  if (bonus == 1) {
    fill(238, 245, 37);
    rect(bonusX, bonusY, 10, 20);
    if (bonusY < 481) {
      bonusY++;
    } else bonus = 0;
    if (bonusY > 480 && bonusX > barX && bonusX < (barX + taille_bar)) {
      bonus=0;
      active_bonus = 1;
      init_bonus = 1;
      print("bonus");
    }
  }
}

void activeBonus() {
  if (init_bonus == 1) {
    init_bonus = 0;
    type_bonus = round(random(1, 4));
    if (type_bonus == 1 || type_bonus == 2)tmp_bonus = 10000;
    if (type_bonus == 3)tmp_bonus = 8000;
    if (type_bonus == 4)tmp_bonus = 10000;
  }
  if (tmp_bonus < 0) {
    active_bonus = 0;
    if (type_bonus == 1 || type_bonus == 2 || type_bonus == 4) taille_bar = 100;
    type_bonus = 0;
  } else {
    if (type_bonus == 1) taille_bar = 200;
    if (type_bonus == 2) taille_bar = 50;
    if (type_bonus == 4) {
      if (tmp_bonus > 2000)fill(127, 143, 166);
      else fill(158, 57, 27);
      rect(0, (barY-12), 800, 10);
      barre();
    }
    tmp_bonus -= 10;
  }
}
