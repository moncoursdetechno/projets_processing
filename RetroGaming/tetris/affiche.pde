//les requetes fonctionnent mais aucune interaction au niveau du tetris 
int pos_jeu_c, pos_jeu_l ;
int pos_niveau_c, pos_niveau_l ;
int pos_score_c, pos_score_l ;
int pos_piece_suivante_c, pos_piece_suivante_l ;
int pos_touches_c, pos_touches_l ;

void affiche()
{
  dessine_plateau() ;
  
  if ( ! perdu ) {
    dessine_piece_en_cours() ;
    dessine_piece_suivante() ;
  } else {
    fill(255,50,50) ;
    textSize(zoom*6) ;
    rotate(-PI/60) ;
    text("Perdu !", 7.5*zoom, 15*zoom) ;
    rotate(PI/60) ;
  }
  
  affiche_niveau() ;
  affiche_score() ;
  affiche_touches() ;
}

void dessine_plateau()
{
  for ( int l=0; l<L; l++ ) {
    for ( int c=0; c<C; c++ ) {

      stroke(200) ;
      
      switch ( jeu[c][l] ) {
        case 0: fill(255) ; break ;
        case 1: fill(170, 0, 0) ; break ;
        case 2: fill(192) ; break ;
        case 3: fill(170, 0, 170) ; break ;
        case 4: fill(0, 0, 170) ; break ;
        case 5: fill(0, 170, 0) ; break ;
        case 6: fill(170, 85, 0) ; break ;
        case 7: fill(0, 170, 170) ; break ;
        case 9:
          noStroke() ; 
          if ( jeu_en_pause ) fill(255*sin((frameCount%360)*2*PI/360),255*cos((frameCount%360)*2*PI/360),255*tan((frameCount%360)*2*PI/360)) ;
          else fill((niveau-1)*10,0,0) ;
          break ;
      }
      rect(zoom*(pos_jeu_c+c), zoom*(pos_jeu_l+l), zoom, zoom) ;
    }
  }
}

void dessine_piece_en_cours()
{
  for ( int l=0 ; l<4 ; l++ ) {
    for ( int c=0 ; c<4 ; c++ ) {
      if ( pieces[piece][rotate][l][c] == 0 ) continue ;
      switch ( piece+pieces[piece][rotate][l][c] ) {
        case 1: fill(170, 0, 0) ; break ;
        case 2: fill(192) ; break ;
        case 3: fill(170, 0, 170) ; break ;
        case 4: fill(0, 0, 170) ; break ;
        case 5: fill(0, 170, 0) ; break ;
        case 6: fill(170, 85, 0) ; break ;
        case 7: fill(0, 170, 170) ; break ;
      }
      rect(zoom*(pos_jeu_c+c+pc), zoom*(pos_jeu_l+l+pl), zoom, zoom) ;
    }
  }
}

void dessine_piece_suivante()
{
    for ( int l=0 ; l<4 ; l++ ) {
    for ( int c=0 ; c<4 ; c++ ) {
      if ( pieces[piece_suivante][0][l][c] == 0 ) {
        fill(couleur_de_fond) ;
      } else {
        switch ( piece_suivante + pieces[piece_suivante][0][l][c] ) {
          case 1: fill(170, 0, 0) ; break ;
          case 2: fill(192) ; break ;
          case 3: fill(170, 0, 170) ; break ;
          case 4: fill(0, 0, 170) ; break ;
          case 5: fill(0, 170, 0) ; break ;
          case 6: fill(170, 85, 0) ; break ;
          case 7: fill(0, 170, 170) ; break ;
        }
      }
      rect(zoom*(pos_piece_suivante_c+c), zoom*(pos_piece_suivante_l+l), zoom, zoom) ;
    }
  }  
}

void affiche_niveau()
{
  fill(255) ;
  textSize(zoom) ;
  
  text("Niveau : " + niveau, zoom*pos_niveau_c, zoom*pos_niveau_l) ;  
}

void affiche_score()
{
  fill(255) ;
  
  textSize(zoom*2/3) ;
  text("Projet requête HTTP Tetris : L.Chastain : Ac.LIMOGES / K.THOMAS : Ac.CRETEIL", pos_touches_c*zoom/3, (pos_touches_l+21)*zoom) ;  
  textSize(zoom) ;
  text("Score : " + score, zoom*pos_score_c, zoom*pos_score_l) ;  
}

void affiche_touches()
{
  textSize(zoom) ;
  fill(255) ;
  if ( ! perdu ) {
    
    text("g : gauche", zoom*pos_touches_c, zoom*pos_touches_l) ;
    text("d : droite", zoom*pos_touches_c, zoom*(pos_touches_l+1)) ;
    text("z : rotation anti horaire ", zoom*pos_touches_c, zoom*(pos_touches_l+2)) ;
    text("e : rotation horaire", zoom*pos_touches_c, zoom*(pos_touches_l+3)) ;
    text("s : descendre", zoom*pos_touches_c, zoom*(pos_touches_l+4)) ;
    text("t : faire tomber", zoom*pos_touches_c, zoom*(pos_touches_l+5)) ;
    text("p : pause", zoom*pos_touches_c, zoom*(pos_touches_l+7)) ;
    text("q : quitter", zoom*pos_touches_c, zoom*(pos_touches_l+8)) ;
    text("r : recommencer", zoom*pos_touches_c, zoom*(pos_touches_l+9)) ;
    text("requête http : " + Value, pos_touches_c*zoom, (pos_touches_l+11)*zoom) ;
    text("mon IP : " + s.ip(), pos_touches_c*zoom, (pos_touches_l+12)*zoom) ;
    textSize(zoom*2/3) ;
    text(Adresse, pos_touches_c*zoom, (pos_touches_l+13)*zoom) ;
  } else {
    fill(255, 50, 50) ;
    text("r : recommencer", pos_touches_c*zoom, pos_touches_l*zoom) ;
    text("q : quitter", pos_touches_c*zoom, (pos_touches_l+1)*zoom) ;
    text("requête http : " + Value, pos_touches_c*zoom, (pos_touches_l+3)*zoom) ;
    text("mon IP : " + s.ip(), pos_touches_c*zoom, (pos_touches_l+4)*zoom) ;
    textSize(zoom*2/3) ;
    text(Adresse, pos_touches_c*zoom, (pos_touches_l+5)*zoom) ;
  }
}