#!/bin/bash

# Script to scan current files with clam

curDir=`pwd`

logFileName="clamscan.log"

logCreatedOn=`date +%Y%m%d-%T`

spacer="-------------------------------------------------------------------------------"

sudo freshclam


echo >> $logFileName

echo | tee -a $logFileName
echo $spacer | tee -a $logFileName

echo "Virus scanning against "$curDir"..." | tee -a $logFileName
echo "Scan started on "$logCreatedOn | tee -a $logFileName

clamscan -ri --log=$logFileName

echo | tee -a $logFileName
echo "Scan completd @ "`date +%Y%m%d-%T` | tee -a $logFileName
echo $spacer | tee -a $logFileName
