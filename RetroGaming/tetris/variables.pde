int[][] jeu ;  // le plateau de jeu
int L, C ;     // le nombre de lignes et de colonnes du plateau
int zoom ;     // facteur d'échelle pour l'affichage
int pc, pl ;   // position de la pièce en cours de descente
int rotate ;   // rotation de la pièce en cours de descente
int piece, piece_suivante ; // la pièce en cours et celle à venir
boolean piece_en_jeu ;  // y a-t-il une pièce en cours de jeu ?
boolean drop ;          // le joueur a-t-il demandé de faire tomber la pièce
int t, t0, pause ;      // gestion du temps pour le déroulement du jeu
int score, ancien_score ;
int niveau ;
boolean jeu_en_pause ;
byte couleur_de_fond ;
boolean perdu ;
int lignes_completes_precedentes ;
int lignes_supprimees_ce_niveau ;
boolean back_to_back ;

// nombres de lignes nécessaires pour passer d'un niveau au suivant
int[] seuils_niveaux =
{
  4,5,6,7,8,
  9,10,10,11,11,
  12,12,13,13,14,
  14,15,15,16,16
} ; 