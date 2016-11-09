  ////***Laurent CHASTAIN***////
  ////***version 1.0***////
  ////***pour la technologie en collÃ¨ge***////
  
int nuit=0;
int increment=1;

void setup(){
  size (480,400);
}

void draw(){
    
  ////***Programmation d'un Ã©clairage automatique***////
  
   //ciel
    stroke(10);
    fill(0,0,nuit);
    rect (0,0,480,300);
  //sol
    fill(0,255,0);
    rect (0,301,480,100);
    fill(0);
    text("lchastain, moncoursdetechno.free.fr ", 10, 390);
  //maison
    fill(255);
    rect (250,200,150,100);
  //garage
    fill(255);
    rect (270,265,80,35);
  //toit
    fill(255,255,255);
    triangle(250,200,325,150,400,200);
  //faisceau lumineux
    ellipse (310,255,10,10);
    noStroke();

  
  nuit=nuit+increment;
   
   if (nuit<100) {
   fill(246,255,13);
   ellipse (310,255,10,10);
   noStroke();
   triangle(270,300,310,255,350,300);
   fill(255);
   text("Il fait NUIT !", 40, 150);
     //nomenclature
    stroke(0);
    line(340,270,390,320);
    line(310,252,340,235);
    fill(0);
    text("porte de garage", 340, 340);
    text("lampe", 330, 235);
   }else{
    fill(255,255,255,63);
    ellipse (310,255,10,10);
    triangle(270,300,310,255,350,300);
    fill(255);
    text("Il fait JOUR !", 40, 150);
        //nomenclature
    stroke(0);
    line(340,270,390,320);
    line(310,252,340,235);
    fill(0);
    text("porte de garage", 340, 340);
    text("lampe", 330, 235);
   }
  if (nuit >255 || nuit<0){
   increment *= -1;
  }
  
}