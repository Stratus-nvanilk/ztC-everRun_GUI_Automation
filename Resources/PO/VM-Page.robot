*** Settings ***
Library  SeleniumLibrary
Library  String
Resource  ../CommonWeb.robot

*** Variables ***
${VMPageNav} =  id:vmNav
${VMPageTitle} =  xpath://*[@class="vmTitle viewTitle"]

${VMTableRows} =  //*[starts-with(@class, 'x-grid3-row-table')]
${MountButton} =  xpath://*[@class=" x-btn-text vm-mount-cmd-icon"]
${MountDialog} =  xpath://*[@class=' sn-window']
${MountRadioGroup} =  device
${MountRepository} =  xpath://*[@class=" x-form-text x-form-field x-form-invalid" and @name="repository"]
${DialogMountButton} =  xpath:/html/body/div[50]/div[2]/div[2]/div/div/div/div[1]/table/tbody/tr/td[1]/table/tbody/tr/td/table/tbody/tr[2]/td[2]/em/button/span
${UnmountButton} =  xpath://*[@class="smux-l10n " and contains(text(),"Unmount")]
#
${NFS-Share} =  10.200.129.221:/blr_test1
${MRepositoryTB} =  xpath://*[@id="ext-comp-1721"]
${MountUserName} =  xpath://*[@class=" x-form-text x-form-field" and @name="name"]
${MountUserPwd} =  xpath://*[@class=" x-form-text x-form-field" and @name="password"]
${UserName} =  administrator
${UserPwd} =  syseng
${WINDOWS-Share} =  \\\\10.200.129.221\\blr_test1
${StartVMButton} =  xpath://*[@id="ext-gen763"]
${ShutDownVMButton} =  xpath://*[@id="ext-gen771"]
${PowerOffVMButton} =  xpath://*[@class=" x-btn-text vm-poweroff-cmd-icon"]
${YesButton} =  xpath://*[@class="smux-l10n " and contains(text(),'Yes')]
#The above locator is working.
${Reqd_USB} =  xpath:/html/body/div[52]/div/div[1]
${SelectedUSBDDL} =  xpath://*[@class="smux-l10n " and contains(text(),"USB Partition List")]

${RemoveVMButton} =  xpath://*[@class=" x-btn-text vm-destroy-cmd-icon"]
${RemoveVMDialog} =  xpath://*[@class=' sn-window x-window-plain x-window-dlg']
${RemoveVMAllVols} =  xpath://*[@class="smux-l10n " and contains(text(),"all")]
${RemoveVMDeleteVM} =  xpath://*[@class="smux-l10n " and contains(text(),"Delete VM")]
${ClearMTBFButton} =  xpath://*[@class="smux-l10n " and contains(text(),"Clear MTBF")]
#${ResetDeviceButton} =  xpath://*[@class="smux-l10n " and contains(text(),"Reset Device")]
${ResetDeviceButton} =  xpath://*[@class=" x-btn-text test-icon"]
#Monitor Tab
${VMP-Monitor-Tab} =  xpath://*[@class="smux-l10n " and contains(text(),"Monitor")]
${VMP-MT-Guest_OS-Pane} =  xpath://*[@class="smux-l10n " and contains(text(),"Guest OS")]
${AllTickedCheckBoxes} =  //*[starts-with(@class, 'x-grid3-check-col-on')]
${VMP-MT-Applications-Pane} =  xpath://*[@class="smux-l10n " and contains(text(),"Applications")]
${VMP-MT-Empty-Pane} =  xpath://*[@class="smux-l10n " and contains(text(),"Linux VMs do not support monitoring.")]
${MonitorTabSaveButton} =  xpath://table[@class="x-btn wizard-button x-btn-noicon"]//button[@class=" x-btn-text"]//span[@data-l10nkey="btn_save" and contains(text(),'Save')]
#Load Balance Tab
${VMP-Load-Balance-Tab} =  xpath://*[@class="smux-l10n " and contains(text(),"Load Balance")]
${VMP-LoadBalance-FFTrigger} =  xpath://div[@id="vmPreferredNodeTabId"]//div[@class="x-form-element"]//div[@class="x-form-field-wrap x-form-field-trigger-wrap"]
${VMP-LoadBalance-ComboList} =  xpath://div[@class="x-layer x-combo-list "]//div[@class="x-combo-list-inner"]//div[@class="x-combo-list-item" and contains(text(),${LBOption})]




