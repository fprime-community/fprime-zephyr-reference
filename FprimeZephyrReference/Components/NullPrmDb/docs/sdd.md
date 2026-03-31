# Components::NullPrmDb

Null parameter database.  Returns error status on any call.

## Requirements

| Name | Description | Validation |
|---|---|---|
|NULL-PRM-DB-001| Return error on any port call | Inspection|

## Usage Examples

Add the instance to a topology:

```
param connections instance nullPrmDb
```

From: https://github.com/Open-Source-Space-Foundation/proves-core-reference/tree/main/PROVESFlightControllerReference/Components/NullPrmDb

## Port Descriptions
| Name | Description |
|---|---|
| getPrm | Get parameter, returns `Fw::ParamValid::INVALID` |
| setPrm | No-op |
