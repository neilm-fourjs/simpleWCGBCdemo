
PWD=$(shell pwd)
VER=$(GENVER)
CUSTGBC=gbc-simple
VERDIR=gbc-current
DIR=$(VERDIR)/customization/$(CUSTGBC)
GBCFILES=\
	$(DIR)/theme.scss.json\
	$(DIR)/sass/customization.scss\
	$(DIR)/sass/main.scss

all: $(CUSTGBC).zip

$(DIR):
	ln -s $(PWD)/$(CUSTGBC) $(DIR)/

$(CUSTGBC).zip: $(VERDIR)/dist/customization/$(CUSTGBC)/VERSION
	rm -f $(CUSTGBC).zip && ln -s $(shell ls -1rt $(VERDIR)/archive/*.zip | tail -1) $@;

$(VERDIR)/dist/customization/$(CUSTGBC)/VERSION: $(DIR) $(GBCFILES)
	cd gbc-current && grunt --customization=customization/$(CUSTGBC) --compile-mode=prod --create-zip

deploy: $(CUSTGBC).zip
	gasadmin gbc $(GASCFG) --deploy $^

undeploy: 
	gasadmin gbc $(GASCFG) --undeploy $(CUSTGBC)

redeploy: undeploy deploy
