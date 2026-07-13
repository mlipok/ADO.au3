# Getting started

## Requirements

- AutoIt 3.3.10.2 or newer.
- `ADO.au3` and `ADO_CONSTANTS.au3` available to the script.
- A suitable ADO provider or ODBC driver installed for the target database.
- Database credentials and network access where required.

## Basic workflow

A typical script follows this sequence:

1. Include `ADO.au3`.
2. Create an ADO connection object with `_ADO_Connection_Create()`.
3. Build or provide a connection string.
4. Open the connection with `_ADO_Connection_OpenConString()` or a database-specific helper.
5. Execute SQL with `_ADO_Execute()` or use an ADO command object.
6. Process the returned recordset or array.
7. Close the connection with `_ADO_Connection_Close()`.

## Minimal pattern

```autoit
#include "ADO.au3"

Local $oConnection = _ADO_Connection_Create()
If @error Then Exit ConsoleWrite("Unable to create ADO connection." & @CRLF)

Local $sConnectionString = "<provider-specific connection string>"
_ADO_Connection_OpenConString($oConnection, $sConnectionString)
If @error Then Exit ConsoleWrite(_ADO_GetLastCOMErrorDescription() & @CRLF)

Local $sQuery = "SELECT * FROM ExampleTable"
Local $oRecordset = _ADO_Execute($oConnection, $sQuery)
If @error Then
    ConsoleWrite("Query failed: " & _ADO_GetLastQuery() & @CRLF)
    ConsoleWrite(_ADO_GetLastCOMErrorDescription() & @CRLF)
Else
    _ADO_Recordset_Display($oRecordset, "Query result")
EndIf

_ADO_Connection_Close($oConnection)
```

Replace the placeholder connection string and SQL statement with values appropriate for the selected database.

## Error handling

Most public UDF functions use:

- the return value for the function result,
- `@error` for a `$ADO_ERR_*` code,
- `@extended` for additional context.

For failed database operations, also inspect:

- `_ADO_GetLastQuery()`
- `_ADO_GetLastCOMErrorDescription()`

Do not log plaintext passwords or complete connection strings containing secrets.
