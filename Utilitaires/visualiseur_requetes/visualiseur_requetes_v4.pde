/* Utilitaire à but pédagogique
 * permet de visualiser les requêtes HTTP envoyées depuis terminal distant
 * K.Thomas-ac.Creteil/L.Chastain-ac.Limoges
 * Avril 2019
 * Développé avec Processing 3.5.3.
 */

import processing.net.*;
String HTTP_HEADER = "HTTP/1.0 200 OK\nContent-Type: text/html\n\n";
Server s;
Client c;
String msgClient="";
String Value="";
String Variable="";
String Port="";
int index=-1;
int index_Fin_Var=-1;
int index_start_Variable=-1;
int index_fin_Variable=-1;
String Adresse="Essayez d'envoyer une requête";
String Cli="";
PFont font;

void setup() {
  size(600, 480);
  s = new Server(this, 8080);

  font = createFont("COPRGTL.TTF", 20);
}

void draw() {
  background(0);
  fill(255);
  textAlign(CENTER);
  textFont(font, 30);
  text("Visualiseur de Requêtes HTTP", width/2, 50);
  stroke(255);
  line(10, 70, 590, 70);
  textFont(font, 15);
  text("permet de contrôler les requêtes HTTP envoyées vers ce terminal :", width/2, 100);
  text("-depuis une app dédiée de votre smartphone(AppInventor)", width/2-30, 120);
  text("-depuis le navigateur d'un terminal du réseau", width/2-79, 140);  
  line(10, 390, 590, 390);
  textFont(font, 12);
  text("Projet requête HTTP a but pédagogique : ", width/2, 410);
  textFont(font, 12);
  text("L.Chastain : Ac.LIMOGES / K.THOMAS : Ac.CRETEIL", width/2, 430);
  text("2018/2019", width/2, 450);

  c = s.available();
  if (c != null) {
    Adresse="Ip Valide vous pouvez continuer";
    msgClient=c.readString();
    //println(msgClient);

      index_start_Variable=msgClient.indexOf ("/?")+2;
      index_fin_Variable=msgClient.indexOf ("=");
      index=msgClient.indexOf ("commande");
      index_Fin_Var=msgClient.indexOf ("HTTP/1.1");
      Value=msgClient.substring(index_fin_Variable+1, index_Fin_Var);
      Variable=msgClient.substring(index_start_Variable, index_fin_Variable);  
      Cli=c.ip();
       
    
    
  }
  textAlign(LEFT);
  fill(255); 
  text("Adresse IP de ce PC : " + s.ip(), 100, 200) ;
  rect(240, 180, 200, 30);
  fill(255, 0, 0);
  text(s.ip(), 250, 200) ;
  fill(255);
  
  text("Nom de la variable : ", 100, 240) ;
  rect(240, 220, 200, 30);
  fill(255, 0, 0);
  text(Variable, 250, 240) ; ///////////////////////
  fill(255);
  
  
   text("Valeur : ", 100, 280) ;
  rect(240, 260, 200, 30);
  fill(255, 0, 0);
  text(Value, 250, 280) ; 
  fill(255);
  
  
  
  
  
  text("Requête http reçue : ", 100, 300) ;
  rect(100, 310, 400, 30);  
  text("envoyée par : ", 100, 365) ;
  if (index_Fin_Var!=-1) {

    fill(255, 0, 0);
    text("http://"+ s.ip()+":8080/?"+Variable+"="+Value, 110, 325);
    fill(255, 255, 255);
    text("envoyée par :  "+ Cli, 100, 365) ;

  }
}
