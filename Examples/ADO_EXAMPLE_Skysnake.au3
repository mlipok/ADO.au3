Global $g_AdoErrDesc

#Tidy_Parameters=/sort_funcs /reel
#AutoIt3Wrapper_Au3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 -w 7

#include <Array.au3>
#include <File.au3>
#include <MsgBoxConstants.au3>
#include <AutoItConstants.au3>
#include "..\ADO.au3"

Global $oCon = Null ; $oConnection

; SetUP internal ADO.au3 UDF COMError Handler
_ADO_ComErrorHandler_UserFunction(_ADO_COMErrorHandler_Function)

_Example_PostgreSQL_online() ; :)

Func _Example_PostgreSQL_online()

;~ 	Local $sDriver = 'PostgreSQL ODBC Driver(ANSI)'
	Local $sDriver = 'PostgreSQL ANSI' ; https://www.postgresql.org/ftp/odbc/versions/msi/
;~ 	Local $sDriver = 'PostgreSQL35W'
	Local $sDatabase = 'fred'
	Local $sServer = '199.19.213.182' ; change this string to YourServerLocation
	Local $sPort = '6432' ; change this string to If your Server use non standard PORT
	Local $sUser = 'fred' ; change this string to YourUserName
	Local $sPassword = 'fred' ; change this string to YourPassword

	Local $sConnectionString = 'Driver={' & $sDriver & '};DATABASE=' & $sDatabase & ';SERVER=' & $sServer & ';PORT=' & $sPort & ';UID=' & $sUser & ';PWD=' & $sPassword & ';'

	Local $ADOErr, $ADOExtErr, $LogErr = @ScriptDir & "\ErrorLog.txt"

	ConsoleWrite("_Example_PostgreSQL " & $sConnectionString & @CRLF)

	; Create connection object
	Local $oConnection = _ADO_Connection_Create()

	; Open connection with $sConnectionString
	_ADO_Connection_OpenConString($oConnection, $sConnectionString)
	If @error Then Return SetError(@error, @extended, $ADO_RET_FAILURE)

	$oCon = $oConnection

	Local $Query, $aQresult, $aResult, $Qresult

	$Query = ''
	$Query = "insert into t_log_access (uname) values ('Skysnake was here') ;"
	$aResult = _ADO_Execute($oCon, $Query, True, True)
	If @error Then
		$ADOErr = @error
		$ADOExtErr = @extended
		MsgBox($MB_SYSTEMMODAL, "ADO SQL Error: " & $ADO_RET_FAILURE, $g_AdoErrDesc & " * " & @CRLF & '@error = ' & @error & @CRLF & '@extended = ' & @extended & @CRLF & $Query & @CRLF)
		_FileWriteLog($LogErr, @CRLF & '------------------------------------------------ SQL ERROR ' & "Error: " & $ADOErr & " * " & "Extended: " & $ADOExtErr & " * " & "ADO Returned " & $ADO_RET_FAILURE & @CRLF & $Query & @CRLF)
		$ADOErr = 0
		$ADOExtErr = 0
	EndIf

	; like SQLite_Exec
	If Not _ADO_Execute($oCon, "CREATE temp TABLE persons (Name text, Age int);") = $ADO_ERR_SUCCESS Then
		ConsoleWrite("5a @ERROR " & @error & @CRLF)
		ConsoleWrite("5b @ERROR " & @error & @CRLF)
		ConsoleWrite("5c @extended " & @extended & @CRLF)
	Else
		MsgBox($MB_SYSTEMMODAL, "5. ADO Okay", $ADO_ERR_SUCCESS)
	EndIf

	; like SQLite_GetTable2d
	$Query = "Select * from t_log_access order by 2 desc limit 5; "
	;$aQresult = _ADO_Execute($oCon, $Query, True)

	$aResult = _ADO_Execute($oCon, $Query, True, True)
	If @error Then
		SetError(@error, @extended, $ADO_RET_FAILURE)
		$ADOErr = @error
		$ADOExtErr = @extended
		MsgBox($MB_SYSTEMMODAL, "ADO SQL Error: " & $ADO_RET_FAILURE, $g_AdoErrDesc & " * " & @CRLF & '@error = ' & @error & @CRLF & '@extended = ' & @extended & @CRLF & $Query & @CRLF)
		_FileWriteLog($LogErr, @CRLF & '------------------------------------------------ SQL ERROR ' & "Error: " & $ADOErr & " * " & "Extended: " & $ADOExtErr & " * " & "ADO Returned " & $ADO_RET_FAILURE & @CRLF & $Query & @CRLF)
		$ADOErr = 0
		$ADOExtErr = 0
	EndIf
	ConsoleWrite(_ArrayDisplay($aResult))

	; PREPAREd statement
	$Query = "PREPARE myloginsert (text ) AS  INSERT INTO t_log_access (uname  ) values ( $1 ) ; "
	;$aQresult = _ADO_Execute($oCon, $Query, True)

	$aResult = _ADO_Execute($oCon, $Query, True, True)
	If @error Then
		SetError(@error, @extended, $ADO_RET_FAILURE)
		$ADOErr = @error
		$ADOExtErr = @extended
		MsgBox($MB_SYSTEMMODAL, "ADO SQL Error: " & $ADO_RET_FAILURE, $g_AdoErrDesc & " * " & @CRLF & '@error = ' & @error & @CRLF & '@extended = ' & @extended & @CRLF & $Query & @CRLF)
		_FileWriteLog($LogErr, @CRLF & '------------------------------------------------ SQL ERROR ' & "Error: " & $ADOErr & " * " & "Extended: " & $ADOExtErr & " * " & "ADO Returned " & $ADO_RET_FAILURE & @CRLF & $Query & @CRLF)
		$ADOErr = 0
		$ADOExtErr = 0
	EndIf

	$Query = "EXECUTE myloginsert ('skysnake from a prepared statement' )  ; "
	;$aQresult = _ADO_Execute($oCon, $Query, True)

	$aResult = _ADO_Execute($oCon, $Query, True, True)
	If @error Then
		SetError(@error, @extended, $ADO_RET_FAILURE)
		$ADOErr = @error
		$ADOExtErr = @extended
		MsgBox($MB_SYSTEMMODAL, "ADO SQL Error: " & $ADO_RET_FAILURE, $g_AdoErrDesc & " * " & @CRLF & '@error = ' & @error & @CRLF & '@extended = ' & @extended & @CRLF & $Query & @CRLF)
		_FileWriteLog($LogErr, @CRLF & '------------------------------------------------ SQL ERROR ' & "Error: " & $ADOErr & " * " & "Extended: " & $ADOExtErr & " * " & "ADO Returned " & $ADO_RET_FAILURE & @CRLF & $Query & @CRLF)
		$ADOErr = 0
		$ADOExtErr = 0
	EndIf

	ConsoleWrite("$Query " & $Query & @CRLF)
	ConsoleWrite("$aQresult " & $aQresult & @CRLF)
	ConsoleWrite("$aResult " & $aResult & @CRLF)
	ConsoleWrite("$Qresult " & $Qresult & @CRLF)

EndFunc   ;==>_Example_PostgreSQL_online
