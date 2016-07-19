# bginfo

#### Table of Contents

1. [Overview](#overview)
2. [Setup - The basics of getting started with bginfo](#setup)
    * [Setup requirements](#setup-requirements)
    * [Beginning with bginfo](#beginning-with-skel)

## Overview

BGInfo automatically displays relevant information about a Windows computer on the desktop's background, such as the computer name, IP address, service pack version, and more. This module installs bginfo using chocolatey and deploys a default template configuration.

## Setup

### Setup Requirements 
Classify your Windows node with the bginfo class. You'll need chocolatey there at some point to install the software.
The module includes the default bgi configuration file which includes a lot of information, feel free to replace it with one that fits your use case.
For more information on bginfo, visit https://technet.microsoft.com/en-us/sysinternals/bginfo.aspx

### Beginning with bginfo

There are three parameters in the init class:
 * $conffile: Puppet path to the configuration file.
 * $confpath: Where to store BGInfo configuration's file in the target system.
 * $setonstart: Configure a BAT script to start bginfo when any user logs in.
