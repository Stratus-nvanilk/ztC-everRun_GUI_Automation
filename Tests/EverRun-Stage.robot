*** Settings ***
#Library  SeleniumLibrary
Resource  ../Resources/EverRunApp.robot
Resource  ../Resources/CommonWeb.robot
Resource  ../Resources/PO/VM-Page.robot
Resource  ../Resources/PO/PM-Page.robot

Test Setup  Begin Web Test
Test Teardown  End Web Test
#====================================================================================================
#Robot Framework User Guide:
# https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html

# Automatic Variables :
# A number of automatic variables are available that you can make use of:
# https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html#automatic-variables

#  How to execute RFW test cases?
#robot -d results tests/EverRun-Stage.robot
#robot -d results -i DevTest1 tests/EverRun-Stage.robot
#robot --reporttitle "Babybird Test Report"  --logtitle  "Babybird Test Log"
#robot --critical 100iS -c 100iD   #--critical=-c
#robot --noncritical 110iS -n 100iS
#robot --timestampouts  110iD -t 100iS
#robot -d results --randomize tests [suites,all,none]  tests/EverRun-Stage.robot
#robot -d results --loglevel [ or -L ] debug tests/EverRun-Stage.robot  OR  Set Log Level  Debug (in the script)
#====================================================================================================

*** Variables ***
${BROWSER} =  gc
${URL} =  http://10.200.129.205
${USER} =  admin
${PWD} =  admin
${GLOBAL1}  I am a global variable
${VMNAME} =  MyCentos74
${USB} =  hp v215b - Partition1(14.9 GB)
${PMNAME} =  node0
${PrimaryPM} =  None

*** Test Cases ***
# Test Case Naming Conventions:
# Forcing script execution order:
# Script files normally execute in alphabetic order. You can change it by prefixing xx__ to their names.
# 01__Feature6.robot, 02__Feature3.robot,  03__Feature11.robot
# Same rule holds good for directory names.
# Use Refactor==> Rename feature for renaming files and directories.

Declare and set variables
    ${Test_Purpose} =  Set Variable  To show different types of variables.
    Set Test Variable  ${Some_data}  This is available only within this test.
    Comment  The above two variables are available only within this test.

    #Available in all tests in the current test suite.
    Set Suite Variable  ${Some_suite_data}  This is available within all tests in this suite.

    #Available in all tests in all suites
    Set Global Variable  ${Some_global_data}  This is available everywhere

Logging stuff
    [Tags]  Built-in
    Log  You are going to miss 100% of all shots you didn't try!
    Log  Never Never Never Giveup.
    Log many  Vedi  Veni  Veci
    Log to console  This can be only seen in the console, not the log!
    Log variables  This should log all the variables in the scope.
    #Suite *** variables ***
    Log  ${Some_suite_data}
    #Global *** variables ***
    Log  ${Some_global_data}
    Log  ${GLOBAL1}

#Should be able to access "Login" Page
#    [Documentation]  Testing access to "Login" Page
#    [Tags]  Login Tests
#    EverRunApp.Go To Landing Page

Should be able to login to App
    [Documentation]  Testing ability to "Login" to EverRun App
    #[Tags]  Login Tests
    [Tags]  DevTest
    Verify Login Process

Should be able to select a VM
    [Documentation]  Testing ability to "Select a VM" on the EverRun App
    [Tags]  DevTest
    Go To VM Page
    Select a given VM  ${VMNAME}

Should be able to start a VM
    [Documentation]  Verify ability to start a selected VM on EverRun App
    [Tags]  DevTest1
    Start A VM

Should be able to shutdown a VM
    [Documentation]  Verify ability to shutdown a selected VM on EverRun App
    [Tags]  DevTest2
    Shutdown A VM

Should be able to power off a VM
    [Documentation]  Verify ability to power off a selected VM on EverRun App
    [Tags]  DevTest3
    Power Off A VM

Should be able to mount device
    [Documentation]  Verify ability to mount a device on EverRun App
    [Tags]  DevTest4
    Mount A Device

Should be able to remove a VM
    [Documentation]  Verify ability to remove a VM on EverRun App
    [Tags]  DevTest5
    Remove A VM
#====================================PM Page test cases=======================================================================
Should be able to Work On a PM
    [Documentation]  Verify ability to work on a PM on EverRun App (bring it down for maintenance)
    [Tags]  DevTest6
    Work On Selected PM

Should be able to Finalize a PM
    [Documentation]  Verify ability to Finalize a PM running in maintenance on EverRun App and bring it back to normal status.
    [Tags]  DevTest7
    Finalize A PM

Should be able to Shutdown a PM
    [Documentation]  Verify ability to Shutdown a PM running in maintenance on EverRun App.
    [Tags]  DevTest8
    Shutdown A PM

Should be able to Reboot a PM
    [Documentation]  Verify ability to Reboot a PM running in maintenance on EverRun App.
    [Tags]  DevTest9
    Reboot A PM



