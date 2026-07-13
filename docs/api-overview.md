# API overview

This page groups the public ADO.au3 functions by responsibility. Refer to function headers in `ADO.au3` for exact signatures and return contracts.

## Connection lifecycle

- `_ADO_Connection_Create()`
- `_ADO_Connection_OpenConString()`
- `_ADO_Connection_OpenMSSQL()`
- `_ADO_Connection_OpenMSSQL_WinAuth()`
- `_ADO_Connection_Close()`
- `_ADO_Connection_Timeout()`
- `_ADO_Connection_CommandTimeout()`
- `_ADO_Connection_PropertiesToArray()`

## Connection-string helpers

- `_ADO_ConnectionString_Access()`
- `_ADO_ConnectionString_Excel()`
- `_ADO_ConnectionString_MySQL()`
- `_ADO_ConnectionString_Oracle()` — work in progress

## Query and command execution

- `_ADO_Execute()`
- `_ADO_Command_Create()`
- `_ADO_Command_CreateParameter()`
- `_ADO_Command_Execute()`
- `_ADO_GetLastQuery()`

Use command objects and parameters when values originate from users or external data. Do not concatenate untrusted values directly into SQL.

## Recordsets

- `_ADO_Recordset_Create()`
- `_ADO_Recordset_Display()`
- `_ADO_Recordset_Find()`
- `_ADO_Recordset_ToArray()`
- `_ADO_Recordset_ToString()`
- `_ADO_RecordsetArray_GetContent()`
- `_ADO_RecordsetArray_GetFieldNames()`

## Schema inspection

The UDF includes functions for opening and retrieving schema information such as catalogs, tables, columns, indexes, and views. Schema availability differs by provider.

## Provider and environment discovery

- `_ADO_GetProvidersList()`
- `_ADO_GetDSNList()`
- `_ADO_MSSQL_GetProviderVersion()`
- `_ADO_MSSQL_GetDriverVersion()`
- `_ADO_Version()`
- `_ADO_UDFVersion()`

## Events and diagnostics

- `_ADO_EVENT_Wrapper()`
- `_ADO_COMErrorHandler_Function()`
- `_ADO_COMErrorHandler_UserFunction()`
- `_ADO_EVENTS_ShowOnly_InfoMessages()`
- `_ADO_GetLastCOMErrorDescription()`
- `_ADO_ConsoleOutput()`

The UDF also defines internal `__ADO_EVENT__*` callbacks. Treat double-underscore functions as implementation details unless the UDF documentation explicitly instructs otherwise.

## Transactions

ADO connection objects support transaction workflows. Review the included transaction example and provider-specific behavior before relying on nested transactions or transaction-level return values.
