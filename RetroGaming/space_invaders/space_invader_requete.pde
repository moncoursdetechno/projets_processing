
int state; int times = 0;
Config config; Ship ship; Fleet fleet; Laser laser; MotherShip motherShip;
PImage Start; PImage background1; PImage background2; PImage Gameover; PFont font;
ArrayList<Ship> livesFeedBck; ArrayList<Sheild> sheilds;
import processing.net.*;
String HTTP_HEADER = "HTTP/1.0 200 OK\nContent-Type: text/html\n\n";
Server s;
Client c;
String msgClient="";
String Value="";
int index=-1;
String Adresse="Essayez d'envoyer une requête";

void setup()
{size(500, 430);
s = new Server(this, 8080);
 config = new Config();
 initializeGame();
 background1 = loadImage("BackGround.jpg");
 background2 = loadImage("BackGround2.jpg");
 Gameover = loadImage("GameOver.jpg");
 font = createFont("COPRGTL.TTF",20);}

void draw()
{
  ////////////////////////////////////////
    c = s.available();
     if (c != null) {
  Adresse="Ip Valide vous pouvez continuer";
  msgClient=c.readString();
   if( (msgClient.indexOf ("commande") != -1) && (msgClient.length()>=msgClient.indexOf ("servo")+10) ) {
       index=msgClient.indexOf ("commande");
    Value=msgClient.substring(index+9, index+10);
         if ( Value.charAt(0) == 'g' ) config.Left = true;
    else if ( Value.charAt(0) == 'h' ) config.Left = false;
    else if ( Value.charAt(0) == 'd' ) config.Right = true;
    else if ( Value.charAt(0) == 'f' ) config.Right = false;
    else if ( Value.charAt(0) == 't' ) config.Shoot = true;
    else if ( Value.charAt(0) == 'y' ) config.Shoot = false;
    else if (( Value.charAt(0) == 's' )&&(config.lives <= 0)) initializeGame(); times++;
   }
 }
  ////////////////////////////////////////
  
  
  if (config.lives <= 0) 
 {GameOver();return;}
 if (times == 0)
 {GameStart();return;}
 ScoreDisplay();
 //MouseDisplay();
 laser.display();
 ship.display();
 fleet.display();
 motherShip.display();
 fleet.update();
 laser.update();
 actions(); 
 updateShip();
 updateMother(); 
 for (Sheild s:sheilds)
 {s.display();
  s.contact(laser);
  s.contactList(fleet.getLasers());
  s.contactInvader(fleet.getInvaders());}
  config.lives = (fleet.checkShipContact(ship))?0:config.lives;
  config.score += motherShip.checkContact(laser);
  config.score += fleet.checkLaserContact(laser);
 for (Laser invaderLaser : fleet.getLasers()) 
 {if (ship.contact(invaderLaser)) 
  {invaderLaser.setaLive(false);config.lives--;}}
  if (fleet.AllClear())
  {fleet = new Fleet();}}

void GameStart()
{image(background2,0,0);
 background2.resize(width,height);
 stroke(255);
 textAlign(CENTER);
 textFont(font, 40);text("SPACE INVADERS", width/2, 120);
 textFont(font, 15);text("Envoyez une requête http pour commencer", width/2, 300); 
 text("mon IP : " + s.ip(), width/2, 320) ;
 text("requête http : " + Value,width/2, 350) ;
 textFont(font, 12);text("Projet requête HTTP SPACE INVADERS : ", width/2, 400);
 textFont(font, 12);text("L.Chastain : Ac.LIMOGES / K.THOMAS : Ac.CRETEIL", width/2, 420);
// if (mousePressed) {initializeGame(); times++;}
}
    
void updateShip() 
{if (config.Right == true) {ship.moveRight();}
 if (config.Left == true) {ship.moveLeft();}
 if (config.Shoot == true) {if (!laser.aLive) {laser = new Laser(ship.location.x);}}}

void actions()
{
 // if (myPort.available()>0)
 //{state = myPort.read();
 //println(state);
 //if (state == 1) {config.Right = true;} 
 //if (state == 2) {config.Left = true;} 
 //if (state == 4) {config.Shoot = true;} 
 //if (state == 0) {config.Right = false; config.Left = false; config.Shoot = false; }}
 }
  
// void  keyPressed() {
//    switch(key) {
//        case 'a':
//        case 'A':
//            config.Left = true;
//            break;
//        case 'd':
//        case 'D':
//            config.Right = true;
//            break;
//        case ' ':
//            config.Shoot = true;
//            break;
//    }
//}
// void  keyReleased() {
//    switch(key) {
//        case 'a':
//        case 'A':
//            config.Left = false;
//            break;
//        case 'd':
//        case 'D':
//            config.Right = false;
//            break;
//        case ' ':
//            config.Shoot = false;
//            break;
//    }
//}


 
void updateMother() 
{if (motherShip.aLive) {motherShip.update();} 
 else 
 {if (frameCount%60 == 0 && random(100) > 85) 
 {motherShip.launchMotherShip(random(100) > 50);}}}

void initializeGame() 
{ship = new Ship();
 fleet = new Fleet();
 laser = new Laser(ship.location.x); laser.setaLive(false);
 motherShip = new MotherShip();
 initializeSheild();
 config.score = 0;
 config.lives = 3;
 livesFeedBck = new ArrayList<Ship>();
 for (int i = 0; i < config.lives; i++) 
 {livesFeedBck.add(new Ship(width-120+40*i, height/15));}}

void initializeSheild() 
{sheilds = new ArrayList<Sheild>();
 for (int i = 0; i < 4; i++) 
 {sheilds.add(new Sheild(i*125+45, 310));}}

void ScoreDisplay() 
{background(0);
 image(background1,0,0);
 background1.resize(width,height);
 tint(255,100);
 fill(255);
 textFont(font, 15);
 text("Scores: "+config.score, 50, height/15);
 stroke(0, 255, 0);
 strokeWeight(2);
 line(0, height-30, width, height-30);
 for (int i = 0; i < config.lives; i++) 
 {Ship ship = livesFeedBck.get(i);ship.display();}}
 
//void MouseDisplay()
//{float distance = dist(pmouseX, pmouseY, mouseX, mouseY);
// stroke(random(50.255),random(50,255),random(50,255));
// strokeWeight(distance*0.15);
// line(pmouseX, pmouseY, mouseX, mouseY);}
 
void GameOver() 
{
 stroke(0);
 textAlign(CENTER);
 textFont(font, 20);text("Envoyez une requête http pour recommencer", width/2, height/2+90);
 text("mon IP : " + s.ip(), width/2, 320) ;
 text("requête http : " + Value,width/2, 350) ;
  textFont(font, 12);text("Projet requête HTTP SPACE INVADERS : ", width/2, 400);
 textFont(font, 12);text("L.Chastain : Ac.LIMOGES / K.THOMAS : Ac.CRETEIL", width/2, 420);
 image(Gameover,0,0);
 Gameover.resize(width,height);
 tint(255,100);
 //if (mousePressed) {initializeGame();}
 }