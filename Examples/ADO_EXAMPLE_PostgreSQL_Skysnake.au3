#AutoIt3Wrapper_UseX64=N

#Tidy_Parameters=/sort_funcs /reel
#AutoIt3Wrapper_Run_AU3Check=Y
#AutoIt3Wrapper_Au3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 -w 7

#AutoIt3Wrapper_Run_Au3Stripper=Y
#Au3Stripper_Parameters=/RM

#include <File.au3>
#include <Array.au3>
#include <MsgBoxConstants.au3>
#include <AutoItConstants.au3>
#include "..\ADO.au3"

; SetUP internal ADO.au3 UDF COMError Handler
_ADO_ComErrorHandler_UserFunction(_ADO_COMErrorHandler_Function)

; You can use your own COMErrorHandler instead internal ADO.au3 UDF COMError Handler
;~ _ADO_ComErrorHandler_UserFunction(_ErrFunc)

Global $oCon = Null ; $oConnection

_fMyADO_test()
Func _fMyADO_test()

;~ 	Local $sDSN = 'PostgreSQL35W' ; Default
	Local $sDSN = 'PostgreSQL ODBC Driver(ANSI)' ; Default
	Local $sDatabase = 'fred' ; db name --- default 'postgres'
	Local $sServer = '199.19.213.182' ; Server IP
	Local $sPort = '5432' ; Port
	Local $sUser = 'fred' ; PostGre Username
	Local $sPassword = 'autoit' ; PostGre User Password

	Local $sConnectionString = 'DSN=' & $sDSN & ';DATABASE=' & $sDatabase & ';SERVER=' & $sServer & ';PORT=' & $sPort & ';UID=' & $sUser & ';PWD=' & $sPassword & ';'

	; Create connection object
	Local $oConnection = _ADO_Connection_Create()

	; Open connection with $sConnectionString
	_ADO_Connection_OpenConString($oConnection, $sConnectionString)
	If @error Then Return SetError(@error, @extended, $ADO_RET_FAILURE)

	$oCon = $oConnection

	Local $Query, $aQresult, $Qresult

	ConsoleWrite("_Example_PostgreSQL " & $sConnectionString & @CRLF)
	;_Example_1_RecordsetToConsole($sConnectionString, "Select * from tran where acno='YW0067' limit 100")
	;_Example_2_RecordsetDisplay($sConnectionString, "Select * from pg_database   ") ; find all db names
	;_Example_2_RecordsetDisplay($sConnectionString, "Select * from pg_taBLES where tableowner='postgres' order by 2  ") ; find all db names
	;_Example_2_RecordsetDisplay($sConnectionString, "Select acno as ACNO, regexp_replace(name, '\s+$', '') as NAME, regexp_replace(epos, '\s+$', '') as EPOS, tel  as TEL, groep  as GROEP from client ;") ; where groep like '%N%' ")
	;_Example_3_ConnectionProperties($sConnectionString)

	;   $Query = "create table t_Alpheus (text text, seq serial) ; "
	;   $Qresult = _ADO_Execute($oCon, $Query)
	;   ConsoleWrite("$Qresult " & $Qresult & @CRLF)

	;_Example_2_RecordsetDisplay($sConnectionString, "Select * from pg_taBLES where tableowner='postgres' order by 2  ") ; find all db names
	$Query = ''
	$Query = "insert into t_Alpheus (text) values ('new 64 This is text :)') ;" ; returning 'Okay' ; "
	$aQresult = _ADO_Execute($oCon, $Query, True)
	;_ArrayDisplay($aQresult[1])
	;_ArrayDisplay($aQresult[2])
	;_ArrayDisplay($aQresult[3])
	;$Qresult = _ArrayToString($aQresult[2])
	ConsoleWrite("1 $Query " & $Query & @CRLF)
	ConsoleWrite("1 $Qresult " & $Qresult & @CRLF)
	ConsoleWrite("1 $aQresult " & $aQresult & @CRLF)
	$aQresult = ''

	;_Example_2_RecordsetDisplay($sConnectionString, "Select * from t_Alpheus   ")
	#cs
		$Query = "Delete from t_Alpheus returning 'Okay' ; "
		;$aQresult = _ADO_Execute($oCon, $Query, True)
		;_ArrayDisplay($aQresult[2])
		$Qresult = _ArrayToString($aQresult[2])
		;$Qresult &= $aQresult[2]
		ConsoleWrite("$Qresult " & $Qresult & @CRLF)
	#ce
	$Query = "Select * from t_Alpheus ; "
	$aQresult = _ADO_Execute($oCon, $Query, True)
	$Qresult = _ArrayToString($aQresult[2])
	ConsoleWrite("2 $Query " & $Query & @CRLF)
	ConsoleWrite("2 $Qresult " & $Qresult & @CRLF)
	$aQresult = ''

	;_Example_2_RecordsetDisplay($sConnectionString, "Select * from t_Alpheus   ")

EndFunc   ;==>_fMyADO_test
