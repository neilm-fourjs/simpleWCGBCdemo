IMPORT os

PUBLIC TYPE greReport RECORD
		reportsDir STRING,
		rptName STRING,
		fileName STRING,
		device STRING,
		preview BOOLEAN,
		pageWidth SMALLINT,
		handle om.SaxDocumentHandler
	END RECORD

FUNCTION (this greReport ) start(l_rptName STRING) RETURNS BOOLEAN
	LET this.rptName = l_rptName
  IF this.preview IS NULL THEN LET this.preview = FALSE END IF
	IF this.reportsDir IS NULL THEN LET this.reportsDir = "../etc" END IF
  IF this.rptName IS NOT NULL THEN
    LET this.rptName = os.path.join(this.reportsDir, this.rptName.append(".4rp") )
  END IF
	IF NOT os.path.exists(this.rptName) THEN
    CALL fgl_winMessage("Error", SFMT("Report Design '%1' not found!",this.rptName), "exclamation")
    RETURN FALSE
	END IF
  IF NOT fgl_report_loadCurrentSettings(this.rptName) THEN
    CALL fgl_winMessage("Error", "Report initialize failed!", "exclamation")
    RETURN FALSE
  END IF

  IF this.pageWidth > 80 THEN
    CALL fgl_report_configurePageSize("a4length", "a4width") -- Landscape
  ELSE
    CALL fgl_report_configurePageSize("a4width", "a4length") -- Portrait
  END IF

  IF this.device = "PDF" AND this.rptName IS NULL THEN
    CALL fgl_report_configureCompatibilityOutput(
        this.pageWidth, "Courier", TRUE, base.Application.getProgramName(), "", "")
  END IF

  IF this.device != "XML" THEN
    CALL fgl_report_selectDevice(this.device)
    CALL fgl_report_selectPreview(this.preview)
  END IF

  IF this.device = "Printer" THEN
    CALL fgl_report_setPrinterName(this.fileName)
  ELSE
    IF this.fileName IS NOT NULL THEN
      CALL fgl_report_setOutputFileName(this.fileName)
    END IF
  END IF
  -- Set the SAX handler
  IF this.device = "XML" THEN -- Just produce XML output
    LET this.handle = fgl_report_createProcessLevelDataFile(this.fileName)
  ELSE -- Produce a report using GRE
    LET this.handle = fgl_report_commitCurrentSettings()
  END IF
  MESSAGE SFMT("Printing Report %1, please wait ...", NVL(this.rptName,"ASCII") )
  CALL ui.Interface.refresh()

	RETURN TRUE
END FUNCTION
-------------------------------------------------------------------------------
FUNCTION (this greReport ) finish() RETURNS ()
	MESSAGE SFMT("Report %1 Finished.",  NVL(this.rptName,"ASCII"))
  CALL ui.Interface.refresh()
END FUNCTION
-------------------------------------------------------------------------------
FUNCTION (this greReport ) getOutput() RETURNS BOOLEAN
	DEFINE l_dest CHAR(1)
	LET int_flag = FALSE
  MENU "Report Destination"
      ATTRIBUTES(STYLE = "dialog", COMMENT = "Output report to ...", IMAGE = "question")
    COMMAND "File"
      LET l_dest = "F"
      LET this.device = "XML"
    COMMAND "File PDF"
      LET l_dest = "F"
      LET this.device = "PDF"
    COMMAND "Screen"
      LET l_dest = "S"
      LET this.device = "SVG"
      LET this.preview = TRUE
    COMMAND "Printer"
      LET l_dest = "P"
      LET this.device = "Printer"
    COMMAND "PDF"
      LET l_dest = "D"
      LET this.device = "PDF"
      LET this.preview = TRUE
    COMMAND "XLS"
      LET l_dest = "D"
      LET this.device = "XLS"
      LET this.preview = TRUE
    COMMAND "HTML"
      LET l_dest = "D"
      LET this.device = "HTML"
      LET this.preview = TRUE
    COMMAND "XLSX"
      LET l_dest = "F"
      LET this.device = "XLSX"
      LET this.preview = TRUE
    COMMAND "XML"
      LET l_dest = "F"
      LET this.device = "XML"
  END MENU
  IF int_flag THEN
    CALL fgl_winMessage("Cancelled", "Report cancelled", "information")
   	RETURN FALSE
  END IF
  IF l_dest = "F" THEN
    PROMPT "Enter filename:" FOR this.fileName
    IF this.fileName IS NULL THEN
      LET this.fileName = base.Application.getProgramName()
    END IF
    IF this.fileName.getIndexOf(".", 1) < 1 THEN
      LET this.fileName = this.fileName.append("." || this.device.toLowerCase())
    END IF
  END IF
  IF int_flag THEN
    CALL fgl_winMessage("Cancelled", "Report cancelled", "information")
    RETURN FALSE
  END IF
	RETURN TRUE
END FUNCTION