*** Keywords ***

Go To VM Page
    Click Element  ${VMPageNav}
    Wait Until Page Contains Element  ${VMPageTitle}
    Sleep  3s
    Element Text Should Be  ${VMPageTitle}  VIRTUAL MACHINES  ignore_case=True
    Page Should Contain Element  xpath://*[contains(text(),"Virtual Machines")]

Select a given VM
    [Arguments]  ${GIVEN_VM}
    Log  The given VM to be selected is ${GIVEN_VM}
    sleep  3s
    ${TargetVM} =  Get Table Element  ${GIVEN_VM}
    Click Element  ${TargetVM}
#    Scroll Element Into View  ${TargetVM}
#    Wait Until Element Is Visible  ${TargetVM}
#    Wait Until Keyword Succeeds  2 min  20 sec  Identify And Click Element  ${TargetVM}

Zero in on the given VM
    [Arguments]  ${GIVEN_VM}
    Log  The given VM to be selected is ${GIVEN_VM}
    sleep  3s
    Assign ID To Element  xpath://*[@class='vm-namecol' and contains(text(),${GIVEN_VM})]  TargetVM
    ${WE} =  Get Webelement  TargetVM
    Scroll Element Into View  ${WE}
    Wait Until Element Is Visible  ${WE}
    Press Keys  ${WE}  \\9
    Wait Until Keyword Succeeds  2 min  20 sec  Click Element  ${WE}  CTRL
#    Wait Until Keyword Succeeds  2 min  20 sec  Identify And Click Element  ${WE}


Start Selected VM
    Wait Until Keyword Succeeds  3 min  30 sec  Element Should Be Visible  ${StartVMButton}
    Element Should Be Enabled  ${StartVMButton}
    Click Element  ${StartVMButton}
    #Set Focus To Element  ${StartVMButton}
    sleep  180s

Shutdown Selected VM
    Wait Until Keyword Succeeds  3 min  30 sec  Element Should Be Visible  ${ShutDownVMButton}
    Element Should Be Enabled  ${ShutDownVMButton}
    Click Button  ${ShutDownVMButton}
    Wait Until Keyword Succeeds  3 min  30 sec  Element Should Be Visible  ${YesButton}
    Click Element  ${YesButton}
    sleep  60s

Verify VM Is Stopped
    [Arguments]  ${GIVEN_VM}
    ${Reqd_Element} =  Get Table Element  ${GIVEN_VM}
    ${WebElmText} =  Get Text  ${Reqd_Element}
    Log  ${WebElmText}
    Should Contain   ${WebElmText}  stopped

Verify VM Is Started
    [Arguments]  ${GIVEN_VM}
    ${Reqd_Element} =  Get Table Element  ${GIVEN_VM}
    ${WebElmText} =  Get Text  ${Reqd_Element}
    Log  ${WebElmText}
    Should Contain   ${WebElmText}  running

Power Off Selected VM
    Wait Until Keyword Succeeds  3 min  30 sec  Element Should Be Visible  ${PowerOffVMButton}
    Element Should Be Enabled  ${PowerOffVMButton}
    Click Button  ${PowerOffVMButton}
    Wait Until Keyword Succeeds  3 min  30 sec  Element Should Be Visible  ${YesButton}
    Get Text  ${YesButton}
    Click Element  ${YesButton}
    sleep  180s
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#ToDo  This is going beyond Unique ID in the list. Need to be conformant with Select Table Element Get Data
Get Table Element
    [Arguments]  ${Unique_ID}
    Log  Searching the table for the given unique ID : ${Unique_ID}
    Set Test Variable  ${MyWebElmnt}  Not Found
    @{lines} =  Create List
    Set Test Variable  ${WebElmText}  ${EMPTY}
    Set Test Variable  ${WebElmtsNum}  ${EMPTY}
    @{WebElmts} =  Get WebElements  ${VMTableRows}
    Log Many  @{WebElmts}
    ${WebElmtsNum} =  Get Length  ${WebElmts}

    : FOR  ${a}  IN RANGE  ${WebElmtsNum}
    \    Run Keyword If    ${a}>=${WebElmtsNum}   Exit For Loop
    \    @{WebElmts} =  Get WebElements  ${VMTableRows}
    \    ${WebElmText} =  Get Text  @{WebElmts}[${a}]
    \    Log  ${WebElmText}
    \    Run Keyword If    '''${WebElmText}''' == ''  Continue For Loop
    \    Log  @{WebElmts}[${a}]
    \    @{lines} =     Split To Lines  ${WebElmText}
    \    Run Keyword If  '${Unique_ID}' in @{lines}  Set Test Variable  ${MyWebElmnt}  @{WebElmts}[${a}]
    \    Run Keyword If  '${Unique_ID}' in @{lines}  Exit For Loop
    \    ...    ELSE IF  '${Unique_ID}' not in @{lines}  Continue For Loop

    [Return]  ${MyWebElmnt}

