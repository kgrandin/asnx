OUTDIR=o

LEXSRC = asnx.l
YACCSRC = asnx.ypp
TARGET = asnx

all: FORCE
	mkdir -p $(OUTDIR)
	bison -d --output-file=asnx.parse.cpp $(YACCSRC)
	mv asnx.parse.hpp o
	mv asnx.parse.cpp o
	g++ -c -MMD -ggdb -Wall -I. -o o/asnx.parse.o o/asnx.parse.cpp
	flex --outfile=$(OUTDIR)/asnx.yy.c $(LEXSRC)
	g++ -c -MMD -ggdb -Wall -I. -o o/asnx.yy.o o/asnx.yy.c
	g++ -o o/asnx o/asnx.yy.o o/asnx.parse.o

clean:
	rm -rf o

FORCE:

