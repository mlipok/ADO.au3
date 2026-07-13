# Troubleshooting

## Provider cannot be found

Symptoms may include COM errors indicating that the provider is not registered or cannot be instantiated.

Check:

- provider or ODBC driver installation,
- 32-bit versus 64-bit AutoIt architecture,
- exact provider or driver name,
- DSN scope and architecture,
- deployment prerequisites on the target computer.

Use `_ADO_GetProvidersList()` and `_ADO_GetDSNList()` where applicable.

## Connection fails

Verify:

- server, instance, database, and file path,
- authentication method and credentials,
- network access and firewall rules,
- encryption and certificate requirements,
- quoting and delimiters in the connection string,
- connection timeout values.

Inspect `_ADO_GetLastCOMErrorDescription()` and remove secrets before sharing logs.

## Query fails

Inspect both:

- `_ADO_GetLastQuery()`
- `_ADO_GetLastCOMErrorDescription()`

Also verify command type and execution options when using the newer `_ADO_Execute()` parameters.

Avoid SQL built through direct concatenation of external input. Prefer parameterized command objects.

## Query returns no rows

A successful execution can return an empty recordset. Confirm:

- the query filters,
- the selected database and schema,
- transaction visibility,
- permissions,
- whether the statement is an action query rather than a row-returning query.

## RecordCount is unexpected

Some providers and cursor types do not expose an accurate `RecordCount` until the cursor is moved or configured differently. Do not treat `RecordCount = -1` as proof that the query failed.

## Recordset conversion fails

Check whether the recordset is:

- valid,
- open and ready,
- non-empty,
- using a cursor that supports the required movement or bookmarks.

Provider capabilities affect `_ADO_Recordset_ToArray()` and `_ADO_Recordset_ToString()` behavior.

## COM error handler behavior

ADO.au3 installs wrappers for COM error handling and ADO events. When integrating custom handlers:

- do not discard `@error` and `@extended` unintentionally,
- avoid recursive logging that triggers additional COM operations,
- keep user callbacks lightweight,
- confirm that event callbacks remain referenced and are not stripped by build tools.

## Beta compatibility

The repository preserves a beta release and its changelog includes script-breaking changes. When upgrading:

1. Review renamed and removed functions.
2. Check parameter order and defaults.
3. Re-test authentication selection for MSSQL helpers.
4. Re-test recordset conversion and cursor behavior.
5. Re-test custom event and error-handler callbacks.
