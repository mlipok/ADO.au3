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
	_ADO_EVENTS_ShowOnly_InfoMessages(False)
;~ 	_ADO_EVENTS_ShowOnly_InfoMessages(True)

	Local $sTesting_DataBaseName = 'AutoIt_Test_DataBase'
	Local $sTesting_Table = 'TestTransactions'

	Local $oRecordset_Tables = _ADO_OpenSchema_Tables($oConnection, $sTesting_DataBaseName, Default, $sTesting_Table)
	If @error >= $ADO_ERR_RECORDSETEMPTY Then
		_ADO_Execute($oConnection, "CREATE TABLE [" & $sTesting_DataBaseName & "].dbo.[" & $sTesting_Table & "] ([ColumnTest] [nchar](100) NULL) ON [PRIMARY]")
		If @error Then ConsoleWrite('! ---> @error=' & @error & '  @extended=' & @extended & ' : CREATE TABLE' & @CRLF)
		$oRecordset_Tables = _ADO_OpenSchema_Tables($oConnection, $sTesting_DataBaseName, Default, $sTesting_Table)
	EndIf
	_ADO_Recordset_Display($oRecordset_Tables, 'Schema for table: ' & $sTesting_Table)

	; LET INSERT SOME DATA
	Local $sSQL_Query_Insert = _
			"INSERT INTO [" & $sTesting_DataBaseName & "].dbo.[" & $sTesting_Table & "]" & @CRLF & _
			"([ColumnTest]) VALUES ('XXX')" & @CRLF & _
			""
	_ADO_Execute($oConnection, $sSQL_Query_Insert)

	;https://docs.microsoft.com/en-us/sql/ado/reference/ado-api/begintrans-committrans-and-rollbacktrans-methods-example-vb?view=sql-server-ver15
	#Region - Transactional SQL queries
	$oConnection.BeginTrans()

	For $iLoop_idx = 1 To 10 ; now add 10 new rows
		_ADO_Execute($oConnection, StringReplace($sSQL_Query_Insert, 'XXX', $iLoop_idx))
	Next

	Local $oRecordset_test = _ADO_Execute($oConnection, "SELECT * FROM [" & $sTesting_DataBaseName & "].dbo.[" & $sTesting_Table & "]")
	_ADO_Recordset_Display($oRecordset_test, 'Test Insterted data')

	If $IDYES = MsgBox($MB_YESNO + $MB_TOPMOST + $MB_ICONQUESTION + $MB_DEFBUTTON1, 'Question', _
			'Save all changes ?') Then
		$oConnection.CommitTrans()
	Else
		$oConnection.RollbackTrans()
	EndIf
	#EndRegion - Transactional SQL queries

	Local $oRecordset_Final = _ADO_Execute($oConnection, "SELECT * FROM [" & $sTesting_DataBaseName & "].dbo.[" & $sTesting_Table & "]")
	_ADO_Recordset_Display($oRecordset_Final, 'Finally testing data')

	_ADO_Execute($oConnection, "DROP TABLE [" & $sTesting_DataBaseName & "].[dbo].[" & $sTesting_Table & "]")

	$oConnection.Close

EndFunc   ;==>_Example

Func _ADO_EVENT_UserHandler($param0, ByRef $oConnection_param1, ByRef $oCommand_param3, ByRef $oRecordset_param3, ByRef $oError_param4, $param5 = Null, $param6 = Null, $param7 = Null, $param8 = Null, $param9 = Null)
	Switch $param0
		Case 'Disconnect'
			MsgBox($MB_OK + $MB_TOPMOST + $MB_ICONINFORMATION, 'Information', 'ADO Connection was disconnected.')
		Case Else
	EndSwitch
	#forceref $param0, $oConnection_param1, $oCommand_param3, $oRecordset_param3, $oError_param4, $param5, $param6, $param7, $param8, $param9
EndFunc   ;==>_ADO_EVENT_UserHandler
