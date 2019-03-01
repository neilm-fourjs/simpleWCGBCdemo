
GBC=gbc-simple
VER=$(GENVER)
APP=simpleWCGBCdemo
GAR=distbin$(VER)/$(APP).gar
RENDERER=ur

export FGLGBCDIR=../gbc/gbc-current/dist/customization/$(GBC)
export FGLIMAGEPATH=..:../pics:$(FGLDIR)/lib/image2font.txt
export FGLPROFILE=../etc/profile.$(RENDERER)
export FGLRESOURCEPATH=../etc

SRSC=$(shell ls src/*.4gl src/*.per java/*.java xcf/*.xcf etc/*)

all: bin$(VER) $(GAR)

bin$(VER):
	mkdir bin$(VER)

gbc/gbc-current/dist/customization/$(GBC):
	cd gbc && make

# Build the Java
bin$(VER)/simple.class: java/simple.java
	javac -d bin$(VER) $^

# Build the Genero application
bin$(VER)/simpleDemo.42r: bin$(VER) bin$(VER)/simple.class $(SRSC)
	gsmake $(APP)$(VER).4pw

$(GAR): bin$(VER)/simpleDemo.42r

run: bin$(VER)/simpleDemo.42r
	cd bin$(VER) && fglrun simpleDemo.42r

clean:
	rm -rf bin$(VER) distbin$(VER)

undeploy: 
	gasadmin gar $(GASCFG) --disable-archive $(APP)
	gasadmin gar $(GASCFG) --undeploy-archive $(APP)

deploy: $(GAR)
	gasadmin gar $(GASCFG) --deploy-archive $^
	gasadmin gar $(GASCFG) --enable-archive $(APP)
	
redeploy: undeploy deploy

deploygbc: gbc/gbc-current/dist/customization/$(GBC)
	cd gbc && make deploy

undeploygbc:
	cd gbc && make undeploy

redeploygbc:
	cd gbc && make redeploy

