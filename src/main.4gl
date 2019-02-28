
IMPORT JAVA simple

MAIN
	DEFINE l_wc STRING
	DEFINE l_simple simple

	LET l_simple = simple.create()

	CALL l_simple.hello()

	OPEN FORM f FROM "form"
	DISPLAY FORM f

	LET l_wc = "Test"
	INPUT BY NAME l_wc ATTRIBUTES(WITHOUT DEFAULTS, UNBUFFERED, ACCEPT=FALSE, CANCEL=FALSE)
		ON ACTION test1 LET l_wc = "Another test"
		ON ACTION javaver LET l_wc = SFMT("Java Version is %1", l_simple.getJavaVersion() )
		ON ACTION close EXIT INPUT
		ON ACTION quit EXIT INPUT
	END INPUT
END MAIN