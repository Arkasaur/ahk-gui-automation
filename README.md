# AutoHotKey Scripting - GUI Workflows Automation

A project to automate some GUI workflows, that are commonly performed manually by Software engineers on a daily basis. The goal is to reduce time spent by an engineer in performing regular workflow tasks.

The workflows we will automate in this project are as follows:

### Scenario ###

A feature is developed by some developers, and a pull request to **main branch** is raised. Your task as a code reviewer is:

- Pull this merge request into your local machine (using your favourite editor - **Eclipse**)
- Perform a static code quality analysis (using **SonarQube** for our purpose)
- Check the SonarQube code quality ouput (on a locally hosted **SonarQube Server**)
- Based on the output (and a pre-decided metric), choose to either approve the pull request or deny it. (this action will be perfomed on **Innersource**)

## Prerequisites ##

> Eclipse IDE should be installed. https://www.eclipse.org/downloads/

> SonarQube server must be configured (we will run it on localhost:9000). https://www.sonarsource.com/products/sonarqube/downloads/

> AHK should be installed on your machine. https://www.autohotkey.com/download/

## Explanation of the different modules used in this project

#### main.ahk

The main module, that controls and runs all other modules in logical order

#### launchws2.ahk

- Launches eclipse
- Inputs the address of the local workspace that we want to open in Eclipse IDE
- Opens GIT view in Eclipse, and performs a **Git Pull** function
- When login credentials are requested, inputs Username and Password
> NOTE: The username is hard-coded into the script, but for security reasons, the password is not hard-coded directly in the script.

> Rather, we securely store the password in the Windows Registry and call the password from there using the Password Key

> An alternative approach for password input is to save the password in a password-protected *.docx* file, and retrieve the password from this file as part of the workflow
-  Confirm that the Git Pull action is completed (Wait until the **Pull Result** window appears)
- Close Eclipse

#### Sonarqube.bat

- Checks whether the SonarQube server (http://localhost:9000) is already up and running. If not, this batch file will trigger the server launch and wait until server is live.
- Runs the *sonar scan* command
> Check the waiting logic implemented inside the batch file

#### sonarsuccess.ahk

- Navigate to the sonar server page, and check if sonar scan/analysis is finished
> Reload the page after every 3 seconds until the scan is finished and results are displayed
- If the scan fails, pop an error message and **STOP HERE**
- Else, move to next module
> NOTE how clipboard functionality is used for this confirmation, since HTML DOM is not interactable by AHK

#### sonarqubing.ahk

- Open the sonar server's **scan results** page
> For our use case, we only check for **BUG** error types, and severities as **BLOCKER** and **CRITICAL**
- Check if any code failure detected. If yes, pop an error message and **STOP HERE**
- Else, code has no logical failures, and may be ready for merging to **master** branch

#### innersource.ahk

- Open your remote repository's pull requests page on browser (we use **Innersource** here)
- Use *pixel color checking* to confirm that the page has loaded
- Create the Pull request, add any description you may want (we leave all fields blank in this case)
- Merge the Pull Request
- Close the browser window

#### readpwd.ahk

An alternative solution for password storage and input without direct hard-coding.
Reads the password from a password-protected file, *pwd.docx*