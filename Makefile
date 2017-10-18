all1:	
	flex temp.l
	bison -d temp.y
	gcc -o temp.out lex.yy.c temp.tab.c -lfl
	#cat ex1.cpp
	#./temp.out ex1.cpp
	#cat ex2.cpp	
	#./temp.out ex2.cpp
	#cat ex3.cpp
	#./temp.out ex3.cpp
	#cat ex4.cpp
	#./temp.out ex4.cpp
	cat ex5.cpp
	./temp.out ex5.cpp

all2:
	flex test.l
	bison -d test.y
	gcc -o test.out lex.yy.c test.tab.c -lfl

clean:
	rm -rf lex.yy.c expr.tab.c expr.tab.h calc sample.out
