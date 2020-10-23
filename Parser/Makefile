HC=ghc
SOURCES=src/Main.hs
GEN_SOURCES=src/Lexer.x src/Parser.y
GENERATED=src/Lexer.hs src/Parser.hs

.PHONY: pack all run clean

all: parser

generate: $(GEN_SOURCES)
	rm -rf $(GENERATED)
	alex src/Lexer.x -o src/Lexer.hs
	happy src/Parser.y -o src/Parser.hs
