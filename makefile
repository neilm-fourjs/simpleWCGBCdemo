
export FGLIMAGEPATH=../pics:$(FGLDIR)/lib/image2font.txt
export FGLRESOURCEPATH=../etc
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export LD_LIBRARY_PATH=$(JAVA_HOME)/jre/lib/amd64/server

SRSC=$(shell ls src/*.4gl src/*.per java/*.java)

all: bin bin/simpleDemo.42r

bin:
	mkdir bin

bin/webcomponents: bin
	cd bin && rm -f webcomponents && ln -s ../webcomponents

bin/simple.class: java/simple.java
	javac -d bin $^

bin/simpleDemo.42r: bin/simple.class bin/webcomponents $(SRSC)
	gsmake simpleWCGBCdemo.4pw

run: bin/simpleDemo.42r
	cd bin && fglrun simpleDemo.42r

clean:
	rm -rf bin distbin
