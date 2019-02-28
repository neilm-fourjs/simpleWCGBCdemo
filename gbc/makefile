
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

$(DIR): $(VERDIR)
	ln -s $(PWD)/$(CUSTGBC) $(DIR)

$(CUSTGBC).zip: $(VERDIR)/dist/customization/$(CUSTGBC)/VERSION
	rm -f $(CUSTGBC).zip && ln -s $(shell ls -1rt $(VERDIR)/archive/*.zip | tail -1) $@;

$(VERDIR)/dist/customization/$(CUSTGBC)/VERSION: $(DIR) $(GBCFILES)
	cd gbc-current && grunt --customization=customization/$(CUSTGBC) --compile-mode=prod --create-zip

deploy: $(CUSTGBC).zip
	gasadmin gbc -f $(FGLASDIR)/etc/new_as$(VER).xcf --deploy $^

undeploy: 
	gasadmin gbc -f $(FGLASDIR)/etc/new_as$(VER).xcf --undeploy $(CUSTGBC)

redeploy: undeploy deploy
