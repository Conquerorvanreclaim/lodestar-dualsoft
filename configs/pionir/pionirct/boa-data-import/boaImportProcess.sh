#!/bin/sh
#
# Start/stop jar service
#
# chkconfig: 345 20 80
# description: Start and stop server

#export JAVA_HOME=/usr/java/jdk1.7.0_55
#export JAVA_HOME=/usr/java/jdk1.8.0_144
export JAVA_HOME=

#export PATH=$JAVA_HOME/bin:$PATH

   if [ -z "$2" -o "$2" == " " ]; then
        echo "no channelCode parameter";
        exit 1;
   fi

   if [ -z "$3" -o "$3" == " " ]; then
        echo "no channelType parameter";
        exit 1;
   fi

scriptFile=$(readlink -fn $(type -p $0))                   # the absolute, dereferenced path of this script file
scriptDir=$(dirname $scriptFile)                           # absolute path of the script directory
applDir="$scriptDir"                                       # home directory of the service application
serviceNameLo="boaImportService_$2"                             # service name with the first letter in lowercase
serviceLogFile="/usr/local/boaimport/$serviceNameLo.log"               # log file for StdOut/StdErr
maxShutdownTime=15                                         # maximum number of seconds to wait for the daemon to terminate normally
pidFile="/usr/local/boaimport/$serviceNameLo.pid"                      # name of PID file (PID = process ID number)
javaCommand="java"                                         # name of the Java launcher without the path
javaExe="$JAVA_HOME/bin/$javaCommand"                      # file name of the Java application launcher executable
javaVMOptions="-Xmx512m -Xms256m"
javaArgs="-jar "                                  # arguments for Java launcher
#jarFile="/usr/local/boaimport/data/boa-data-import.jar"
jarFile=$1
jarArgs="$2 $3 $4"                                      #input params: first parameter is channelCode, second is channel type
javaCommandLine="$javaExe $javaVMOptions $javaArgs $jarFile $jarArgs"                       # command line to start the Java service application
javaCommandLineKeyword="boaImportService_$2"                    # a keyword that occurs on the commandline, used to detect an already running service process and to distinguish it from others
rcFileBaseName="rc$serviceNameLo"                          # basename of the "rc" symlink file for this script
rcFileName="/usr/local/boaimport/$rcFileBaseName"               # full path of the "rc" symlink file for this script
etcInitDFile="/etc/init.d/$serviceNameLo"                  # symlink to this script from /etc/init.d

# Makes the file $1 writable by the group $serviceGroup.
function makeFileWritable {
   local filename="$1"
   touch $filename || return 1
   chmod g+w $filename || return 1
   return 0; }

# Returns 0 if the process with PID $1 is running.
function checkProcessIsRunning {
   local pid="$1"
   if [ -z "$pid" -o "$pid" == " " ]; then return 1; fi
   if [ ! -e /proc/$pid ]; then return 1; fi
   return 0; }

# Returns 0 when the service is running and sets the variable $servicePid to the PID.
function getServicePid {
   if [ ! -f $pidFile ]; then return 1; fi
   servicePid="$(<$pidFile)"
   checkProcessIsRunning $servicePid || return 1
   return 0; }

function startServiceProcess {
   cd $applDir || return 1
   rm -f $pidFile
   makeFileWritable $pidFile || return 1
   makeFileWritable $serviceLogFile || return 1
   echo "
$javaCommandLine
"
   $javaCommandLine >/dev/null 2>&1 & echo $! >$pidFile
#   $javaCommandLine >>$serviceLogFile 2>&1 & echo $! >$pidFile
   sleep 0.1
   servicePid="$(<$pidFile)"
   if checkProcessIsRunning $servicePid; then :; else
      echo -ne "
$serviceNameLo start failed, see logfile.
"
      return 1
      fi
   return 0; }

function stopServiceProcess {
   kill $servicePid || return 1
   for ((i=0; i<maxShutdownTime*10; i++)); do
      checkProcessIsRunning $servicePid
      if [ $? -ne 0 ]; then
         rm -f $pidFile
         return 0
         fi
      sleep 0.1
      done
   echo -e "
$serviceNameLo did not terminate within $maxShutdownTime seconds, sending SIGKILL...
"
   kill -s KILL $servicePid || return 1
   local killWaitTime=15
   for ((i=0; i<killWaitTime*10; i++)); do
      checkProcessIsRunning $servicePid
      if [ $? -ne 0 ]; then
         rm -f $pidFile
         return 0
         fi
      sleep 0.1
      done
   echo "
Error: $serviceNameLo could not be stopped within $maxShutdownTime+$killWaitTime seconds!
"
   return 1; }

function runInConsoleMode {
   getServicePid
   if [ $? -eq 0 ]; then echo "
$serviceNameLo is already running
"; return 1; fi
   cd $applDir || return 1
   $javaCommandLine || return 1
   if [ $? -eq 0 ]; then return 1; fi
   return 0; }

function startService {
   getServicePid
   if [ $? -eq 0 ]; then echo -n "
$serviceNameLo is already running
";
        return 0; fi
   echo -n "
Starting $serviceNameLo
"
   startServiceProcess
   if [ $? -ne 0 ]; then
        return 1; fi
   return 0; }

function stopService {
   getServicePid
   if [ $? -ne 0 ]; then echo -n "
$serviceNameLo is not running
";
        return 0; fi
   echo -n "Stopping $serviceNameLo
"
   stopServiceProcess
   if [ $? -ne 0 ]; then
        return 1; fi
   return 0; }

function checkServiceStatus {
   echo -n "Checking for $serviceNameLo:   "
   if getServicePid; then
        echo "Running
"
    else
        echo "Not running
"
      fi
   return 0; }

function installService {
   ln -s $scriptFile $etcInitDFile || return 1
   echo $serviceNameLo installed.
   return 0; }

function uninstallService {
echo $etcInitDFile
   rm -f $etcInitDFile
   echo $serviceNameLo uninstalled.
   return 0; }

function main {
   case "$1" in
      console)                                             # runs the Java program in console mode
         runInConsoleMode
         ;;
      start)                                               # starts the Java program as a Linux service
         startService
         ;;
      stop)                                                # stops the Java program service
         stopService
         ;;
      restart)                                             # stops and restarts the service
         stopService && startService
         ;;
      status)                                              # displays the service status
         checkServiceStatus
         ;;
      install)                                             # installs the service in the OS
         installService
         ;;
      uninstall)                                           # uninstalls the service in the OS
         uninstallService
         ;;
      *)
         echo "Usage: $0 <channelCode> <channelType> {console|start|stop|restart|status|install|uninstall}"
         exit 1
         ;;
      esac
        }

main $5