#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#Get Table Element
#    #Todo  If given unique id is not found then how this should behave?
#    [Arguments]  ${Unique_ID}
#    Log  Searching the table for the given unique ID : ${Unique_ID}
#    @{WebElmts} =  Get WebElements  xpath://table
#    Set Test Variable  ${MyWebElmnt}  Not Found
#    Set Test Variable  @{WebElmts}
#    ${WebElmtsNum} =  Get Length  ${WebElmts}
#    : FOR  ${a}  IN RANGE  ${WebElmtsNum}
#    \    ${WebElmText} =  Get Text  @{WebElmts}[${a}]
#    \    Log  ${WebElmText}
#    \    ${stripped}=  Strip String  ${WebElmText}  mode=both
#    \    Run Keyword If	'''${WebElmText}''' == ''  Continue For Loop
#    \
#    \    @{lines} =	 Split To Lines  ${WebElmText}
#    \    Run Keyword If  '${Unique_ID}' in @{lines}  Set Test Variable  ${MyWebElmnt}  @{WebElmts}[${a}]
#    \    ...    ELSE IF  '${Unique_ID}' not in @{lines}  Continue For Loop
#    \    Run Keyword If    ${a}>${WebElmtsNum}   Exit For Loop
#    [Return]  ${MyWebElmnt}

#*****************************************************************************************************************
Select Table Element Get Data
    [Arguments]  ${Unique_ID}
    Log  Searching the table for the given unique ID : ${Unique_ID}
    @{WebElmts} =  Create List
    @{ElementData} =  Create List
    @{lines} =  Create List
    Set Test Variable  ${WebElmText}  ${EMPTY}
    Set Test Variable  ${WebElmtsNum}  ${EMPTY}
    @{WebElmts} =  Get WebElements  ${VMTableRows}

    Log Many  @{WebElmts}
    ${WebElmtsNum} =  Get Length  ${WebElmts}

    : FOR  ${a}  IN RANGE  ${WebElmtsNum}
    \    Run Keyword If    ${a}>=${WebElmtsNum}  Exit For Loop
    \    @{lines} =  Create List
    \    @{WebElmts} =  Get WebElements  ${VMTableRows}
    \    ${WebElmText} =  Get Text  @{WebElmts}[${a}]
    \    Log  ${WebElmText}
    \    Run Keyword If	'''${WebElmText}''' == ''  Continue For Loop
    \    Log  @{WebElmts}[${a}]
    \    @{lines} =	 CommonWeb.Split Lines On String Return Stripped List  ${WebElmText}
    \    Run Keyword If  '''${Unique_ID}''' in ascii(@{lines})  Click Element  @{WebElmts}[${a}]
    \    Run Keyword If  '''${Unique_ID}''' in ascii(@{lines})  Set Test Variable  @{ElementData}  @{lines}
    \    Run Keyword If  '''${Unique_ID}''' in ascii(@{lines})  Exit For Loop
    \    Run Keyword Unless  '''${Unique_ID}''' not in ascii(@{lines}) and ${WebElmtsNum} - ${a} == 1  Set Test Variable  @{ElementData}  @{EMPTY}

    [Return]  @{ElementData}

#*****************************************************************************************************************
Open Mount Dialog
    Wait Until Keyword Succeeds  3 min  30 sec    Element Should Be Visible  ${MountButton}
    Element Should Be Enabled  ${MountButton}
    Click Button  ${MountButton}
    sleep  2s
    Wait Until Keyword Succeeds  3 min  30 sec  Element Should Be Visible  ${MountDialog}

