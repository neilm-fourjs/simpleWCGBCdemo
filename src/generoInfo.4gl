PUBLIC TYPE generoInfo RECORD
  runtimeInfo STRING,
  fgl_major SMALLINT,
  fgl_minor SMALLINT,
  fgl_patch SMALLINT,
  clientName STRING,
  clientVer STRING,
  universalName STRING,
  universalVer STRING
END RECORD

FUNCTION (this generoInfo) init()
  LET this.runtimeInfo = fgl_getVersion()
  LET this.fgl_major = this.runtimeInfo.subString(1, 1)
  LET this.fgl_minor = this.runtimeInfo.subString(2, 3)
  LET this.fgl_patch = this.runtimeInfo.subString(4, 5)
  LET this.runtimeInfo = SFMT("%1.%2.%3", this.fgl_major, this.fgl_minor, this.fgl_patch)
	LET this.clientName = ui.Interface.getFrontEndName()
	LET this.clientVer =  ui.Interface.getFrontEndVersion()
	LET this.universalName = ui.Interface.getUniversalClientName()
	LET this.universalVer = ui.Interface.getUniversalClientVersion()
END FUNCTION
--------------------------------------------------------------------------------
FUNCTION (this generoInfo) toHTML() RETURNS STRING
	DEFINE l_ret STRING
  LET l_ret = SFMT("Runtime:%1<br>Client: %2 %3", this.runtimeInfo, this.clientName, this.clientVer)
	IF this.universalName IS NOT NULL THEN
		LET l_ret = l_ret.append(SFMT("<br>Universal: %1 %2", this.universalName, this.universalVer))
	END IF
	RETURN l_ret
END FUNCTION
--------------------------------------------------------------------------------
FUNCTION (this generoInfo) toString() RETURNS STRING
	DEFINE l_ret STRING
  LET l_ret = SFMT("Runtime:%1\nClient: %2 %3", this.runtimeInfo, this.clientName, this.clientVer)
	IF this.universalName IS NOT NULL THEN
		LET l_ret = l_ret.append(SFMT("\nUniversal: %1 %2", this.universalName, this.universalVer))
	END IF
	RETURN l_ret
END FUNCTION
