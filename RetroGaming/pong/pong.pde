
int deplacementX, deplacementY;
int X, Y;
int X1,Y1;
int bbb;
int aaa;
boolean a1=false;
boolean a2=false;
boolean b1=false;
boolean b2=false;
float couleur,couleur1,couleur2;
float SCORE_GAUCHE, SCORE_DROIT;

 import processing.net.*;
String HTTP_HEADER = "HTTP/1.0 200 OK\nContent-Type: text/html\n\n";
Server s;
Client c;
String msgClient="";
String Value="--";
int index=-1;
String Adresse="Essayez d'envoyer une requête";

int times = 0;
PImage background2;
PFont font;

void setup()  {
  
  s = new Server(this, 8080);
  background2 = loadImage("BackGround2.jpg");
  font = createFont("COPRGTL.TTF",20);
  size(400,500);
  X = 100;
  Y = 100;
  X1=X;
  Y1=Y;
  aaa = 200;
  bbb = 200;
  deplacementX = 2;
  deplacementY = -2;
  SCORE_GAUCHE=0;
  SCORE_DROIT=0;
  couleur = 50;
  couleur1 = 25;
  couleur2=0;
  noStroke();
  fill(0,0,0,255);
}

void draw()  {
       ////////////////////////////////////////
    c = s.available();
     if (c != null) {
  Adresse="Ip Valide vous pouvez continuer";
  msgClient=c.readString();
   if( (msgClient.indexOf ("commande") != -1) && (msgClient.length()>=msgClient.indexOf ("servo")+10) ) {
       index=msgClient.indexOf ("commande");
    Value=msgClient.substring(index+9, index+10);
       }

 }
 ////////////////////////////////////////
  ////////////////////////////////////////
 if (Value!="--") {
    if (Value.charAt(0) =='s'){
      times=1;
   }
     if (Value.charAt(0)=='z'||b1) {//haut joureur 1
     bbb = bbb - 5;
     b1=true;
     b2=false;
    }
    if (Value.charAt(0)=='b'||b2) {//bas joueur 1
     bbb = bbb + 5;
     b2=true;
     b1=false;      
    }
     if (Value.charAt(0)=='e') {//arret joueur 1
     b2=false;
     b1=false;      
    }
    if (Value.charAt(0)=='g'||a1) {//haut joureur 2
    aaa = aaa - 5;
    a1=true;
    a2=false;
    }
    if (Value.charAt(0)=='d'||a2) {//bas joueur 2
    aaa = aaa + 5;
    a2=true;
    a1=false;
    }
    if (Value.charAt(0)=='f') {//arret joueur 1
     a2=false;
     a1=false;      
    }
    
}
    ////////////////////////////////////////
   ////////////////////////////////////////
       if (times == 0)
 {GameStart();return;}
 ////////////////////////////////////////
  nettoyer();
  bouger();
  rebondir();
  dessiner();
  X1=X;
  Y1=Y;
  score();

} 

void nettoyer() {

  background(255);
} 