Mount Device Via NFS
    Open Mount Dialog
    Select Radio Button  ${MountRadioGroup}  nfs
    sleep  5s
    Wait Until Keyword Succeeds  3 min  30 sec  Element Should Be Visible  ${MountRepository}
    Assign ID To Element  ${MountRepository}  tbRepository
    Press Keys  tbRepository  \\09
    Input Text  tbRepository  ${NFS-Share}
    Hit Mount And Verify

Hit Mount And Verify
    Click Element  ${DialogMountButton}
    Sleep  5s
    Wait Until Keyword Succeeds  3 min  30 sec  Element Should Be Visible  ${UnmountButton}

Mount Device Via Windows Share
    #Todo  Test this keyword thoroughly.
    Open Mount Dialog
    Select Radio Button  ${MountRadioGroup}  samba
    sleep  5s
    Wait Until Keyword Succeeds  3 min  30 sec  Element Should Be Visible  ${MRepositoryTB}
    Element Should Be Visible  ${MountUserName}
    Assign ID To Element  ${MountUserName}  tbUserName
    Input Text  tbUserName  ${UserName}
    Assign ID To Element  ${MountUserPwd}  tbUserPwd
    Input Text  tbUserPwd  ${UserPwd}
    Assign ID To Element  ${MRepositoryTB}  tbRepository
    Input Text  tbRepository  ${WINDOWS-Share}
    Hit Mount And Verify

Unmount Device And Verify
    Wait Until Keyword Succeeds  3 min  30 sec  Element Should Be Visible  ${UnmountButton}
    Click Element  ${UnmountButton}
    Sleep  5s
    Wait Until Keyword Succeeds  3 min  30 sec  Element Should Be Visible  ${YesButton}
    Click Element  ${YesButton}
    Sleep  5s
    Wait Until Keyword Succeeds  3 min  30 sec  Element Should Be Visible  ${MountButton}

Mount Device Via USB
    [Arguments]  ${DDL_Option}
    Open Mount Dialog
    Select Radio Button  ${MountRadioGroup}  usb
    sleep  5s
    Assign ID To Element  ${SelectedUSBDDL}  USBPL
    ${WE} =  Get WebElement  USBPL
    ${WEText} =  Get Text  USBPL
    LOG  ${WEText}
    Click Element  ${WE}
    Wait Until Keyword Succeeds  3 min  30 sec  Element Should Be Visible  ${Reqd_USB}
    Click Element  ${Reqd_USB}
    Hit Mount And Verify

Open Remove VM Dialog
    Wait Until Keyword Succeeds  3 min  30 sec  Element Should Be Visible  ${RemoveVMButton}
    Element Should Be Enabled  ${RemoveVMButton}
    Click Element  ${RemoveVMButton}
    sleep  2s
    Wait Until Keyword Succeeds  3 min  30 sec  Element Should Be Visible  ${RemoveVMDialog}

Remove Selected VM
    Open Remove VM Dialog
    Click Element  ${RemoveVMAllVols}
    Click Element  ${RemoveVMDeleteVM}
    Wait Until Keyword Succeeds  3 min  30 sec  Element Should Be Visible  ${YesButton}
    Click Element  ${YesButton}
    Sleep  180s

Verify VM Is Removed
    [Arguments]  ${GIVEN_VM}
    Go To VM Page
    ${Reqd_Element} =  Get Table Element  ${GIVEN_VM}
    Should Be Equal  ${Reqd_Element}  Not Found  ignore_case=True

Clear MTBF For VM
    Log  Clearing MTBF for the selected VM
    Click Element  ${ClearMTBFButton}
    Wait Until Keyword Succeeds  3 min  30 sec  Element Should Be Visible  ${YesButton}
    Click Element  ${YesButton}
    Sleep  10s

#Select VM Verify State Is Running
#    [Arguments]  ${GIVEN_VM}
#    Log  The given VM to be selected is ${GIVEN_VM}
#    Go To VM Page
#    Sleep  10s
#    CommonWeb.Reload Application Page
#    Verify VM Is Started  ${GIVEN_VM}
#    CommonWeb.Go Back To Previous Page
#    Go To VM Page
#    Select a given VM  ${GIVEN_VM}
#    #Zero in on the given VM  ${GIVEN_VM}

