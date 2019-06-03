#!/bin/bash
#
# apaxy configurator
# v0.2
# configure apaxy according to your local paths and configuration
# author : Jordan Bancino and Ploc
# contact : jordan [@] bancino.net
# licence : GPLv3

# enabling strict mode
# -e - exit immediatly on error (disable with "+e" when an error can happens, then enable it again with "-e")
# -u - undefined variables are forbidden (enable this option after getting parameters from $1 $2...) see below
# -o pipefail - find error return code inside piped commands
# IFS - set strong internal field separator
set -eo pipefail
IFS=$'\n\t'

# default config
defaultConfigFile="apaxy.config"
defaultApacheWebRootPath="/var/www/html"
defaultInstallWebPath=""
defaultEnableGallery=false
defaultHeaderMessage=""
defaultFooterMessage=""
defaultLogLevel=2
defaultLogFile="$(basename "${0}" .sh).log"

workingDirectory="$(dirname "${0}")"
logLevel="${defaultLogLevel}"

# functions

###
 # display help
 ##
displayHelp () {
    cat <<EOF
$(basename "${0}") configure apaxy according to your local paths and configuration.

It can either configure apaxy according to your local paths and configuration bu it can also install the required files in your http server path.

EOF
    displayUsage
    cat <<EOF

Available optionnal parameters are :
  -h  - display help
  -c  - set path/to/apaxy.config file that contains all configuration
  -d  - set path/to/dir/ directory where apaxy will be installed on the filesystem
  -w  - set path/to/dir/ directory where apaxy will be available on the httpd server
  -g  - enable or disable gallery feature
  -hm - set the default header message displayed on top of each page
  -fm - set the default footer message displayed on bottom of each page
  -ll - set the log level
  -lf - set the log file
EOF
}

###
 # display usage
 ##
displayUsage () {
    cat <<EOF
usage - $(basename "${0}") [-h] [-c path/to/apaxy.config] [-d path/to/dir/] [-w path/to/dir/] [-g true|false] [-hm "header message"] [-fm "footer message"] [-ll logLevel] [-lf logFile]
EOF
}

###
 # log a message
 #
 # @global $logLevel the log level
 # @global $logFile the log file
 # @param $1 the log level of the message
 # @param $2 the log message
 ##
log () {
    local paramLogLevel="${1}"
    local paramLogMessage="${2}"

    # shellcheck disable=SC2155
    local logDate="$(date +%H:%M:%S)"
    local logMessage="[${logDate}] ${paramLogMessage}"

    if [ "${paramLogLevel}" -le "${logLevel}" ]
    then
        echo "${logMessage}"
    fi

    if [ ! -z "${logFile}" ]
    then
        echo "${logMessage}" >> "${logFile}"
    fi
}

# getting parameters value from cli (can overload config file values)
while [ "$#" -ge 1 ] ; do
    case "${1}" in
        -h|--help) # display help
            displayHelp
            exit 0
            ;;
        -c) # set path/to/apaxy.config file that contains all configuration
            shiftStep=2
            paramConfigFile="${2}"
            ;;
        -d) # set path/to/dir/ directory where apaxy will be available on the httpd server
            shiftStep=2
            paramApacheWebRootPath="${2}"
            ;;
        -w) # set path/to/dir/ directory where apaxy will be installed on the filesystem
            shiftStep=2
            paramInstallWebPath="${2}"
            ;;
        -g) # enable or disable gallery feature
            shiftStep=2
            paramEnableGallery="${2}"
            ;;
        -hm) # set the default header message displayed on top of each page
            shiftStep=2
            paramHeaderMessage="${2}"
            ;;
        -fm) # set the default footer message displayed on bottom of each page
            shiftStep=2
            paramFooterMessage="${2}"
            ;;
        -ll) # set the log level
            shiftStep=2
            paramLogLevel="${2}"
            ;;
        -lf) # set the log file
            shiftStep=2
            paramLogFile="${2}"
            ;;
        *)
            displayUsage
            exit 2
            ;;
    esac

    if [ "$#" -ge "${shiftStep}" ]
    then
        shift "${shiftStep}"
    else
        log 1 "ERROR - invalid number of arguments"
        exit 3
    fi
done

# setting parameters value
if [ -r "${paramConfigFile}" ]
then
    # getting parameters value from config file (config file name set by cli values)
    configFile="${paramConfigFile}"
    # shellcheck source=apaxy.config
    source "${configFile}"
elif [ -r "${workingDirectory}/${defaultConfigFile}" ]
then
    # getting parameters value from config file (config file name is default)
    configFile="${workingDirectory}/${defaultConfigFile}"
    # shellcheck source=apaxy.config
    source "${configFile}"
