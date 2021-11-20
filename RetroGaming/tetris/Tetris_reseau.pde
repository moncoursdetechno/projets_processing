/* Jeu inspiré de Tetris
 * Xavier Serpaggi <serpaggi@emse.fr>
 * Novembre 2017
 * Développé avec Processing 3.3.6.
 *
 * A but pédagogique.
 *
 * Le programme est séparé en plusieurs fichiers :
 *  - variables, où sont déclarées toutes les variables globales
 *  - init, où sont regroupées toutes les fonctions d'initialisation
 *  - pièces, où sont décrites les différentes pièces avec leurs différentes rotations
 *  - affiche, où l'on retrouve les fonctions utilisées pour afficher le jeu
 *  - Tetris, ce fichier, qui contient les fonctions Processing et le moteur du jeu
 */
import processing.net.*;
String HTTP_HEADER = "HTTP/1.0 200 OK\nContent-Type: text/html\n\n";
Server s;
Client c;
String msgClient="";
String Value="";
int index=-1;
String Adresse="Essayez d'envoyer une requête";

void setup()
{
  L = 21 ;
  C = 12 ;
  size(750, 500) ;
  stroke(200) ;
s = new Server(this, 8080);
  static_init() ;
  
  init() ;
}

void draw()
{
  int lignes_supprimees ;
   ////////////////////////////////////////  
   c = s.available();
     if (c != null) {
    Adresse="Ip Valide vous pouvez continuer";
    msgClient=c.readString();
    println(msgClient);
        if( (msgClient.indexOf ("commande") != -1) && (msgClient.length()>=msgClient.indexOf ("servo")+10) ) {
       index=msgClient.indexOf ("commande");
    Value=msgClient.substring(index+9, index+10);
 
    int wtpc, wtpl, wtrotate ;
  
  wtpc = pc ;
  wtpl = pl ;
  wtrotate = rotate ;
   if ( perdu ) {                        // si perdu
    if ( Value.charAt(0) == 'r' ) init() ;        //r :reset 
    else if ( Value.charAt(0) == 'q' ) exit() ;  // q : quitter
  } 
  else if ( Value.charAt(0) == 'p' ) jeu_en_pause = !jeu_en_pause ; // p: pause
  else if ( ! jeu_en_pause ) {
    if ( Value.charAt(0) == 'd' ) wtpc++ ;         //d: droite
    else if ( Value.charAt(0) == 'g' ) wtpc-- ;    //g: gauche
    else if ( Value.charAt(0) == 'z' ) wtrotate = (wtrotate + 1) % 4 ;//z: rotation anti horaire
    else if ( Value.charAt(0) == 'e' ) wtrotate = (wtrotate + 3) % 4 ;//e: rotation horaire
    else if ( Value.charAt(0) == 's' ) wtpl++ ;                      // s descendre
    else if ( Value.charAt(0) == 't') drop = true ;                  // t tomber
    else if ( Value.charAt(0) == 'q' ) exit() ;  // q : quitter
    else if ( Value.charAt(0) == 'r' ) init() ;
  }
  
  switch ( collisions(wtpc, wtpl, wtrotate) ) {
    case 0:
      pc = wtpc ;
      pl = wtpl ;
      rotate = wtrotate ;
      break ;
    case 2:
      fixe_piece() ;
  } 
    
    
    
    
    
 /////////////////////////////////   
     }
  }
  
  background(couleur_de_fond) ;

  if ( ! jeu_en_pause && ! perdu ) {
    /* Choix d'une nouvelle piece */
    if ( ! piece_en_jeu ) {
      lignes_supprimees = supprime_lignes_completes() ;
      lignes_supprimees_ce_niveau += lignes_supprimees ;
      score += calcule_score(lignes_supprimees) ;
      
      if ( score != ancien_score ) {
        ancien_score = score ;
        println("score = " + score) ;
      }
      
      /* Mise en jeu d'une nouvelle pièce */
      piece = piece_suivante ;
      piece_suivante = int(random(0,7)) ;
      
      rotate = 0 ;
      pl = 0 ;
      pc = (C-1)/2 ;
      
      if ( fin_du_jeu() ) {
        println("Vous avez perdu !" );
      }
      
      piece_en_jeu = true ;
    }
  
    /* A-t-on franchi un niveau ? */
    if ( lignes_supprimees_ce_niveau > seuils_niveaux[niveau-1] ) {
      niveau ++ ;
      lignes_supprimees_ce_niveau = 0 ;
    }

    /* Le jeu avance à interalle régulier, dépendant du niveau */
    if ( ((t=millis()) - t0 > pause-25*constrain(niveau-1,0,19)) || drop ) {
      t0 = t ;
      avance() ;
    }
  }
  
  /* On affiche le plateau */
  affiche() ;
}

/**
 * Cette fonction est appelée à chaque fois qu'une touche est pressée sur le clavier.
 * A nous de savoir quelle était cette touche et de réagir en conséquence.
 */
//void keyPressed()
//{
//  int tpc, tpl, trotate ;
  
//  tpc = pc ;
//  tpl = pl ;
//  trotate = rotate ;
  