Select VM Verify State Is Running
    [Arguments]  ${GIVEN_VM}
    Log  The given VM to be selected is ${GIVEN_VM}
    Go To VM Page
    Sleep  5s
    @{VMData} =  Select Table Element Get Data  ${GIVEN_VM}
    Log Many  @{VMData}
    Should Contain  ${VMData}  running

Select VM Verify Button Is Disabled
    [Arguments]  ${GIVEN_VM}  ${VMButton}
    Go To VM Page
    Select a given VM  ${GIVEN_VM}
    #Zero in on the given VM  ${GIVEN_VM}
    Sleep  5s
    ${Status} =  Run Keyword And Return Status  Element Should Be Disabled  ${VMButton}

Select VM Verify Button Is Enabled
    [Arguments]  ${GIVEN_VM}  ${VMButton}
    Go To VM Page
    Select a given VM  ${GIVEN_VM}
    #Zero in on the given VM  ${GIVEN_VM}
    Sleep  5s
    Element Should Be Enabled  ${VMButton}

Hit Reset Device and Confirm
    Log  Hitting Reset Device button to reset the selected VM
    Click Element  ${ResetDeviceButton}
    Wait Until Keyword Succeeds  3 min  30 sec  Element Should Be Visible  ${YesButton}
    Click Element  ${YesButton}
    Sleep  10s
#---------------------------------------------------------------------------------------
#VM-Page Monitoring Tab
#---------------------------------------------------------------------------------------

Open Monitor Tab Expand and Verify Panes
    [Arguments]  ${VM_OS}
    Log  Opening Monitor tab for the selected VM and verifying the panes.
    Click Element  ${VMP-Monitor-Tab}
    Run Keyword And Return If  '${VM_OS}' == 'Linux'  Page Should Contain Element  ${VMP-MT-Empty-Pane}
    #
    @{CollapsedPanes} =  Create List
    @{CollapsedPanes} =  Get WebElements  xpath://*[@class="x-panel x-panel-collapsed"]
    Run Keyword And Return If  @{CollapsedPanes} == @{EMPTY}  Log Many  Looks like there are no collapsed panes :  @{CollapsedPanes}
    Run Keyword if @{CollapsedPanes}[0]  Click Element  @{CollapsedPanes}[0]
    Run Keyword if @{CollapsedPanes}[1]  Click Element  @{CollapsedPanes}[1]
    #
    @{ExpandedPanes} =  Create List
    @{ExpandedPanes} =  Get WebElements  xpath://*[@class="x-panel"]
    Log Many  @{ExpandedPanes}
    Run Keyword And Return If  @{ExpandedPanes} == @{EMPTY}  Log Many  Looks like there are no expanded panes :  @{ExpandedPanes}

Select Row With Given Parameter On Monitor Tab Guest OS Table
    [Arguments]  ${GivenParameter}
    Log  Select a row in the Guest OS table with parameter column value matching the given Guest OS Parameter.
    Log  Assumes the Guest OS pane of the Monitor tab on the VM Page is open.
    Set Test Variable  ${GuestOSParameterCell}  xpath://div[contains(@class,"monitor-config-grid")]//td[@class="x-grid3-col x-grid3-cell x-grid3-td-1 "]//div[contains(text(),"${GivenParameter}")]
    Click Element  ${GuestOSParameterCell}

Select A Checkbox On The Selected Row On Monitor Tab Guest OS Table
    [Arguments]  ${CheckboxColumn}
    Log  Select a checkbox on the selected row on the Guest OS table.
    [Documentation]  Acceptable values for ${CheckboxColumn} are 0,5,6. 0-->enabled, 5-->CallHome and 6-->EAlert/Trap. Select checkbox 0 first (to enable)
    ...  to be able to select checkboxes 5 and 6. Assumes the Guest OS pane of the Monitor tab on the VM Page is open and the desirable row is selected.
    ...  This keyword is a toggle keyword, meaning it can be used again to deselect a selected checkbox.
    Set Test Variable  ${CheckboxOnSelectedRow}  xpath://div[contains(@class,"monitor-config-grid")]//div[contains(@class,"row-selected")]//td[contains(@class,"x-grid3-td-${CheckboxColumn}")]
    Click Element  ${CheckboxOnSelectedRow}

