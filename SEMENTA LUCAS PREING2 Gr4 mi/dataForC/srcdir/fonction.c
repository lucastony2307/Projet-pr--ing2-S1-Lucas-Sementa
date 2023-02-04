#include <stdlib.h>
#include <stdio.h>
#include <string.h>

typedef struct 
{
    int moist;
    char id[20];
}cell;


void TriInsertion(cell *tab, int taille){
    int tmp=0;
    char tmpp[20];
    
    /*Balayage des éléments du tableau*/
    for(int i=0;i<taille;i++){
        /*Balayage des éléments à gauche de tab[i]*/
        for(int j=0;j<i;j++){

            /*Si un tab[j] est plus grand, on le place devant tab[i] */
            if(tab[i].moist<tab[j].moist){
              tmp=tab[i].moist;
              strcpy(tmpp, tab[i].id);
              

                /*C'est ici qu'on décale les bons éléments d'un cran vers la droite*/  
                for(int h=i;h>j;h--){
                    tab[h].moist=tab[h-1].moist;
                    strcpy(tab[h].id, tab[h-1].id);
                }  

                tab[j].moist=tmp;
                strcpy(tab[j].id,tmpp);
                break;
            }
        }
    }



}

void triclassique(FILE *f_data, FILE *new_file){
    new_file=fopen("dataForC/DATA/out1.txt", "w");
    
    cell *tab;
    tab=malloc(70*sizeof(cell));    
    int i=0;
    int j=0;
    int pos=0;
    char nom[100];
    char *e;
    char tmp[5];
   
    if(new_file){
        while(fgets(nom,100,f_data)){

      
            e=strtok(nom, ";");
        
            strcpy(tab[i].id, nom);
        
            e=strtok(NULL, ";");
            tab[i].moist=atoi(e);

        

            i++;
        }

        TriInsertion(tab, i);
        for(int a=0;a<i;a++){
            //printf("%s %d\n", tab[a].id, tab[a].moist);
            fprintf(new_file, "%s;%d\n", tab[a].id, tab[a].moist);
        }
    }
    
    fclose(new_file);
    
}