
IMPORT JAVA simple
DEFINE m_simple simple
MAIN

	LET m_simple = simple.create()

	CALL m_simple.hello()

	OPEN FORM f FROM "form"
	DISPLAY FORM f

	MENU
		ON ACTION do_wc CALL do_wc()
		ON ACTION quit EXIT MENU
		ON ACTION close EXIT MENU
	END MENU

END MAIN
--------------------------------------------------------------------------------
FUNCTION do_wc()
	DEFINE l_wc STRING
	LET l_wc = "Test"
	INPUT BY NAME l_wc ATTRIBUTES(WITHOUT DEFAULTS, UNBUFFERED, ACCEPT=FALSE, CANCEL=FALSE)
		ON ACTION test1 LET l_wc = "Another test"
		ON ACTION javaver LET l_wc = SFMT("Java Version is %1", m_simple.getJavaVersion() )
		ON ACTION generover LET l_wc = SFMT("Genero Version is %1", fgl_getVersion() )
		ON ACTION close EXIT INPUT
		ON ACTION back EXIT INPUT
	END INPUT
END FUNCTION