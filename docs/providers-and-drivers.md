# Providers and drivers

The database engine is accessed through an installed ADO provider or ODBC driver. ADO.au3 does not install these components.

## Discovering installed components

Use the UDF discovery helpers where appropriate:

- `_ADO_GetProvidersList()` — returns available OLE DB providers.
- `_ADO_GetDSNList()` — returns configured ODBC data source names.
- `_ADO_MSSQL_GetProviderVersion()` — inspects the Microsoft SQL Server provider version.
- `_ADO_MSSQL_GetDriverVersion()` — inspects the Microsoft SQL Server driver version.

## Provider versus driver

A connection can commonly use either:

- an OLE DB provider directly through ADO, or
- an ODBC driver, often through an ODBC-related provider or DSN.

Database-specific helper functions may expose a parameter that chooses between a provider and a driver. Review the current function header because beta releases have changed parameter order and authentication behavior.

## Deployment considerations

Document the following for every deployed script:

- required provider or driver name,
- minimum supported version,
- required process architecture,
- whether a DSN is required,
- installation source and licensing requirements,
- authentication model,
- encrypted-connection requirements.

## Common failure modes

- Provider is not registered on the computer.
- Provider is installed only for the opposite process architecture.
- Driver name differs between development and target systems.
- DSN exists only for the current user or only as a system DSN.
- An older provider does not support the requested protocol or encryption configuration.
- Office/Access Database Engine architecture conflicts with the installed Microsoft Office architecture.

Provider discovery confirms local registration, but it does not guarantee successful authentication or network access to the target database.
