# Description

Here is couple scripts, which allow to get information from Active Directory related Security Group user members.

Its very usefull if all security group are created correctly.

# Recommendations for Active Directory Security Groups

Recommend creating Security Group for folder with starting prefix sg_**** without spaces
Also strongly recommend write a description for Security Group - ex. D:\Shared | Full Access

If you have Security Groups using above recommendations - this script will be usefull to your company.

# How to use

## Initial Setup

* copy configuration file in config folder - config.sample.json to config.json
* edit configuration file config.json with your data

## How to get data into console
Note: you should have RSAT installed in your system or run this script in Domain Controller Server.

* run your PowerShell
* launch script called: ge-sgInfo.ps1

## How to setup?

```
.\task-install.ps1
```

## How to uninstall?
```
.\task-uninstall.ps1
```

## How to manual run?
```
.\task-run.ps1
```

## How to get info about task
```
.\task-info.ps1
```