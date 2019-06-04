*** Settings ***
Library  SeleniumLibrary


*** Variables ***


*** Keywords ***

Begin Web Test
    Log To Console  Starting
    open browser  ${URL}  ${BROWSER}
    Maximize Browser Window
    #Application Started  ztC  remote_host=10.200.129.243  name_contains=ztC

End Web Test
    Log To Console  Closing Browser
    close all browsers
