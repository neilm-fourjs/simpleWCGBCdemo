PUBLIC TYPE generoInfo RECORD
  runtimeInfo STRING,
  clientInfo STRING,
  fgl_major SMALLINT,
  fgl_minor SMALLINT,
  fgl_patch SMALLINT
END RECORD

FUNCTION (this generoInfo) init()
  LET this.runtimeInfo = fgl_getVersion()
  LET this.fgl_major = this.runtimeInfo.subString(1, 1)
  LET this.fgl_minor = this.runtimeInfo.subString(2, 3)
  LET this.fgl_patch = this.runtimeInfo.subString(4, 5)
  LET this.runtimeInfo = SFMT("%1.%2.%3", this.fgl_major, this.fgl_minor, this.fgl_patch)
  LET this.clientInfo =
      SFMT("Client is %1 Version %2",
          ui.Interface.getFrontEndName(), ui.Interface.getFrontEndVersion())
  IF ui.Interface.getUniversalClientName() IS NOT NULL THEN
    LET this.clientInfo =
        this.clientInfo.append(
            SFMT("<br>Universal Client is %1 Version %2",
                ui.Interface.getUniversalClientName(), ui.Interface.getUniversalClientVersion()))
  END IF
END FUNCTION
--------------------------------------------------------------------------------
FUNCTION (this generoInfo) toString() RETURNS STRING
  RETURN SFMT("Genero Version is %1<br>%2", this.runtimeInfo, this.clientInfo)
END FUNCTION
