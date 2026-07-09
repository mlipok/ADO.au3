;~ https://www.autoitscript.com/forum/topic/180850-adoau3-udf-beta-support-topic/?do=findComment&comment=1463262

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

