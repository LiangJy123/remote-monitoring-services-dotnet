Starting Microservices on local environment
=====
### Steps to create Azure resources
#### New Users
1) Run the [start.(cmd|sh)](https://github.com/Azure/remote-monitoring-services-dotnet/blob/master/scripts/local/launch/) script located under launch *(scripts/local/launch)* folder.
2) Run the following script to set environment variables. The scripts are located under *(scripts/local/launch/os)* folder.
    i. [set-env-uri.(cmd|sh)](https://github.com/Azure/remote-monitoring-services-dotnet/tree/master/scripts/local/launch/os)
    ii. The created environment variables are present in [.env](https://github.com/Azure/remote-monitoring-services-dotnet/blob/master/scripts/local/launch/) file located in *(scripts/local/launch)* folder.
![start](https://user-images.githubusercontent.com/39531904/44435771-6ab08280-a566-11e8-93c9-e6f35e5df247.PNG)

**Please Note:**
*This script requires **Node.js** to execute, please install Node (version < 8.11.2) before using this script. Also, this script might require administartive privileges or sudo permission as it tries to install [pcs-cli](https://github.com/Azure/pcs-cli) a cli interface for remote-monitoring deployments.*
&nbsp; 

#### Existing Users
For users who have already created the required azure resources, please **set the environment variables** 
1) Globally on your machine, so as to be accessible by the IDE OR 
2) In the launch configurations of the IDE i.e. launch.json for VS code or Debug Settings under Properties for solution in Visual Studio.

*Although not recommended, environment variables can also be set in appsettings.ini file present under WebService folder for each of the microservices.*

### Walk through for importing new Solution into the IDE
##### VS Code 
The preconfigured launch & task configuration(s) for VS code are included in the *scripts / local / launch / idesettings* folder. These settings are useful for building individual OR all microservices. 

##### Steps to import launch settings
1) Click the debug icon on the left-hand panel of the IDE. (This will create .vs folder under root folder in the repo) 
![vs](https://user-images.githubusercontent.com/39531904/44294751-611ad800-a251-11e8-8a14-7fc7bc3c6aed.PNG)
<<<<<<< HEAD
3) Replace the auto-created launch.json & task.json with files under vscode folder which is present under idesettings. 
4) This will list all the debug/build configuration. 
=======
2) Replace the auto-created launch.json & task.json files under .vs folder with files under vscode folder present under idesettings. 
3) This will list all the debug/build configuration. 
>>>>>>> Changed documentation for readability

##### Visual Studio
1) If you have set the environment variables using the scripts, then you could use the Visual Studio to debug by starting multiple startup projects. Please follow the instructions [here](https://msdn.microsoft.com/en-us/library/ms165413.aspx) to set multiple startup projects.
2) If you haven't set the environment variables, then they could be set in following files.
    1. appsettings.ini under WebService
    2. launchSettings.json under Properties folder under WebService.
3) For multiple startup project settings, please set only WebService projects as startup projects.   

### Script Descriptions
#### Start Script
The new repository contains a **start** script and few other scripts to bootstrap the new users with the required cloud resources. These scripts are used to create azure resources like Cosmos DB, IoTHub, Azure Stream Analytics etc. The start script is located in *scripts / local / launch* folder under root directory of the repository.

This script checks if required environment variables are set on the local system. If the variables are set then one can open the IDE to start the microservices. If the variables are not set then this script will guide through the process of creating the new variables. It will then create different scripts under *scripts / local / launch / os / OS_TYPE /* which can be used to set environment variables on the machine.


#### Helpers scripts
These scripts are located under helpers folder which is under the launch folder. The script create-azure-resources.sh can be independently called to create resources in the cloud. The script check_dependencies.sh checks if environment variables are set for a particular microservices.
##### Usage:
1) check environment variables for a microservice 
sh check-dependencies.sh <microservice_folder_name> 
2) create Azure resources 
sh create-azure-resources.sh

After creating the required azure resources, using start or create-azure-resources.sh, one should execute the scripts under *os/{linux / win / osx}* to set the environment variables. 

Structure of the microservices
===
Each microservice comprises of following projects/folders. 
1) scripts 
2) WebService  
3) Service  
4) WebService.Test  
5) Service.Test

Description: 
1) Scripts  
The scripts folder is organized as follows\
i. **docker** sub folder for building docker containers of the current microservice.\
ii. **root** folder contains scripts for building and running services natively.\
&nbsp; 
![script folder structure](https://user-images.githubusercontent.com/39531904/44290937-10df4e00-a230-11e8-9cd4-a9c0644e166b.PNG "Caption")\
The docker build scripts require environment variables to be set up before execution. The run scripts can run both natively built and dockerized microservice. The run script under docker folder can also be independently used to pull and run published docker images. One can modify the tag and the account to pull different version or privately built docker images.
&nbsp; 

2) WebService  
It contains code for REST endpoints of the microservice.
&nbsp;  

3) Service  
It contains business logic and code interfacing various SDKs. 
&nbsp;

4) WebService.Test  
It contains unit tests for the REST endpoints of the microservice. 
&nbsp; 

5) Service  
It contains unit tests for the business logic and code interfacing various SDKs.
&nbsp;  

6) Other Projects  
The microservice might contain other projects such as RecurringTaskAgent etc.