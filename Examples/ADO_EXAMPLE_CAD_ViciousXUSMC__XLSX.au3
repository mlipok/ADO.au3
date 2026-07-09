;~ #AutoIt3Wrapper_UseX64=Y

#Tidy_Parameters=/sort_funcs /reel
#AutoIt3Wrapper_Au3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 -w 7

#include <Array.au3>
#include <MsgBoxConstants.au3>
#include <AutoItConstants.au3>
#include "..\ADO.au3"

; SetUP internal ADO.au3 UDF COMError Handler
_ADO_ComErrorHandler_UserFunction(_ADO_COMErrorHandler_Function)

; Uncomment one of the following examples
;
_Example_MSExcel()


Func _Example_MSExcel()

	Local $sFileFullPath = @ScriptDir & '\ADO_EXAMPLE_CAD.xlsx' ; Here put FileFullPath to your Access File or use Default to open FileOpenDialog
	Local $sProvider = 'Microsoft.ACE.OLEDB.12.0'
	Local $sExtProperties = Default
	Local $HDR = Default
	Local $IMEX = Default

	Local $sConnectionString = _ADO_ConnectionString_Excel($sFileFullPath, $sProvider, $sExtProperties, $HDR, $IMEX)

	_Example_2_RecordsetDisplay($sConnectionString, "select * from [Sheet1$]")

EndFunc   ;==>_Example_MSExcel
#Region Common / internal


Func _Example_2_RecordsetDisplay($sConnectionString, $sQUERY)

	; Create connection object
	Local $oConnection = _ADO_Connection_Create()

	; Open connection with $sConnectionString
	_ADO_Connection_OpenConString($oConnection, $sConnectionString)
	If @error Then Return SetError(@error, @extended, $ADO_RET_FAILURE)

	; Executing some query directly to Array of Arrays (instead to $oRecordset)
	Local $aRecordset = _ADO_Execute($oConnection, $sQUERY, True)

	; Clean Up
	_ADO_Connection_Close($oConnection)
	$oConnection = Null

	; Display Array Content with column names as headers
	_ADO_Recordset_Display($aRecordset, 'Recordset content')

EndFunc   ;==>_Example_2_RecordsetDisplay
#EndRegion Common / internal
