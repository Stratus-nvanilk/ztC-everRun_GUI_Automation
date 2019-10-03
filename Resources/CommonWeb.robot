*** Settings ***
Library  SeleniumLibrary

*** Variables ***


*** Keywords ***

Begin Web Test
    Log To Console  Starting
    Open Browser  ${URL}  ${BROWSER}
    Maximize Browser Window
    Set Log Level  Debug

End Web Test
    LOG  ${TEST_STATUS}
    Run Keyword If Test Passed  set test variable  ${Status}  p
    Run Keyword If Test Failed  set test variable  ${Status}  f
    update test result on testlink  ${TEST_NAME}  ${Status}
    Log To Console  Closing Browser
    Close All Browsers



