# ADO.au3 documentation

This directory contains project documentation for the **ADO.au3 UDF**.

ADO.au3 provides AutoIt wrappers and helper functions for Microsoft ActiveX Data Objects (ADO), including database connections, commands, queries, recordsets, schema inspection, provider discovery, COM error handling, events, and selected transaction-related workflows.

## Documentation index

- [Getting started](getting-started.md)
- [Connection strings](connection-strings.md)
- [Providers and drivers](providers-and-drivers.md)
- [Recordsets and query results](recordsets.md)
- [API overview](api-overview.md)
- [Troubleshooting](troubleshooting.md)
- [References and support](links.md)

## Repository files

The main project files are:

- `ADO.au3` — the main UDF implementation.
- `ADO_CONSTANTS.au3` — ADO constants and UDF-specific error/return constants.
- example scripts — practical demonstrations of supported database and ADO workflows, when present in the repository.

## Release status

The repository currently preserves the public `2.1.21 BETA` development baseline. Review the UDF changelog before updating an existing script because some releases include script-breaking changes.

## Documentation scope

The pages in this directory describe the intended UDF workflow and common integration concerns. Function headers in `ADO.au3` remain the authoritative source for exact parameter order, return values, `@error`, and `@extended` behavior.