/*
oscilloscope minimaliste avec un arduino
 récupère et affiche les valeurs via une liaison serie
 version 1.0
 L.Chastain
 http://moncoursdetechno.ovh
 */
import processing.serial.*; // importation de la librairie de communication serie
//variables
Serial maConnection; // Crée un objet de communication série
int valeur=0; // variable où sera stockée la valeur de la tension
float tension;
String voltage;

//affichage
int fenetreTemps=12000; // temps pour parcourir la largeur de l'écran en millisecondes
int x=20;
int y=150;

void setup() {
  size(800, 600); // taille de l'ecran    
  String NomDuPort = Serial.list()[0]; // récupère la première interface serie trouvée
  println("connection a "+NomDuPort);
  maConnection = new Serial(this, NomDuPort, 115200); // création de la connexion série
  background(255); // fond d'écran blanc
  smooth(); // lisser les dessins
  strokeWeight(2); // largeur de trait
  stroke(40); // couleur du trait gris
}

void draw() { //boucle de dessin principale
  smooth();
  println(voltage);
  //détermination du X actuel 
  int oldx=x;
  x=(millis()%fenetreTemps)*width/fenetreTemps;
  int t=millis();
  println(t/1000);
  if (oldx>x) { 
    //reprise au debut de l'écran 
    oldx=0;
    background(255);  //fond d'écran blanc
  } 
  //determination de la valeur de Y 
  int oldy=y;
  y=int(map(valeur, 0, 1023, 500, 140)); // mise à l'échelle de la tension pour entrer dans l'écran 


  //dessin ecran_oscillo
  //entête
  noStroke();
  fill(57, 140, 191, 75);
  rect(0, 0, 800, 75);
  fill(255);
  textSize(36);
  text("OSCILLOSCOPE à 1 entrée", 20, 50);   

  //axes
  stroke(20);
  fill(200);
  textSize(12);
  text("5V", 10, 135);
  line(4, 140, 24, 140);
  text("4V", 10, 207);
  line(4, 212, 24, 212);
  text("3V", 10, 279);
  line(4, 284, 24, 284);
  text("2V", 10, 351);
  line(4, 356, 24, 356);
  text("1V", 10, 423);
  line(4, 428, 24, 428);
  line(1, 500, 1, 120);
  text("0V", 10, 500);
  line(1, 500, 800, 500);

  // dessine le signal
  strokeWeight(3); // largeur de trait
  stroke(68, 166, 65);
  line(oldx, oldy, x, y); 
  
  //affiche la valeur numérique et l'équivalent en volt   
  noStroke();
  fill(255);
  rect(590, 90, 700, 25);
  fill(68, 166, 65);   
  textSize(18);
  //fill(255);
  rect(570,75,230,50);
  fill(0);
  text("valeur numérique: "+valeur, 580, 95);
  text("en volts: "+voltage+"(V)", 580, 115);
  
  //affiche le temps 
  


  //bas de page
  noStroke();
  fill(57, 140, 191, 75);
  rect(0, 550, 800, 50);
  fill(255);   
  textSize(12);
  text("v1.0", 20, 580);
  text("L.Chastain-http://moncoursdetechno.ovh", 450, 580);    
  //
}

void serialEvent (Serial maConnection) { // si des données arrivent par la connexion série
  String retour=maConnection.readStringUntil('\n'); // lit la donnée jusqu'à la fin de ligne
  if (retour != null) { //si le retour n'est pas vide
    retour = trim(retour); // enlever les espaces
    valeur = int(retour);// converti le texte en nombre entier
    tension=(valeur*0.0048828125);
    voltage=nf(tension,0,2);//calcul l'équivalent en tension
  }
}
