CC=g++
CFLAGS=-O3 -c -Wall
LDFLAGS=
SOURCES=dependency.cc variable.cc function.cc llvm_parser.cc
OBJECTS=$(SOURCES:.cc=.o)
EXECUTABLE=llvm_parser

all: clean $(SOURCES) $(EXECUTABLE)

$(EXECUTABLE): $(OBJECTS)
	$(CC) $(LDFLAGS) $(OBJECTS) -o $@

.cpp.o:
	$(CC) $(CFLAGS) $< -o $@

clean:
	rm -rf $(EXECUTABLE)
	rm -rf *.o
	rm -rf ../test/*.amap
