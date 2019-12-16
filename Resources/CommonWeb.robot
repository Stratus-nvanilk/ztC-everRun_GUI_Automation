*** Settings ***
Library  SeleniumLibrary
Library  String

*** Variables ***


*** Keywords ***

Begin Web Test
    Log To Console  Starting
    Open Browser  ${URL}  ${BROWSER}
    Maximize Browser Window
    Set Log Level  Debug
#    ${SeleniumSpeedOriginal} =  Set Selenium Speed  0.5 seconds

End Web Test
    LOG  ${TEST_STATUS}
    Run Keyword If Test Passed  set test variable  ${Status}  p
    Run Keyword If Test Failed  set test variable  ${Status}  f
    #update test result on testlink  ${TEST_NAME}  ${Status}
    Run Keyword If Test Passed  Download Output File
#    Set Selenium Speed  ${SeleniumSpeedOriginal}
    Log To Console  Closing Browser
    Close All Browsers

Identify And Click Element
    [Arguments]  ${locator}
    Wait Until Element Is Enabled  ${locator}
    Scroll Element Into View  ${locator}
    Set Focus To Element  ${locator}
    Click Element  ${locator}

Reload Application Page
    Log  Reloading the application browser page
    Reload Page
    Sleep  10s

Download Output File
    Log  Downloading the output file from the remote server's source directory
    RemoteExec.Get File From The Remote Server  ${Remote_OutputFile}  ${Local_Destination_Dir}

Go Back To Previous Page
    Log  Go back to immediately previous page - equal to hitting back button on the browser.
    Go Back
    Sleep  5s

Split Lines On String Return Stripped List
    [Arguments]  ${GivenString}
    Log  Accepts a string, splits it into a list of constituent lines, strips every line and returns the stripped list.
    @{Split_lines} =  String.Split To Lines	 ${GivenString}
    @{Stripped_lines} =  Evaluate  list(map(str.strip, @{Split_lines}))
    [Return]  @{Stripped_lines}

Purge Blank Elements From List
    [Arguments]  @{GivenList}
    @{Purged_lines} =  Evaluate  list(filter(None, @{GivenList}))
    [Return]  @{Purged_lines}

Get Me All Matching WebElements
    [Arguments]  ${GivenCriterion}
    Log  Accepts a criterion for element selection and returns all the webelements matching the given criterion.

JS Click Element
    [Documentation]
    ...     Can be used to click hidden elements
    ...     Dependencies
    ...         SeleniumLibrary
    ...         String
    [Arguments]     ${element_xpath}
    # escape " characters of xpath
    ${element_xpath}=       Replace String      ${element_xpath}        \"  \\\"
    Execute JavaScript  document.evaluate("${element_xpath}", document, null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null).snapshotItem(0).click();