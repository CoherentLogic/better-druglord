OBJS = MAIN.o REGION.o IOEVENT.o DLSCREEN.o LEVEL.o

druglord: $(OBJS) 
	fbc -x druglord $(OBJS)

MAIN.o: MAIN.BAS
	fbc -m MAIN -c MAIN.BAS

REGION.o: REGION.BAS
	fbc -c REGION.BAS

IOEVENT.o: IOEVENT.BAS
	fbc -c IOEVENT.BAS

DLSCREEN.o: DLSCREEN.BAS
	fbc -c DLSCREEN.BAS

LEVEL.o: LEVEL.BAS
	fbc -c LEVEL.BAS

clean:
	rm *.o
	rm *.O
	rm druglord
