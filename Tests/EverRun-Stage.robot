*** Settings ***
#Library  SeleniumLibrary
Resource  ../Resources/EverRunApp.robot
Resource  ../Resources/CommonWeb.robot
Resource  ../Resources/PO/VM-Page.robot

Test Setup  Begin Web Test
Test Teardown  End Web Test

#robot -d results tests/EverRun-Stage.robot
#robot -d results -i DevTest1 tests/EverRun-Stage.robot

*** Variables ***
${BROWSER} =  gc
${URL} =  http://10.200.129.241
${USER} =  admin
${PWD} =  admin_Test
${GLOBAL1}  I am a global variable
${VMNAME} =  Win2k16
*** Test Cases ***

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
    [Documentation]  Testing ability to "Select a VM" in the EverRun App
    [Tags]  DevTest
    Go To VM Page
    Select a given VM  ${VMNAME}

Should be able to start a VM
    [Documentation]  Verify ability to "Select a VM" and start it in the EverRun App
    [Tags]  DevTest1
    Start A VM
