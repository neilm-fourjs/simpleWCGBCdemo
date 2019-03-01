
export FGLIMAGEPATH=../pics:$(FGLDIR)/lib/image2font.txt
export FGLPROFILE=../etc/profile.ur
export FGLRESOURCEPATH=../etc

GBC=gbc-simple
VER=$(GENVER)
APP=simpleWCGBCdemo
GAR=distbin$(VER)/$(APP).gar

SRSC=$(shell ls src/*.4gl src/*.per java/*.java xcf/*.xcf etc/*)

all: bin$(VER) bin$(VER)/gbc bin$(VER)/webcomponents bin$(VER)/gbc $(GAR)

bin$(VER):
	mkdir bin$(VER)

# Make the link for webcomponents
bin$(VER)/webcomponents:
	cd bin$(VER) && rm -f webcomponents && ln -s ../webcomponents

gbc/gbc-current/dist/customization/$(GBC):
	cd gbc && make

# Make the link for the custom GBC
bin$(VER)/gbc: bin$(VER) gbc/gbc-current/dist/customization/$(GBC)
	cd bin$(VER) && rm -f gbc && ln -s ../gbc/gbc-current/dist/customization/$(GBC) gbc

# Build the Java
bin$(VER)/simple.class: java/simple.java
	javac -d bin$(VER) $^

# Build the Genero application
bin$(VER)/simpleDemo.42r: bin$(VER)/simple.class $(SRSC)
	gsmake $(APP)$(VER).4pw

$(GAR): bin$(VER)/simpleDemo.42r

run: all
	cd bin$(VER) && fglrun simpleDemo.42r

clean:
	rm -rf bin$(VER) distbin$(VER)

undeploy: 
	gasadmin gar -f $(FGLASDIR)/etc/new_as$(VER).xcf --disable-archive $(APP)
	gasadmin gar -f $(FGLASDIR)/etc/new_as$(VER).xcf --undeploy-archive $(APP)

deploy: $(GAR)
	gasadmin gar -f $(FGLASDIR)/etc/new_as$(VER).xcf --deploy-archive $^
	gasadmin gar -f $(FGLASDIR)/etc/new_as$(VER).xcf --enable-archive $(APP)
	
redeploy: undeploy deploy