void rebondir() {

  int SENS;
  int OK;
  float azerty;

  if ((X > width && deplacementX > 0) || (X < 0 && deplacementX < 0)) {
    deplacementX = -deplacementX;
  }
  if (X < 0 && deplacementX < 0) {
    deplacementX = abs(deplacementX);
  }
  if ((Y > width && deplacementY > 0) || (Y < 0 && deplacementY < 0)) {
    deplacementY = -deplacementY;
  }
  if (Y < 0 && deplacementY < 0)  {
    deplacementY = abs(deplacementY);
  }   

  SENS=0;
  if(X<X1 && Y>Y1){
    // DESCENTE
    SENS=1;

  }
  OK=0;
  if(X<=21 || X>=379)
  {

    if(Y>=bbb && Y<=(bbb+60))
    {
      if(SENS==0)
      {
        deplacementY = -2;
        deplacementX = +2;
        couleur=random(0,250);
        couleur1=random(0,250);
        couleur2=random(0,250);
       
      }
      else
      {
        deplacementY = +2;
        deplacementX = +2;
        couleur=random(0,250);
        couleur1=random(0,250);
           couleur2=random(0,250);
      }
      bouger();
      OK=1;
    }
    else
        if(Y>=aaa && Y <=(aaa+60))
      {

        if(SENS==1)
        {
          deplacementY = +2;
          deplacementX = -2;
          couleur=random(0,250);
        couleur1=random(0,250);
            couleur2=random(0,250);
        }
        else
        {
          deplacementY = +2;
          deplacementX = -2;
          couleur=random(0,250);
          couleur1=random(0,250);
          couleur2=random(0,250);
        }
       
      
       
       
       
        bouger();
        OK=1;
      }
      azerty = 0.5;
      if(OK==0){
        if(X==0)
          SCORE_DROIT = SCORE_DROIT + azerty;
                    couleur=random(0,250);
                    couleur1=random(0,250);
                    couleur2=random(0,250);
        if(X==400)
           SCORE_GAUCHE = SCORE_GAUCHE + azerty;
           couleur=random(0,250);
                    couleur=random(0,250);
                    couleur1=random(0,250);
                    couleur2=random(0,250);
                    
       
       println("SCORE "+SCORE_GAUCHE+"/"+SCORE_DROIT);  
      }
  }
}

void bouger() {

  X = X + deplacementX;
  Y = Y + deplacementY;
 

 
 

}
void dessiner(){
  ellipse(X,Y,10,10);
  fill(couleur,couleur1,couleur2);
  rect(10,bbb,10,60);
  rect(380,aaa,10,60);
  rect(200,10,10,50);
  rect(200,70,10,50);
  rect(200,130,10,50);
  rect(200,190,10,50);
  rect(200,250,10,50);
  rect(200,310,10,50);
  rect(200,370,10,40);
  rect(0,400,400,20);
    fill(0,0,0);
 textFont(font, 12);
 text("Projet requête HTTP PONG : ", width/2, 470);
 text("L.Chastain : Ac.LIMOGES / K.THOMAS : Ac.CRETEIL", width/2, 490);
 fill(couleur,couleur1,couleur2);
  //if(keyPressed)
  //{
  //  if(key == 'a')
  //  {
  //    bbb = bbb - 5;
  //  }
  //  if(key == 'q')
  //  {
  //    bbb = bbb + 5;
  //  }
  //} 
  //if(keyPressed)
  //{
  //  if(key == 'p')
  //  {
  //    aaa = aaa - 5;
  //  }
  //  if(key == 'm')
  //  {
  //    aaa = aaa + 5;
  //  }
   
  //}
  if(aaa >350 ){aaa=350;}
  if(aaa <0 ){aaa=0;}
  if(bbb >350){bbb=350;}
  if(bbb<0){bbb=0;}
  
} 

