#include <stdlib.h>
#include <stdio.h>
#include "fonction.h"
#include <string.h>

int main(int argc, char **argv){
    FILE *file = NULL;
    FILE *new_file=NULL;
    file = fopen("dataForC/DATA/data1.txt", "r+");

    if(file){

        if(argc != 2 ){
            exit(1);
        }

        else if (strcmp(argv[0], "--tab")){
            triclassique(file, new_file);
        }

        else if (strcmp(argv[0], "--avl")){

        }

        else if (strcmp(argv[0], "--abr")){

        }

        else{

        }

       
    }

    else{
        printf("Echec de l'ouverture du fichier à trier\n");
        exit(2);
    }

     fclose(file);

}