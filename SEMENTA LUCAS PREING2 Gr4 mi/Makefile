
CC=gcc
EXEC=prog.exe
RM=rm -f
CESOUR=dataForC/srcdir/
SORTIE=dataForC/bindir/
SAUVEGARDE = savedir/
SRC=$(wildcard $(CESOUR)*.c) #liste fichiers .c (sources)
OBJ=$(subst $(CESOUR), $(SORTIE), $(SRC:.c=.o)) #dans srcdir/didier.c on change srcdir/ en bindir/ et .c en .o



all : $(EXEC)

$(EXEC) : $(OBJ)
	$(CC) -o $(EXEC) $(OBJ) -lm

./$(SORTIE)%.o : ./$(CESOUR)%.c
	$(CC) -o $@ -c $^ -lm

./$(SORTIE)main.o : ./$(CESOUR)main.c
	$(CC) -o $@ -c $^ -lm


save : 
	cp ./$(CESOUR)/*.c $(SAUVEGARDE)
	cp ./$(CESOUR)/*.h $(SAUVEGARDE)

restore :
	cp ./$(SAUVEGARDE)/*.c ./$(CESOUR)
	cp ./$(SAUVEGARDE)/*.h ./$(CESOUR)

give : #compression
	sudo tar -cvf GIVE.tar ./	

.PHONY : clean 
#Phony sert à bien différencier la règle clean du fichier "clean"

clean : 
	$(RM) $(OBJ)
	$(RM) *.*~
	$(RM) *.bak
	$(RM) *.old