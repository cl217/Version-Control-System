all: WTF
test: clean WTF TEST

WTF: WTFserver.o WTFclient.o helper.o communicate.o readwrite.o
	gcc -g -std=c99 -lm -lssl -lcrypto -lz WTFclient.o helper.o communicate.o readwrite.o -o WTF
	gcc -g -std=c99 -lm -lssl -pthread -lz -lcrypto WTFserver.o helper.o communicate.o readwrite.o -o WTFserver
	
TEST: WTFtest.o
	mkdir server
	mkdir client1
	mkdir client1/testproj
	mkdir client1/testproj/folder1
	mkdir client1/testproj/folder1/folder2
	echo randomtext > client1/testproj/folder1/file1.txt
	printf "#include<stdio.h>\nint main( int argc, char** argv){\n\tprintf(\"Hello world\");\n\treturn 0;\n}" > client1/testproj/folder1/folder2/test.c
	printf "all: TEST\nTEST: test.c\n\tgcc -g test.c -o test" > client1/testproj/folder1/folder2/Makefile
	touch client1/testproj/file3.txt
	mkdir client2
	cp WTFserver server
	cp WTF client1
	cp WTF client2
	gcc -g WTFtest.o -o WTFtest
		
WTFserver.o: WTFserver.c WTFheader.h
	gcc -g -std=c99 -pthread -lz -c WTFserver.c

WTFclient.o: WTFclient.c WTFheader.h
	gcc -g -std=c99 -c WTFclient.c	

helper.o: helper.c WTFheader.h
	gcc -g -std=c99  -lm -c  helper.c
	
communicate.o: communicate.c WTFheader.h
	gcc -g -std=c99 -c communicate.c

readwrite.o: readwrite.c WTFheader.h
	gcc -g -std=c99 -lssl -lcrypto -lz -c readwrite.c

WTFtest.o: WTFtest.c WTFheader.h
	gcc -g -c WTFtest.c

clean: 
	rm -rf WTF WTFclient.o WTFserver.o helper.o readwrite.o communicate.o WTFtest.o WTFserver WTFclient WTFtest server client1 client2
	
	