else
    log 1 "apaxy configuration not found, using internal config from script shell itself"
    configFile=null
fi

if [ -n "${paramApacheWebRootPath}" ]
then
    apacheWebRootPath="${paramApacheWebRootPath}"
elif [ -z "${apacheWebRootPath}" ]
then
    apacheWebRootPath="${defaultApacheWebRootPath}"
fi

if [ -n "${paramInstallWebPath}" ]
then
    installWebPath="${paramInstallWebPath}"
elif [ -z "${installWebPath}" ]
then
    installWebPath="${defaultInstallWebPath}"
fi

if [ -n "${paramApacheWebRootPath}" ]
then
    apacheWebRootPath="${paramApacheWebRootPath}"
elif [ -z "${apacheWebRootPath}" ]
then
    apacheWebRootPath="${defaultApacheWebRootPath}"
fi

if [ -n "${paramInstallWebPath}" ]
then
    installWebPath="${paramInstallWebPath}"
elif [ -z "${installWebPath}" ]
then
    installWebPath="${defaultInstallWebPath}"
fi

installDir="${apacheWebRootPath}${installWebPath}"

if [ -n "${paramEnableGallery}" ]
then
    enableGallery="${paramEnableGallery}"
elif [ -z "${enableGallery}" ]
then
    enableGallery="${defaultEnableGallery}"
fi

if [ -n "${paramHeaderMessage}" ]
then
    headerMessage="${paramHeaderMessage}"
elif [ -z "${headerMessage}" ]
then
    headerMessage="${defaultHeaderMessage}"
fi

if [ -n "${paramFooterMessage}" ]
then
    footerMessage="${paramFooterMessage}"
elif [ -z "${footerMessage}" ]
then
    footerMessage="${defaultFooterMessage}"
fi

if [ -n "${paramLogLevel}" ]
then
    logLevel="${paramLogLevel}"
elif [ -z "${logLevel}" ]
then
    logLevel="${defaultLogLevel}"
fi

if [ -n "${paramLogFile}" ]
then
    logFile="${paramLogFile}"
elif [ -z "${logFile}" ]
then
    logFile="${workingDirectory}/${defaultLogFile}"
fi

# enabling strict mode
# -u - undefined variables are forbidden (enable this option after getting parameters from $1 $2...)
set -u

# checking parameters value
if [ ! -d "$(dirname "${logFile}")" ]
then
    log 1 "ERROR - $(dirname "${logFile}") does not exist"
    exit 4
fi

# script

# output current config
log 3 "- current config"
log 3 "    configFile: ${configFile}"
log 3 "    apacheWebRootPath: ${apacheWebRootPath}"
log 3 "    installWebPath: ${installWebPath}"
log 3 "    installDir: ${installDir}"
log 3 "    enableGallery: ${enableGallery}"
log 3 "    headerMessage: ${headerMessage}"
log 3 "    footerMessage: ${footerMessage}"
log 3 "    logLevel: ${logLevel}"
log 3 "    logFile: ${logFile}"

log 1 "- creating install directory ${installDir}"
mkdir -p "${installDir}"
if [ ! -d "${installDir}" ] || [ ! -w "${installDir}" ]; then
    log 1 "ERROR - install directory ${installDir} does not exist or is not writable by the current user"
    exit 5
fi

log 1 "- copying apaxy in install directory"
# we want globbing
# shellcheck disable=SC2086
cp -r ${workingDirectory}/apaxy/* "${installDir}/"

log 1 "- configuring apaxy in install directory"

log 2 "- generating htaccess"
sed "s|{FOLDERNAME}|${installWebPath}|g" < "${installDir}/htaccess.txt" > "${installDir}/.htaccess"
rm "${installDir}/htaccess.txt"

if [ "${enableGallery}" = "true" ]
then
    log 1 "- enabling gallery feature"
    mv -f "${installDir}/theme/header-lightgallery.html" "${installDir}/theme/header.html"
    mv -f "${installDir}/theme/footer-lightgallery.html" "${installDir}/theme/footer.html"
else
    log 2 "- gallery feature not enabled"
fi

# find all the html files and replace the variable in them
# this will automatically take care of the error pages, headers and footers
log 2 "- setting path in html files"
files=$(find ${installDir} -name "*.html")
while read -r file; do
    sed -i "s|{FOLDERNAME}|${installWebPath}|g" "${file}"
    sed -i "s|{HEADER-MESSAGE}|${headerMessage}|g" "${file}"
    sed -i "s|{FOOTER-MESSAGE}|${footerMessage}|g" "${file}"
done <<< "${files}"

log 2 "- syncing filesystem"
sync
log 1 "- filesystem has been synced and is now consistent"
log 1 "- apaxy has been successfully configured and installed in ${installDir}"
