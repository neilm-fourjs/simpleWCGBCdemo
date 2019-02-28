
export FGLIMAGEPATH=../pics:$(FGLDIR)/lib/image2font.txt
export FGLRESOURCEPATH=../etc
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export LD_LIBRARY_PATH=$(JAVA_HOME)/jre/lib/amd64/server

VER=310
APP=simpleWCGBCdemo
GAR=distbin/$(APP).gar

SRSC=$(shell ls src/*.4gl src/*.per java/*.java xcf/*.xcf etc/*)

all: bin $(GAR)

bin:
	mkdir bin

bin/webcomponents: bin
	cd bin && rm -f webcomponents && ln -s ../webcomponents

bin/simple.class: java/simple.java
	javac -d bin $^

bin/simpleDemo.42r: bin/simple.class bin/webcomponents $(SRSC)
	gsmake simpleWCGBCdemo.4pw

$(GAR): bin/simpleDemo.42r

run: bin/simpleDemo.42r
	cd bin && fglrun simpleDemo.42r

clean:
	rm -rf bin distbin

undeploy: 
	gasadmin gar -f $(FGLASDIR)/etc/new_as$(VER).xcf --disable-archive $(APP)
	gasadmin gar -f $(FGLASDIR)/etc/new_as$(VER).xcf --undeploy-archive $(APP)

deploy: $(GAR)
	gasadmin gar -f $(FGLASDIR)/etc/new_as$(VER).xcf --deploy-archive $^
	gasadmin gar -f $(FGLASDIR)/etc/new_as$(VER).xcf --enable-archive $(APP)
	