Input A Textbox On The Selected Row On Monitor Tab Guest OS Table
    [Arguments]  ${TextboxColumn}  ${InputValue}
    Log  Select a textbox on the selected row on the Guest OS table and input the given value into it.
    [Documentation]  Acceptable values for ${InputValue} are only numbers from 0 to 9.
    ...  Assumes the Guest OS pane of the Monitor tab on the VM Page is open and the desirable row is selected.
    Set Test Variable  ${TextboxOnSelectedRow}  xpath://div[contains(@class,"monitor-config-grid")]//div[contains(@class,"row-selected")]//td[contains(@class,"x-grid3-td-${TextboxColumn}")]//div[starts-with(@class,"x-grid3-cell-inner")]
    Identify And Click Element  ${TextboxOnSelectedRow}
    Wait Until Element Is Enabled  ${TextboxOnSelectedRow}
    Press Keys  ${TextboxOnSelectedRow}  ${InputValue}
    #Input Text  ${TextboxOnSelectedRow}  ${InputValue}

Get Status Column Value On The Selected Row On Monitor Tab Guest OS Table
    [Arguments]  ${GivenParameter}  ${GivenCellColumn}
    Log  Returns the class attribute value held in the given column cell (${GivenCellColumn}) on the selected row in the Guest OS table On Monitor Tab.
    [Documentation]  Assumes the Guest OS pane of the Monitor tab on the VM Page is open. Selects the row with parameter column value matching ${GivenParameter}.
    Select Row With Given Parameter On Monitor Tab Guest OS Table  ${GivenParameter}
    Set Test Variable  ${GivenCellColumnElement}  xpath://div[contains(@class,"monitor-config-grid")]//div[contains(@class,"row-selected")]//td[contains(@class,"x-grid3-td-${GivenCellColumn}")]//div[starts-with(@class,"x-grid3-cell-inner")]//div[starts-with(@class,"state-icon")]
    ${StatusEAClass} =  Get Element Attribute  ${GivenCellColumnElement}  class
    [Return]  ${StatusEAClass}


Get Present Column Value On The Selected Row On Monitor Tab Guest OS Table
    [Arguments]  ${GivenParameter}  ${GivenCellColumn}
    Log  Returns the current (present) column value held in the given column cell (${GivenCellColumn}) on the selected row in the Guest OS table On Monitor Tab.
    [Documentation]  Assumes the Guest OS pane of the Monitor tab on the VM Page is open. Selects the row with parameter column value matching ${GivenParameter}.
    Select Row With Given Parameter On Monitor Tab Guest OS Table  ${GivenParameter}
    Set Test Variable  ${GivenCellColumnElement}  xpath://div[contains(@class,"monitor-config-grid")]//div[contains(@class,"row-selected")]//td[contains(@class,"x-grid3-td-${GivenCellColumn}")]//div[starts-with(@class,"x-grid3-cell-inner")]
    ${CellValue} =  Get Text  ${GivenCellColumnElement}
    [Return]  ${CellValue}

Open Load Balance Tab
    Log  Opening Load Balance tab for the selected VM and verifying the panes.
    Click Element  ${VMP-Load-Balance-Tab}
    ${GT} =  Get Text  xpath://div[@class="x-form-field-wrap x-form-field-trigger-wrap"]//input[@name="preferrednodevalue"]
    ${GV} =  Get Value  xpath://div[@class="x-form-field-wrap x-form-field-trigger-wrap"]//input[@name="preferrednodevalue"]
    Log  ${GT}
    Log  ${GV}

    Click Element  ${VMP-LoadBalance-FFTrigger}
    Set Test Variable  ${LBOption}  manually place on node0
    Set Test Variable  ${VMP-LoadBalance-ComboList}  xpath://div[@class="x-layer x-combo-list "]//div[@class="x-combo-list-inner"]//div[@class="x-combo-list-item" and contains(text(),"${LBOption}")]
    Click Element  ${VMP-LoadBalance-ComboList}
    Set Test Variable  ${LoadBalanceTabSaveButton}  xpath://table[@class="x-btn wizard-button x-btn-noicon"]//button[@class=" x-btn-text"]//span[@data-l10nkey="btn_save" and contains(text(),'Save')]
    Click Element  ${LoadBalanceTabSaveButton}
