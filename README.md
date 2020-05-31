# Virus-Scanner
A bash script that can be used to scan locations of your drive with 
**ClamAV**

## Objective
To have a little program that takes advantage of ClamAV's functionalities
to scan your files and create a log file to reviewi. Wrote this so I can schedule
with Jenkins and notify me when issues arise. 

### TODOs
Build a function that will scan the log and notify you via email if there are
any issues found.

## Requirements
Installation and config of ClamAV - [ClamAV](https://www.clamav.net/)

## Options
You can run the virus-scan.sh with the following options

**-l**

This will create the virus-scan.log file in the same location where it's running.
Running it with out the option will create the log file under /var/log/virus-scan

## Usage
./virus-scan.sh

With the option -l

/virus-scan.sh -l
