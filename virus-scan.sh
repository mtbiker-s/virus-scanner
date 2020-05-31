#!/bin/bash

# Script to scan current files with clam


# Setting Variables
# Start
createLocalLogFile=0

curDir=`pwd`

logFileName="virus-scan.log"

logCreatedOn=`date +%Y%m%d-%T`

spacer="-------------------------------------------------------------------------------"
# End
# Setting Variables




# Function usage 
# Will provide information for the program, how to use it
usage(){
    echo "  -l"
    echo "      Will create the virus-scan.log local folder where the script is ran."
    echo "      If -l is not used, virus-scan.log gets created under /var/log/virus-scan" 
    exit
}

# Function logger
# Provides a way to log depending on where you want the log file created locally
# or at /var/log/virus-scan
# You can pass 2 params
# isLocal or $1 is a boolean value that will determine wether to write to the locals virus-scan.log
# or the one under /var/log/virus-scan
# message or $2 is a the text message you want to write to the log file
logger(){

    isLocal=$1
    message=$2

    if [ $isLocal = 1 ]; then
        echo $message | tee -a $logLocation
    else
        # Using sudo because the log file is written to the /var/log area under virus-scan
        sudo echo $message | sudo tee -a $logLocation
    fi

}




# Using getopts for the paramaters that can be passed
# -l for creating a local virus-scan.log
# -h for help on what params to use
while getopts "lh" opt; do
  case $opt in
    l)
      echo $logFileName " will be created in the same directory the scan is ran." >&2
      createLocalLogFile=1 >&2
      ;;
    h)
      usage >&2
      ;;  
    \?)
      echo "Invalid option: -$OPTARG" >&2
      echo
      usage

      ;;
  esac
done




# Running the script here to create the log files in their locations
# depending on whether the -l option for local is used or not
if [ $createLocalLogFile = 1 ]; then
    
    logLocation=$logFileName
    logger $createLocalLogFile
else
    # if its not creating a local virus-scan.log file
    # it will create it under /var/log/virus-scan
    logDir="/var/log/virus-scan"
    logLocation=$logDir"/"$logFileName
    if [ ! -d $logDir ]; then
        sudo mkdir -p $logDir
    fi
    
    if [ ! -f $logLocation ]; then
        sudo touch $logLocation
        sudo chmod +x $logLocation
    fi

    logger $createLocalLogFile
fi




# Program starts to scan from this point
# Needed to update the virus definition files for clamav
sudo freshclam

logger $createLocalLogFile $spacer
logger $createLocalLogFile "Virus scanning against "$curDir"..."
logger $createLocalLogFile "Scan started on "$logCreatedOn

# Will do scan against the current directory where the script is
# ran against.
# E.g. if you are at  /home/you/Documents clamscan will run against that dir
# The option -r is for recursive -i is for display only the files that are infected
# and --log is the name and location of the logfile

if [ $createLocalLogFile = 1 ]; then
    clamscan -ri --log=$logLocation
else
    sudo clamscan -ri --log=$logLocation
fi

logger $createLocalLogFile
logger $createLocalLogFile "Scan completd @ "`date +%Y%m%d-%T`
logger $createLocalLogFile $spacer

if [ $createLocalLogFile = 1 ]; then
    echo "You can view the log under :"
    echo $curDir"/"$logLocation
else
    echo "You can view the log under :"
    echo $logLocation
fi
