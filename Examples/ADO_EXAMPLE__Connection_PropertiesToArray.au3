#Tidy_Parameters=/sort_funcs /reel
#AutoIt3Wrapper_Au3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 -w 7

#include <Array.au3>
#include <MsgBoxConstants.au3>
#include "..\ADO.au3"

_ADO_ComErrorHandler_UserFunction(_ADO_COMErrorHandler_Function)
_Example_ListProperties()

Func _Example_ListProperties()
	Local $oADOConnection = ObjCreate("ADODB.Connection") ; Create a connection object
	If @error Then Exit MsgBox($MB_ICONERROR, "Error", "Error " & @error & " creating the connection object!")

	#cs
		Local $sDriver = 'SQL Server'
		Local $sServer = 'localhost\SQLExpress'
		Local $sDataBase = ''
		Local $sUserName = ''
		Local $sPassword = ''
		$oADOConnection.open("DRIVER={" & $sDriver & "};SERVER=" & $sServer & ";DATABASE=" & $sDataBase & ";uid=" & $sUserName & ";pwd=" & $sPassword & ";APP=" & @ScriptName & ";")
	#ce

	; Open the connection
	Local $sADOConnectionString = 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=' & @ScriptDir & ';Extended Properties="Text;HDR=NO;FMT=Delimited(,)"'
	$oADOConnection.Open($sADOConnectionString)
	If @error Then Exit MsgBox($MB_ICONERROR, "Error", "Error " & @error & " opening the connection object!")

	Local $aProperties = _ADO_Connection_PropertiesToArray($oADOConnection)

	_ArrayDisplay($aProperties, "ADO connection - List of properties", "", 0, Default, "Name|Type|Value|Attributes")

EndFunc   ;==>_Example_ListProperties
