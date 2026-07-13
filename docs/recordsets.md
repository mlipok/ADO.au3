# Recordsets and query results

ADO queries commonly return an `ADODB.Recordset` object. ADO.au3 provides helpers for validating, displaying, converting, searching, saving, and loading recordsets.

## Core helpers

- `_ADO_Recordset_Create()` — creates a recordset object.
- `_ADO_Recordset_Display()` — displays a recordset or supported recordset array.
- `_ADO_Recordset_ToArray()` — converts a recordset into an AutoIt array structure.
- `_ADO_Recordset_ToString()` — converts recordset content into a delimited string.
- `_ADO_Recordset_Find()` — searches for a row matching ADO criteria.
- `_ADO_RecordsetArray_GetContent()` — extracts row data from the UDF recordset-array structure.
- `_ADO_RecordsetArray_GetFieldNames()` — extracts field names from that structure.
- `_ADO_Recordset_Save()` and `_ADO_Recordset_Load()` — currently marked work in progress in the UDF changelog.

## `_ADO_Recordset_ToArray()` result forms

The function supports two result layouts:

- With `$bFieldNamesInFirstRow = True`, it returns a two-dimensional array with field names in row zero.
- With `$bFieldNamesInFirstRow = False`, it returns the UDF recordset-array structure containing separate field-name and row-content arrays.

The second form avoids moving every row to insert column names and is generally preferable for large recordsets.

## Cursor position

Conversion functions attempt to preserve the current recordset position when bookmarks and cursor capabilities are supported. Behavior can depend on the selected provider, cursor type, and recordset capabilities.

Do not assume every provider supports:

- bookmarks,
- moving backward,
- accurate `RecordCount`,
- client-side cursors,
- disconnected recordsets.

## Empty results

An executed query can succeed while returning an empty recordset. Distinguish between:

- SQL or COM failure,
- a valid recordset with zero rows,
- an action query that does not return a recordset.

Check the function return value and `@error` rather than relying only on object existence.

## Large result sets

For large datasets:

- select only required columns,
- filter rows in SQL,
- avoid displaying entire recordsets during normal operation,
- consider paging or batching,
- avoid converting to arrays unless the script needs random access or AutoIt-native processing.