//  if ( perdu ) {
//    if ( key == 'r' ) init() ;
//    else if ( key == 'q' ) exit() ;
//  } 
//  else if ( key == 'p' ) jeu_en_pause = !jeu_en_pause ;
//  else if ( ! jeu_en_pause ) {
//    if (  key == 'd' ) tpc++ ;
//    else if (  key == 'g' ) tpc-- ;
//    else if (  key == 'z' ) trotate = (trotate + 1) % 4 ;
//    else if (  key == 'e' ) trotate = (trotate +3) % 4 ;
//    else if (  key == 's' ) tpl++ ;
//    else if ( key == 't') drop = true ;
//    else if ( key == 'r' ) init() ;
//  }
  
//  switch ( collisions(tpc, tpl, trotate) ) {
//    case 0:
//      pc = tpc ;
//      pl = tpl ;
//      rotate = trotate ;
//      break ;
//    case 2:
//      fixe_piece() ;
//  }
//}

int supprime_lignes_completes()
{
  int lignes_completes ;
  boolean cc ;
  
  lignes_completes = 0 ;
  for ( int l=L-2 ; l>=0 ; ) {
    /* Test si une ligne est complète */
    cc = true ;
    for ( int c=1 ; c<C-1 ; c++ ) {
      if ( jeu[c][l] == 0 ) {
        cc = false ;
        break ;
      }
    }
    
    /* Si la ligne est complète, on la supprime.
       Ca revient à :
         1. décaler le contenu du tableau d'une ligne vers le bas ;
         2. vider (mettre des 0 dans) la ligne du haut.
     */
    if ( cc ) {
      for ( int kl=l ; kl>0 ; kl-- ) {
        for ( int kc=1 ; kc<C-1 ; kc++ ) {
          jeu[kc][kl] = jeu[kc][kl-1] ;
        }
      }
      for ( int kc=1 ; kc<C-1 ; kc++ ) jeu[kc][0] = 0 ;
      lignes_completes ++ ;
      println("lignes completes : " + lignes_completes) ;
    } else {
      l-- ;
    }
  }
  
  /* Test du back-to-back Tetris (deux Tetris d'affilée) */
  if ( lignes_completes == 4 && lignes_completes_precedentes == 4 ) {
    back_to_back = true ;
  }
  
  lignes_completes_precedentes = lignes_completes ;

  return lignes_completes ;
}

int calcule_score(int ls)
{
  int score_temp ;

  /* Le score dépend du nombre de lignes supprimées d'un coup et du niveau */
  //println("lignes complètes : " +lignes_completes) ;
  switch ( ls ) {
    case 1: score_temp = 100 ; break ;
    case 2: score_temp = 300 ; break ;
    case 3: score_temp = 500 ; break ;
    case 4: score_temp = 800 ; if ( back_to_back ) score_temp += 400 ; break ;
    default: score_temp = 0 ;
  }
  
  println("score temp : " + score_temp + " reel : " + score_temp*niveau) ;
  
  return score_temp*niveau ;
}

void fixe_piece()
{
  for ( int l=0 ; l<4 ; l++ ) {
    for ( int c=0 ; c<4 ; c++ ) {
      
      if ( pc+c < 0 || pc+c >= C ) continue ;
      if ( pl+l >= L ) continue ;
      if ( pieces[piece][rotate][l][c] == 0 ) continue ;
      
      jeu[pc+c][pl+l] += pieces[piece][rotate][l][c]+piece ;   
    }
  }
  
  piece_en_jeu = false ;
  drop = false ;
}

void avance()
{
  int tpl ;
  
  tpl = pl ;
  tpl ++ ;
  
  if ( collisions(pc, tpl, rotate) != 2 ) {
    pl = tpl ;
  } else {
    fixe_piece() ;
  }
}

/**
 * Teste si les coordonnées temporaires tpc,tpl avec la rotation
 * temporaire trotate n'engendrent pas de collision avec le bord
 * ou les autres pièces.
 *
 * Retourne :
 *  - 0 s'il n'y a pas de collision
 *  - 1 s'il y a une collision qui empèche le déplacement ou la rotation
 *  - 2 si la pièce se pose sur une autre piève ou au fond de la grille
 */
int collisions(int tpc, int tpl, int trotate)
{  
  for ( int l=3 ; l>=0 ; l-- ) {
    for ( int c=0 ; c<4 ; c++ ) {
      
      if ( tpc+c < 0 || tpc+c >= C ) continue ;
      if ( tpl+l >= L ) continue ;
      
      if ( pieces[piece][trotate][l][c] != 0 ) {
        if ( jeu[tpc+c][tpl+l] != 0 ) {
          if ( tpl != pl ) {
            //println("fixe piece " + tpl + "," + tpc + " / " + pl + "," + pc) ;
            return 2 ; 
          }
          //println("collision " + tpl + "," + tpc + " / " + pl + "," + pc) ; 
          return 1 ;
        }
      }
    }
  }
  
  return 0 ;
}

/**
 * Teste s'il est encore possible de jouer ou non.
 *
 * Retourne :
 *  - true si le jeu est fini
 *  - false sinon
 */
boolean fin_du_jeu()
{
  for ( int l=0 ; l<4 ; l++ ) {
    for ( int c = 0 ; c<4 ; c++ ) {
      if ( pieces[piece][rotate][l][c] !=0 && jeu[pc+c][pl+l] != 0 ) return perdu=true ;
    }
  }
  
  return false ;
}