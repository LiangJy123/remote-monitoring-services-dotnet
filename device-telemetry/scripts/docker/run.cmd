:: Copyright (c) Microsoft. All rights reserved.

@ECHO off & setlocal enableextensions enabledelayedexpansion

:: Note: use lowercase names for the Docker images
SET DOCKER_IMAGE="azureiotpcs/telemetry-dotnet"

:: strlen("\scripts\docker\") => 16
SET APP_HOME=%~dp0
SET APP_HOME=%APP_HOME:~0,-16%
cd %APP_HOME%

:: Check dependencies
docker version > NUL 2>&1
IF %ERRORLEVEL% NEQ 0 GOTO MISSING_DOCKER

:: Check settings
call .\scripts\env-vars-check.cmd
IF %ERRORLEVEL% NEQ 0 GOTO FAIL

:: Start the application
echo Starting Telemetry service...
docker run -it -p 9004:9004 ^
	-e PCS_AUTH_WEBSERVICE_URL ^
    -e PCS_STORAGEADAPTER_WEBSERVICE_URL ^
    -e PCS_DIAGNOSTICS_WEBSERVICE_URL ^
    -e PCS_TELEMETRY_DOCUMENTDB_CONNSTRING ^
    -e PCS_AUTH_ISSUER ^
    -e PCS_AUTH_AUDIENCE ^
    -e PCS_AUTH_REQUIRED ^
    -e PCS_CORS_WHITELIST ^
    -e PCS_APPLICATION_SECRET ^
    -e PCS_AAD_TENANT ^
    -e PCS_AAD_APPID ^
    -e PCS_AAD_APPSECRET ^
    -e PCS_TELEMETRY_STORAGE_TYPE ^
    -e PCS_TSI_FQDN ^
    -e PCS_AZUREBLOB_CONNSTRING ^
    -e PCS_ACTION_EVENTHUB_CONNSTRING ^
    -e PCS_ACTION_EVENTHUB_NAME ^
    -e PCS_LOGICAPP_ENDPOINT_URL ^
    -e PCS_SOLUTION_WEBSITE_URL ^
    %DOCKER_IMAGE%:testing

:: - - - - - - - - - - - - - -
goto :END

:FAIL
    echo Command failed
    endlocal
    exit /B 1

:MISSING_DOCKER
    echo ERROR: 'docker' command not found.
    echo Install Docker and make sure the 'docker' command is in the PATH.
    echo Docker installation: https://www.docker.com/community-edition#/download
    exit /B 1

:END
endlocal
