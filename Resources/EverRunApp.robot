Documentation  Talk about what this suite of test cases does.

*** Settings ***
Library  SeleniumLibrary
Resource  ./CommonWeb.robot
Resource  ./PO/LoginPage.robot
Resource  ./PO/StratusBanner.robot
Resource  ./PO/PM-Page.robot
Resource  ./PO/VM-Page.robot



*** Variables ***


*** Keywords ***

Go To Landing Page
    LoginPage.Navigate To
    LoginPage.Verify Page Loaded

Verify Login Process
    LoginPage.Log in to EverRun  ${USER}  ${PWD}

Go To "Team" Page
    TopNav.Select "Team" Page
    Team.Verify Page Loaded

Validate "Team" Page
    Team.Validate Page Contents

Start A VM
    LoginPage.Log in to EverRun  ${USER}  ${PWD}
    VM-Page.Go To VM Page
    VM-Page.Select a given VM  ${VMNAME}
    VM-Page.Start Selected VM
    Verify VM Is Started  ${VMNAME}

Shutdown A VM
    LoginPage.Log in to EverRun  ${USER}  ${PWD}
    VM-Page.Go To VM Page
    VM-Page.Select a given VM  ${VMNAME}
    VM-Page.Shutdown Selected VM
    VM-Page.Verify VM Is Stopped  ${VMNAME}
