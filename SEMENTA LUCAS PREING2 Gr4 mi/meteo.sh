#!/bin/bash
file="vide"
ext=""
direc="dataForC"
txt_files="txt_files"
len=""
cur=""
cur_val=""
prev=""
prev_val=""
path=""
val=""


optele="f:t:p:FGSAOQwhm"

if [ -d $txt_files ]
then
    rm -r $txt_files
    mkdir $txt_files

else
    mkdir $txt_files
fi



    # Parse les arguments en ligne de commande
while getopts "$optele" opt; do
# Selon l'option spécifiée
case $opt in
    f)
        if [ -f $OPTARG ]
        then
            ext=$OPTARG
            ext=${ext:(-4)}
        
            if [ $ext == ".csv" ]
            then 
                file=$OPTARG
                echo "Fichier ouvert avec succes"
            
            else
                echo "Le fichier doit etre en .csv"
                exit 1 
            fi

        else 
            echo "-f a besoin d'un fichier existant"
            exit 1
        fi
    ;;

    \?)
    # Affiche un message d'erreur si l'option est incorrecte
    echo "ERREUR" >&2
    exit 1
    ;;

   
esac
done

OPTIND=1

while getopts "$optele" opt; do
# Selon l'option spécifiée

    if ! [ $file == "vide" ] 
    then
        case $opt in
            t)
            # Enregistre la valeur pour le mode de température

                if [ $OPTARG == "1" ] || [ $OPTARG == "2" ] || [ $OPTARG == "3" ]  
                then
                    echo "Faire cette option t"

                else
                    echo "L'argument de -t doit etre 1 2 ou 3"
                
                fi
            ;;
            p)
            # Enregistre la valeur pour le mode de pression
                
                if [ $OPTARG == "1" ] || [ $OPTARG == "2" ] || [ $OPTARG == "3" ]  
                then
                    echo "Faire cette option p"
              

                else
                    echo "L'argument de -p doit etre 1 2 ou 3"
                
                fi
            ;;

            m)

                tail +2 $file | cut -d";" -f1,6 | head -500 > txt_files/hey.txt
                sort -k1,1 txt_files/hey.txt > txt_files/sorted.txt

                len=$(wc -l txt_files/sorted.txt | cut -d' ' -f1)

                j=1

                if [ -f "dataForC/DATA/data1.txt" ]
                then
                    rm dataForC/DATA/data1.txt
                fi

                for i in `seq 2 $(($len+1))`
                do
                    cur=`head -$i txt_files/sorted.txt | tail -1 | cut -d';' -f1`
                    cur_val=`head -$i txt_files/sorted.txt | tail -1 `
                    prev=`head -$j txt_files/sorted.txt | tail -1 | cut -d';' -f1`
                    prev_val=`head -$j txt_files/sorted.txt | tail -1 `

                    if [ $cur != $prev ]
                    then 
                       echo $prev_val >> dataForC/DATA/data1.txt
                    fi
                   
                   j=$(($j+1))
                done

                make

                if [ -f "prog.exe" ]
                then 
                    ./prog.exe --tab
                else    
                    echo "L'executable n'est pas present"
                    exit 1
                fi

                path="dataForC/DATA/out1.txt"
                len=$(wc -l $path | cut -d' ' -f1)

                if [ -f humid.txt ]
                then
                    rm humid.txt
                fi

               

                for o in `seq 2 $(($len+1))`
                    do
                        val=`head -$o $path | tail -1 | cut -d';' -f1`
                        hm=`head -$o $path | tail -1 | cut -d';' -f2`
                
            
                        cur=`grep $val $file | cut -d";" -f10 | head -1`
                    
                        echo "$cur,$hm" >> humid.txt
                                    
                    done

   
                
                gnuplot <<- EOF
				
                    set view map 
                     set pm3d interpolate 2,2
                    set terminal png size 700,700
                    set xlabel "Latitude "
                    set ylabel "Longitude "
                    
                   

                    set xrange [-100 : 100] 
                    set yrange [-100 : 100]
                    set datafile separator ','
                   
                    set output 'map.png' 
                    splot "humid.txt" with points palette pt 9 
                   
                  
              
				EOF
				
               
           

            ;;

            \?)
            # Affiche un message d'erreur si l'option est incorrecte
                echo "ERREUR" >&2
                exit 1
            ;;
        esac
    else
        echo "Il faut ouvrir un fichier avec -f<nom_fichier>"
        exit 1

    fi
done