# Connection strings

ADO uses connection strings to select a provider or driver and describe how to reach a data source.

## UDF helpers

ADO.au3 includes helpers for selected data sources, including functions such as:

- `_ADO_ConnectionString_Access()`
- `_ADO_ConnectionString_Excel()`
- `_ADO_ConnectionString_MySQL()`
- `_ADO_ConnectionString_Oracle()` — currently marked work in progress in the UDF changelog
- `_ADO_Connection_OpenMSSQL()`
- `_ADO_Connection_OpenMSSQL_WinAuth()`

The exact signatures and defaults can change between beta versions. Check the current function headers before copying parameters from an older script.

## Generic connection workflow

For providers not covered by a dedicated helper:

1. Construct the complete connection string.
2. Create a connection with `_ADO_Connection_Create()`.
3. Pass the string to `_ADO_Connection_OpenConString()`.
4. Check `@error` and `_ADO_GetLastCOMErrorDescription()`.

## Authentication

Common authentication models include:

- Windows integrated authentication,
- database username and password,
- file-based data sources without a database login,
- DSN-based ODBC configuration.

Prefer integrated authentication where supported. Avoid embedding production credentials directly in source files.

## Architecture compatibility

Provider and driver architecture must match the AutoIt process architecture:

- 32-bit AutoIt requires a 32-bit provider or ODBC driver.
- 64-bit AutoIt requires a 64-bit provider or ODBC driver.

A provider visible to one architecture may be unavailable to the other.

## Troubleshooting checklist

When a connection fails, verify:

- provider or driver installation,
- 32-bit versus 64-bit compatibility,
- server and instance name,
- database or file path,
- authentication method,
- network access and firewall rules,
- escaping and quoting inside the connection string,
- whether the selected provider supports the requested data source format.

Use `_ADO_GetProvidersList()` and `_ADO_GetDSNList()` to inspect locally available components where applicable.