void score() {

fill(0,0,0);
 textFont(font, 40);
 
 text(round(SCORE_GAUCHE), 100, 40);
 text(round(SCORE_DROIT), 300, 40);

//if(SCORE_GAUCHE== 1.0){
//         rect(100,10,10,50);
     
//  }
//if(SCORE_DROIT== 1.0){
//         rect(300,10,10,50);
//        }
//if(SCORE_GAUCHE== 0.0){
//         rect(100,10,10,60);
//         rect(75,10,10,60);
//         rect(75,10,25,20);
//         rect(75,50,25,20);
        
     
//  }
//if(SCORE_DROIT== 0.0){
//         rect(300,10,10,60);
//         rect(275,10,10,60);
//         rect(275,10,25,20);
//         rect(275,50,25,20);
//        }
//if(SCORE_GAUCHE==2.0){
//         rect(100,10,60,10);
//         rect(100,30,60,10);
//         rect(100,50,60,10);
//         rect(150,10,10,20);
//         rect(100,40,10,20);
//        }
//if(SCORE_DROIT==2.0){
//         rect(250,10,60,10);
//         rect(250,30,60,10);
//         rect(250,50,60,10);
//         rect(300,10,10,20);
//         rect(250,40,10,20);
//         } 
//if(SCORE_GAUCHE==3.0){
//         rect(100,10,60,10);
//         rect(100,30,60,10);
//         rect(100,50,60,10);
//         rect(150,10,10,50);
//    }
//if(SCORE_DROIT==3.00){
//         rect(250,10,60,10);
//         rect(250,30,60,10);
//         rect(250,50,60,10);
//         rect(300,10,10,50); 
//         }
//if(SCORE_GAUCHE==4.00){
//         rect(100,10,10,30);
//         rect(100,40,60,10);
//         rect(140,20,10,50);
//       } 
//if(SCORE_DROIT==4.00){
//         rect(250,10,10,30);
//         rect(250,40,60,10);
//         rect(290,20,10,50);
//         }
if(SCORE_DROIT>=5.00){
         background(0);
         //you
         rect(10,10,10,10);
         fill(255);
         rect(20,20,10,10);
         fill(255);
         rect(30,30,10,30);
         fill(255);
         rect(40,20,10,10);
         fill(255);
         rect(50,10,10,10);
         fill(255);
         rect(70,10,10,50);
         fill(255);
         rect(90,10,10,50);
         fill(255);
         rect(70,10,30,10);
         fill(255);
         rect(70,50,30,10);
         fill(255);
         rect(110,10,10,50);
         fill(255);
         rect(130,10,10,50);
         fill(255);
         rect(110,50,30,10);
         fill(255);
         //lose
         rect(10,70,10,50);
         fill(255);
         rect(10,120,30,10);
         fill(255);
         rect(50,70,10,50);
         fill(255);
         rect(70,70,10,50);
         fill(255);
         rect(50,70,30,10);
         fill(255);
         rect(50,120,30,10);
         fill(255);
         rect(90,70,30,10);
         fill(255);
         rect(90,95,30,10);
         fill(255);
         rect(90,120,30,10);
         fill(255);
         rect(90,70,10,35);
         fill(255);
         rect(110,95,10,30);
         fill(255);
         rect(130,70,10,60);
         fill(255);
         rect(130,70,30,10);
         fill(255);
         rect(130,95,30,10);
         fill(255);
         rect(130,120,30,10);
         fill(255);
         //you
         rect(210,10,10,10);
         fill(255);
         rect(220,20,10,10);
         fill(255);
         rect(230,30,10,30);
         fill(255);
         rect(240,20,10,10);
         fill(255);
         rect(250,10,10,10);
         fill(255);
         rect(270,10,10,50);
         fill(255);
         rect(290,10,10,50);
         fill(255);
         rect(270,10,30,10);
         fill(255);
         rect(270,50,30,10);
         fill(255);
         rect(310,10,10,50);
         fill(255);
         rect(330,10,10,50);
         fill(255);
         rect(310,50,30,10);
         fill(255);
         //win
         rect(210,100,10,10);
         fill(255);
         rect(220,110,10,10);
         fill(255);
         rect(230,120,10,10);
         fill(255);
         rect(240,110,10,10);
         fill(255);
         rect(250,120,10,10);
         fill(255);
         rect(260,110,10,10);
         fill(255);
         rect(270,100,10,10);
         fill(255);
         rect(290,70,10,10);
         fill(255);
         rect(290,90,10,40);
         fill(255);
         rect(310,80,10,50);
         fill(255);
         rect(320,80,10,10);
         fill(255);
         rect(330,90,10,10);
         fill(255);
         rect(340,100,10,10);
         fill(255);
         rect(350,80,10,50);
         fill(255);
         rect(180,0,10,400);
         rect(0,400,400,20);
      fill(255);
    } 
     
     
     
     
if(SCORE_GAUCHE>=5.00){
         background(0);
         //you
         rect(210,10,10,10);
         fill(255);
         rect(220,20,10,10);
         fill(255);
         rect(230,30,10,30);
         fill(255);
         rect(240,20,10,10);
         fill(255);
         rect(250,10,10,10);
         fill(255);
         rect(270,10,10,50);
         fill(255);
         rect(290,10,10,50);
         fill(255);
         rect(270,10,30,10);
         fill(255);
         rect(270,50,30,10);
         fill(255);
         rect(310,10,10,50);
         fill(255);
         rect(330,10,10,50);
         fill(255);
         rect(310,50,30,10);
         fill(255);
         //lose
         rect(210,70,10,50);
         fill(255);
         rect(210,120,30,10);
         fill(255);
         rect(250,70,10,50);
         fill(255);
         rect(270,70,10,50);
         fill(255);
         rect(250,70,30,10);
         fill(255);
         rect(250,120,30,10);
         fill(255);
         rect(290,70,30,10);
         fill(255);
         rect(290,95,30,10);
         fill(255);
         rect(290,120,30,10);
         fill(255);
         rect(290,70,10,35);
         fill(255);
         rect(310,95,10,30);
         fill(255);
         rect(330,70,10,60);
         fill(255);
         rect(330,70,30,10);
         fill(255);
         rect(330,95,30,10);
         fill(255);
         rect(330,120,30,10);
         fill(255);
         //you
         rect(10,10,10,10);
         fill(255);
         rect(20,20,10,10);
         fill(255);
         rect(30,30,10,30);
         fill(255);
         rect(40,20,10,10);
         fill(255);
         rect(50,10,10,10);
         fill(255);
         rect(70,10,10,50);
         fill(255);
         rect(90,10,10,50);
         fill(255);
         rect(70,10,30,10);
         fill(255);
         rect(70,50,30,10);
         fill(255);
         rect(110,10,10,50);
         fill(255);
         rect(130,10,10,50);
         fill(255);
         rect(110,50,30,10);
         fill(255);
         //win
         rect(10,100,10,10);
         fill(255);
         rect(20,110,10,10);
         fill(255);
         rect(30,120,10,10);
         fill(255);
         rect(40,110,10,10);
         fill(255);
         rect(50,120,10,10);
         fill(255);
         rect(60,110,10,10);
         fill(255);
         rect(70,100,10,10);
         fill(255);
         rect(90,70,10,10);
         fill(255);
         rect(90,90,10,40);
         fill(255);
         rect(110,80,10,50);
         fill(255);
         rect(120,80,10,10);
         fill(255);
         rect(130,90,10,10);
         fill(255);
         rect(140,100,10,10);
         fill(255);
         rect(150,80,10,50);
         fill(255);
         rect(180,0,10,400);
         rect(0,400,400,20);
      fill(255);        
        
                
      
     } 
if(SCORE_GAUCHE>=6.00){
  SCORE_GAUCHE=0;
  SCORE_DROIT=0;
  times=0;
}
if(SCORE_DROIT>=6.00){
  SCORE_GAUCHE=0;
  SCORE_DROIT=0;
  times=0;
}
  }
  
  void GameStart()
{image(background2,0,0);
 background2.resize(width,height);
 stroke(255);
 textAlign(CENTER);
 fill(255,0,0);
 textFont(font, 40);text("PONG", width/2, 100);
 textFont(font, 15);text("Envoyez une requête http pour commencer", width/2, 230); 
 text("mon IP : " + s.ip(), width/2, 250) ;
 text("requête http : " + Value,width/2, 270) ;
 textFont(font, 12);

 
 fill(0,0,0);
 text("Projet requête HTTP PONG : ", width/2, 470);
 text("L.Chastain : Ac.LIMOGES / K.THOMAS : Ac.CRETEIL", width/2, 490);

 
 //if (keyPressed ) { times++;}
}  