int i = 0; 

void setup(){

size (800,600);
background(0,150,0);

// voie nÂ°1 et 2
noStroke();
fill(0,0,0);
rect(300,0,200,600);
rect(0,200,800,200);
stroke(255);
line(400,0,400,20);
line(400,30,400,50);
line(400,60,400,80);
line(400,520,400,540);
line(400,550,400,570);
line(400,580,400,600);
line(0,300,20,300);
line(30,300,50,300);
line(60,300,80,300);
line(90,300,110,300);
line(120,300,140,300);
line(660,300,680,300);
line(690,300,710,300);
line(720,300,740,300);
line(750,300,770,300);
line(780,300,800,300);

fill(255);
text("Simulation", 20, 20);
text("Feux de signatisation d'un carrefour", 20, 40);
text("Voie nÂ°2", 20, 390);
text("Voie nÂ°1", 310, 20); 
text("lchastain", 20, 560);
text("http://moncoursdetechno.free.fr", 20, 580);

//passages pietons voies 1

noStroke();
fill(255,255,255);
rect(310,100,20,60);
rect(340,100,20,60);
rect(370,100,20,60);
rect(400,100,20,60);
rect(430,100,20,60);
rect(460,100,20,60);

noStroke();
fill(255,255,255);
rect(310,430,20,60);
rect(340,430,20,60);
rect(370,430,20,60);
rect(400,430,20,60);
rect(430,430,20,60);
rect(460,430,20,60);

//passages pietons voies 2

noStroke();
fill(255,255,255);
rect(210,210,60,20);
rect(210,240,60,20);
rect(210,270,60,20);
rect(210,300,60,20);
rect(210,330,60,20);
rect(210,360,60,20);

noStroke();
fill(255,255,255);
rect(530,210,60,20);
rect(530,240,60,20);
rect(530,270,60,20);
rect(530,300,60,20);
rect(530,330,60,20);
rect(530,360,60,20);
}

//dÃ©but du cycle
void draw(){
i = i + 1;

if (i>50){
   fill(0,255,0);
   ellipse (290,160,10,10);
   ellipse (510,440,10,10);
   fill(255,0,0);
   ellipse (510,190,10,10);
   ellipse (290,410,10,10);
   fill(255);
   ellipse (290,175,10,10);
   ellipse (290,190,10,10);
   ellipse (510,410,10,10);
   ellipse (510,425,10,10);
   ellipse (525,190,10,10);
   ellipse (540,190,10,10);
   ellipse (275,410,10,10);
   ellipse (260,410,10,10);
  
   }

if (i>150){
  fill(255,123,51);
   ellipse (290,175,10,10);
   ellipse (510,425,10,10);
   fill(255,0,0);
   ellipse (510,190,10,10);
   ellipse (290,410,10,10);
   fill(255);
   ellipse (290,160,10,10);
   ellipse (510,410,10,10);
   ellipse (290,190,10,10);
   ellipse (510,440,10,10);
   ellipse (525,190,10,10);
   ellipse (540,190,10,10);
   ellipse (275,410,10,10);
   ellipse (260,410,10,10);
   }

if (i>200){
  
   fill(255,0,0);
   ellipse (510,190,10,10);
   ellipse (290,410,10,10);
   ellipse (290,190,10,10);
   ellipse (510,410,10,10);
   fill(255);
   ellipse (290,175,10,10);
   ellipse (290,160,10,10);
   ellipse (510,440,10,10);
   ellipse (510,425,10,10);
   ellipse (525,190,10,10);
   ellipse (540,190,10,10);
   ellipse (275,410,10,10);
   ellipse (260,410,10,10);
    }
 if (i>300){
   fill(0,255,0);
   ellipse (260,410,10,10);
   ellipse (540,190,10,10);
   fill(255,0,0);
   ellipse (290,190,10,10);
   ellipse (510,410,10,10);
   fill(255);
   ellipse (290,175,10,10);
   ellipse (510,425,10,10);
   ellipse (525,190,10,10);
   ellipse (510,190,10,10);
   ellipse (275,410,10,10);
   ellipse (290,410,10,10);
   ellipse (290,160,10,10);
   ellipse (510,440,10,10);
   }

if (i>350){
   fill(255,123,51);
   ellipse (525,190,10,10);
   ellipse (275,410,10,10);
   fill(255,0,0);
   ellipse (290,190,10,10);
   ellipse (510,410,10,10);
   fill(255);
   ellipse (260,410,10,10);
   ellipse (540,190,10,10);
   ellipse (510,190,10,10);
   ellipse (540,190,10,10);
   ellipse (290,410,10,10);
   ellipse (260,410,10,10);
   ellipse (290,160,10,10);
   ellipse (510,440,10,10);
   }

if (i>450){
   
   fill(255,0,0);
   ellipse (510,190,10,10);
   ellipse (290,410,10,10);
   ellipse (290,190,10,10);
   ellipse (510,410,10,10);
  
   fill(255);
   ellipse (290,175,10,10);
   ellipse (290,160,10,10);
   ellipse (510,440,10,10);
   ellipse (510,425,10,10);
   ellipse (525,190,10,10);
   ellipse (540,190,10,10);
   ellipse (275,410,10,10);
   ellipse (260,410,10,10);
  
  i=0;
}
}