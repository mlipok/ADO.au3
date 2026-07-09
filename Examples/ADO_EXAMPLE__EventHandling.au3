#AutoIt3Wrapper_Run_AU3Check=Y
#AutoIt3Wrapper_Au3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 -w 7
#include "..\ADO.au3"

#REMARK
#CS
	To use this example here:
	You should create ["&$sTesting_DataBaseName&"] in MS SQL Server (could be Express edition)
#CE


ConsoleWrite(@CRLF)
ConsoleWrite(@CRLF)
ConsoleWrite('EXAMPLE START' & @CRLF)
_Example()
ConsoleWrite('EXAMPLE START' & @CRLF)
ConsoleWrite(@CRLF)
ConsoleWrite(@CRLF)

Func _Example()
	; ADO.au3 presets
	_ADO_ComErrorHandler_UserFunction(_ADO_COMErrorHandler_Function)
	_ADO_EVENT_Wrapper(_ADO_EVENT_UserHandler)

	; Open connection with ConnectionString
	Local $sPassword = 'AutoIt' ; CHANGE TO YOUR OWN PASS
	Local $sInstance = 'localhost\SQLExpress' ; CHANGE TO YOUR OWN MS SQL SERVER INSTANCES
	Local $oConnection = _ADO_Connection_Create()
	_ADO_Connection_OpenConString($oConnection, "PROVIDER=SQLOLEDB.1;SERVER=" & $sInstance & ";uid=sa;pwd=" & $sPassword & ";")

	; TRY TO USE EACH OF THIS 2 FOLLOWING LINE, JUST COMMENT FIRST OR SECOND LINE
;~ 	_ADO_EVENTS_ShowOnly_InfoMessages(False)
	_ADO_EVENTS_ShowOnly_InfoMessages(True)

	Local $sTesting_DataBaseName = 'AutoIt_Test_DataBase'
	Local $sTesting_Table = 'TestEvents'

	Local $oRecordset_Tables = _ADO_OpenSchema_Tables($oConnection, $sTesting_DataBaseName, Default, $sTesting_Table)
	If @error >= $ADO_ERR_RECORDSETEMPTY Then
		_ADO_Execute($oConnection, "CREATE TABLE [" & $sTesting_DataBaseName & "].dbo.[" & $sTesting_Table & "] ([ColumnTest] [nchar](100) NULL) ON [PRIMARY]")
		If @error Then ConsoleWrite('! ---> @error=' & @error & '  @extended=' & @extended & ' : CREATE TABLE' & @CRLF)
		$oRecordset_Tables = _ADO_OpenSchema_Tables($oConnection, $sTesting_DataBaseName, Default, $sTesting_Table)
	EndIf
	_ADO_Recordset_Display($oRecordset_Tables, 'Schema for table: ' & $sTesting_Table)

	; LET INSERT SOME DATA
	Local $sContent = 'Testing ADO EVENTS'
	Local $sContent_Updated = 'Testing ADO EVENTS UPDATED'
	Local $sSQL_Query_Insert = _
			"INSERT INTO [" & $sTesting_DataBaseName & "].dbo.[" & $sTesting_Table & "]" & @CRLF & _
			"([ColumnTest]) VALUES ('" & $sContent & "')" & @CRLF & _
			""
	_ADO_Execute($oConnection, $sSQL_Query_Insert)
	_ADO_Execute($oConnection, $sSQL_Query_Insert)
	_ADO_Execute($oConnection, $sSQL_Query_Insert)

	; UPDATE THEM
	Local $sSQL_Query_Update = _
			"UPDATE [" & $sTesting_DataBaseName & "].dbo.[" & $sTesting_Table & "]" & @CRLF & _
			"SET [ColumnTest]='" & $sContent_Updated & "'" & @CRLF & _
			"WHERE [ColumnTest]='" & $sContent & "'" & @CRLF & _
			""
	_ADO_Execute($oConnection, $sSQL_Query_Update)
	ConsoleWrite('- UPDATE: RowAffected=' & @extended & @CRLF)

	; SHOW TABLE CONTENT
	Local $oRecordeset = _ADO_Execute($oConnection, _
			"SELECT *" & @CRLF & _
			"FROM [" & $sTesting_DataBaseName & "].dbo.[" & $sTesting_Table & "]" & @CRLF & _
			"")
	_ADO_Recordset_Display($oRecordeset, 'Line #' & @ScriptLineNumber & ' SHOW TABLE CONTENT')

	; DELETE THEM
	_ADO_Execute($oConnection, _
			"DELETE" & @CRLF & _
			"FROM [" & $sTesting_DataBaseName & "].dbo.[" & $sTesting_Table & "]" & @CRLF & _
			"WHERE [ColumnTest]='" & $sContent_Updated & "'" & @CRLF & _
			"")
	If @error Then
		ConsoleWrite('! ---> @error=' & @error & '  @extended=' & @extended & ' : ' & @CRLF)
	Else
		ConsoleWrite('- DELETE: RowAffected=' & @extended & @CRLF)
	EndIf

	$oRecordeset = _ADO_Execute($oConnection, _
			"SELECT *" & @CRLF & _
			"FROM [" & $sTesting_DataBaseName & "].dbo.[" & $sTesting_Table & "]" & @CRLF & _
			"")
	_ADO_Recordset_Display($oRecordeset, 'Line #' & @ScriptLineNumber & ' SHOW TABLE CONTENT')

	_ADO_EVENTS_ShowOnly_InfoMessages(True)
	ConsoleWrite('! ' & @ScriptLineNumber & ' _ADO_EVENTS_ShowOnly_InfoMessages() status = ' & _ADO_EVENTS_ShowOnly_InfoMessages() & @CRLF)
	_ADO_Execute($oConnection, "PRINT 'this is a test - hello - Line 1'")
	_ADO_Execute($oConnection, "RAISERROR('This is the message from the RAISERROR statement', 10, 1)")

	_ADO_EVENTS_ShowOnly_InfoMessages(False)
	ConsoleWrite('! ' & @ScriptLineNumber & ' _ADO_EVENTS_ShowOnly_InfoMessages() status = ' & _ADO_EVENTS_ShowOnly_InfoMessages() & @CRLF)
	_ADO_Execute($oConnection, "DROP TABLE [" & $sTesting_DataBaseName & "].[dbo].[" & $sTesting_Table & "]")

	ConsoleWrite('! ' & @ScriptLineNumber & ' $oConnection.State = ' & $oConnection.State & @CRLF)
	$oConnection.Close
	ConsoleWrite('! ' & @ScriptLineNumber & ' $oConnection.State = ' & $oConnection.State & @CRLF)

EndFunc   ;==>_Example

Func _ADO_EVENT_UserHandler($param0, ByRef $oConnection_param1, ByRef $oCommand_param3, ByRef $oRecordset_param3, ByRef $oError_param4, $param5 = Null, $param6 = Null, $param7 = Null, $param8 = Null, $param9 = Null)
	Switch $param0
		Case 'Disconnect'
			MsgBox($MB_OK + $MB_TOPMOST + $MB_ICONINFORMATION, 'Information', 'ADO Connection was disconnected.')
		Case Else
	EndSwitch
	#forceref $param0, $oConnection_param1, $oCommand_param3, $oRecordset_param3, $oError_param4, $param5, $param6, $param7, $param8, $param9
EndFunc   ;==>_ADO_EVENT_UserHandler
