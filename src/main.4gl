IMPORT JAVA simple
IMPORT FGL generoInfo
IMPORT FGL greReport

DEFINE m_simple simple
DEFINE m_GeneroInfo generoInfo
MAIN

  LET m_simple = simple.create()
  CALL m_simple.hello()

  CALL m_GeneroInfo.init()

  OPEN FORM f FROM "form"
  DISPLAY FORM f

  MENU
    ON ACTION do_wc
      CALL do_wc()
		ON ACTION do_rpt
			CALL do_rpt()
    ON ACTION quit
      EXIT MENU
    ON ACTION close
      EXIT MENU
  END MENU

END MAIN
--------------------------------------------------------------------------------
FUNCTION do_wc()
  DEFINE l_wc STRING
  LET l_wc = "Test"
  INPUT BY NAME l_wc ATTRIBUTES(WITHOUT DEFAULTS, UNBUFFERED, ACCEPT = FALSE, CANCEL = FALSE)
    ON ACTION test1
      LET l_wc = "Another test"
    ON ACTION javaver
      LET l_wc = SFMT("Java Version is:<br>%1", m_simple.getJavaVersion())
    ON ACTION generover
      LET l_wc =SFMT("Genero Versions are:<br>%1", m_generoInfo.toHTML())
    ON ACTION close
      EXIT INPUT
    ON ACTION back
      EXIT INPUT
  END INPUT
END FUNCTION
--------------------------------------------------------------------------------
FUNCTION do_rpt()
	DEFINE x SMALLINT
	DEFINE l_gre greReport

	LET l_gre.device = "SVG"
	LET l_gre.preview = TRUE
	IF NOT l_gre.start("simple") THEN RETURN END IF
	START REPORT rpt1 TO XML HANDLER l_gre.handle
	FOR x = 1 TO 20
		OUTPUT TO REPORT rpt1 ( x )
	END FOR
	FINISH REPORT rpt1
END FUNCTION
--------------------------------------------------------------------------------
REPORT rpt1( x SMALLINT )
	DEFINE l_java_ver, l_genero_ver STRING

	FORMAT
		FIRST PAGE HEADER
			LET l_java_ver = m_simple.getJavaVersion()
			LET l_genero_ver = m_generoInfo.toString()
			PRINT l_java_ver, l_genero_ver
		ON EVERY ROW
			PRINT x

END REPORT
