void static_init()
{
  jeu = new int[C][L] ;
 
  zoom = width / 3 / C ;

  couleur_de_fond = 50 ;

  pos_jeu_c = 12 ;
  pos_jeu_l = 2 ;

  pos_score_c = 2 ;
  pos_score_l = 4 ;

  pos_piece_suivante_c = 7 ;
  pos_piece_suivante_l = 12 ;

  pos_niveau_c = 2 ;
  pos_niveau_l = 3 ;

  pos_score_c = 2 ;
  pos_score_l = 4 ;

  pos_touches_c = 25 ;
  pos_touches_l = 3 ;
}

void init()
{
  for ( int l = 0; l < L; l++ ) {
    for ( int c = 0; c < C; c++ ) {
      if ( c == 0 || c == C-1 || l == L-1 ) jeu[c][l] = 9 ;
      else jeu[c][l] = 0 ;
    }
  }

  rotate = 0 ;
  piece_en_jeu = false;
  drop = false ;
  pause = 500 ;
  niveau = 1 ;
  score = 0 ;
  ancien_score = 0 ;
  jeu_en_pause = false ;
  perdu = false ;
  lignes_completes_precedentes = 0 ;
  lignes_supprimees_ce_niveau = 0 ;
  back_to_back = false ;
  
  piece_suivante = int(random(0, 7)) ;

  t0 = millis() ;
}