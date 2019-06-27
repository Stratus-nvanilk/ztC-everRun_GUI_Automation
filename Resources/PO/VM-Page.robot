*** Settings ***
Library  SeleniumLibrary
Library  String

*** Variables ***
${VMPageNav} =  id:vmNav
${VMPageTitle} =  xpath://*[@class="vmTitle viewTitle"]
${StartVMButton} =  xpath://*[@id="ext-gen763"]
${ShutDownVMButton} =  xpath://*[@id="ext-gen771"]
${YesButton} =  xpath://*[@id="ext-comp-1714"]

*** Keywords ***
Go To VM Page
    Click Element  ${VMPageNav}
    Wait Until Page Contains Element  ${VMPageTitle}
    sleep  10s
    Element Text Should Be  ${VMPageTitle}  VIRTUAL MACHINES  ignore_case=True
    Page Should Contain Element  xpath://*[contains(text(),"Virtual Machines")]

Select a given VM
    [Arguments]  ${GIVEN_VM}
    Log  The given VM to be selected is ${GIVEN_VM}
    sleep  10s
    ${WE} =  Get WebElement  xpath://*[@class='vm-namecol' and contains(text(),${GIVEN_VM})]
    Wait Until Page Contains Element  ${WE}  3 min  30 sec
    Log  ${WE}
    Click Element  ${WE}
    Set Focus To Element  ${WE}
    Assign ID To Element  xpath://*[@class='vm-namecol' and contains(text(),${GIVEN_VM})]  TargetVM
    Wait Until Page Contains Element  TargetVM  3 min  30 sec
    ${exp}=	Get Element Attribute  TargetVM  attribute=xpath
    LOG  ${exp}
    Click Element  TargetVM
    Set Focus To Element  TargetVM
    ${VMText} =  Get Text  TargetVM
    LOG  ${VMText}
    Element Text Should Be  TargetVM  ${GIVEN_VM}  ignore_case=True

Start Selected VM
    Wait Until Keyword Succeeds  3 min  30 sec  Element Should Be Visible  ${StartVMButton}
    Element Should Be Enabled  ${StartVMButton}
    Click Button  ${StartVMButton}
    sleep  60s

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

Get Table Element
    [Arguments]  ${Unique_ID}
    Log  Searching the table for the given unique ID : ${Unique_ID}
    @{WebElmts} =  Get WebElements  xpath://table
    Set Test Variable  @{WebElmts}
    ${WebElmtsNum} =  Get Length  ${WebElmts}
    : FOR  ${a}  IN RANGE  ${WebElmtsNum}
    \    ${WebElmText} =  Get Text  @{WebElmts}[${a}]
    \    Log  ${WebElmText}
    \    ${stripped}=  Strip String  ${WebElmText}  mode=both
    \    Run Keyword If	'''${WebElmText}''' == ''  Continue For Loop
    \
    \    @{lines} =	 Split To Lines  ${WebElmText}
    \    Run Keyword If  '${Unique_ID}' in @{lines}  Set Test Variable  ${MyWebElmnt}  @{WebElmts}[${a}]
    \    ...    ELSE IF  '${Unique_ID}' not in @{lines}  Continue For Loop
    \
    \    Run Keyword If    ${a}>${WebElmtsNum}   Exit For Loop
    [Return]  ${MyWebElmnt}

#==========================Scrap Book=================================================================

    #\    ${matches} =  Should Match Regexp  (?im)${Unique_ID}  ${WebElmText}
    #//*[@id="ext-gen1251"]/table
    #//*[@id="vm"] => Table xpath
    #xpath://*[@id="ext-gen763"]
    #Get Table Row Values  css=html.ext-strict.x-viewport body#ext-gen3.ext-gecko.ext-gecko3.x-border-layout-ct div#ext-comp-1029.x-panel.x-panel-noborder.x-border-panel div#ext-gen15.x-panel-bwrap div#ext-gen16.x-panel-body.x-panel-body-noheader.x-panel-body-noborder div#vm.x-panel.x-panel-noborder div#ext-gen242.x-panel-bwrap div#ext-gen243.x-panel-body.whitepanel.x-panel-body-noheader.x-panel-body-noborder.x-border-layout-ct div#ext-comp-1377.x-panel.x-panel-noborder.x-grid-panel.x-border-panel div#ext-gen673.x-panel-bwrap div#ext-gen674.x-panel-body.x-panel-body-noheader.x-panel-body-noborder div#ext-gen675.x-grid3 div#ext-gen676.x-grid3-viewport div#ext-gen678.x-grid3-scroller  1
    #Assign ID To Element  xpath://*[@class='vm-namecol' and @value=${GIVEN_VM}]  TargetVM
    # working --> xpath://*[@class='vm-namecol' and contains(text(),${GIVEN_VM})]  TargetVM
    #Click Element  TargetVM
    #xpath://*[@id="ext-gen1271"]/table/tbody/tr/td[4]/div/div
    #xpath://*[@class='vm-namecol']  xpath://*[@id="ext-gen1271"]
    #="Windows_2k16_VM2"]
    #Click Element  xpath://*[@class='vm-namecol'  xpath://*[matches(@value,${GIVEN_VM},'i')]
    #Click Element  xpath://*[@class[contains(text(),${GIVEN_VM})]
    #//*[@id="ext-gen1234"]/table/tbody/tr/td[4]/div/div
    #//*[@id="ext-gen1233"]/table/tbody/tr/td[4]/div/div
    #//*[@id="ext-gen1280"]/table/tbody/tr/td[4]/div/div
    #//*[@id="ext-gen1291"]/table/tbody/tr/td[4]/div/div document.querySelector("#ext-gen771 > div > span")
    #ext-gen1267 > table > tbody > tr > td.x-grid3-col.x-grid3-cell.x-grid3-td-namecol > div > div //*[@id="ext-gen771"]/div/span
    #${row}= Find Table Row  css=#ext-comp-1378  ${GIVEN_VM}
    #ext-gen1263 > table > tbody > tr > td.x-grid3-col.x-grid3-cell.x-grid3-td-namecol > div > div
    #//*[@id="ext-gen1271"]/table/tbody/tr/td[4]/div/div
    #document.querySelector("#ext-gen1280 > table > tbody > tr > td.x-grid3-col.x-grid3-cell.x-grid3-td-namecol > div > div")
    #<div class="vm-namecol" title="This Virtual Machine cannot be renamed unless it is stopped.">Windows_2k16_VM2</div>
    #/html/body/div[2]/div/div/div[7]/div/div/div[1]/div/div/div/div[1]/div[2]/div/div[2]/table/tbody/tr/td[3]/div/div
    #html.ext-strict.x-viewport body#ext-gen3.ext-gecko.ext-gecko3.x-border-layout-ct div#ext-comp-1029.x-panel.x-panel-noborder.x-border-panel div#ext-gen15.x-panel-bwrap div#ext-gen16.x-panel-body.x-panel-body-noheader.x-panel-body-noborder div#vm.x-panel.x-panel-noborder div#ext-gen242.x-panel-bwrap div#ext-gen243.x-panel-body.whitepanel.x-panel-body-noheader.x-panel-body-noborder.x-border-layout-ct div#ext-comp-1377.x-panel.x-panel-noborder.x-grid-panel.x-border-panel div#ext-gen673.x-panel-bwrap div#ext-gen674.x-panel-body.x-panel-body-noheader.x-panel-body-noborder div#ext-gen675.x-grid3 div#ext-gen676.x-grid3-viewport div#ext-gen678.x-grid3-scroller div#ext-gen680.x-grid3-body div#ext-gen1211.x-grid3-row.x-grid3-row-last table.x-grid3-row-table tbody tr td.x-grid3-col.x-grid3-cell.x-grid3-td-namecol div.x-grid3-cell-inner.x-grid3-col-namecol div.vm-namecol
    ##ext-gen1215 > table:nth-child(1) > tbody:nth-child(1) > tr:nth-child(1) > td:nth-child(3) > div:nth-child(1) > div:nth-child(1)
    #//*[@id="ext-gen1364"]/table/tbody/tr/td[4]/div/div

    #id=vmNavStateIcon
    #and matches(@value,"Virtual Machines",'i')]
    #contains(text(),"Virtual Machines")]
    #@class='smux-l10n' and
    #Title Should be  VIRTUAL MACHINES
    #${TargetVM} =  xpath://*[@class='vm-namecol' and contains(text(),${GIVEN_VM})]
    #${Req_Cell} =  Get Table Cell  xpath=//table  2  3
    #${Val} =  Get Value  xpath=//table
    #Log  ${Val}
    #Log  ${Req_Cell}
    #ext-gen753 > span
    #Working ones:
    #Wait Until Page Contains  ${WE}
    #xpath://*[@class="x-btn-small x-btn-icon-small-left"]
    #${YesButton} =  xpath://*[@id="ext-gen1249" and contains(text(),"Yes")]
    #//*[@id="ext-comp-1714"]/tbody
    #ext-comp-1714 > tbody
    #ext-comp-1714 > tbody > tr:nth-child(2) > td.x-btn-mc
    #//*[@id="ext-comp-1714"]/tbody/tr[2]/td[2]
    #//*[@id="ext-comp-1714"]
    #xpath://*[@id="ext-gen1249"]
    #xpath://*[@id="ext-gen1249"]
    #Wait Until Page Contains Element  ${YesButton}
    #//*[@id="ext-comp-1388"]
    #So first I added control, if there is this table element and it tells me TRUE every time:
    #${present} =    Run Keyword And Return Status    Element Should Be Visible    xpath=//table[contains(@id,'table1')]/tbody
    #Run Keyword If    ${present}    log to console    \nTABLE CELL ELEMENT EXISTS - ${present}
    #//*[@id="ext-gen1253"]/table/tbody/tr/td[4]
    #//*[@id="ext-gen1281"]/table/tbody/tr/td[2]
#    :FOR    ${i}    IN RANGE    ${startvalue}    ${endvalue}    step=${step}
#
#\        Run Keyword If  condition1 or condition2  Call_Keyword  ${val1}  {val2}
#\        Run Keyword If  condition3  exit for loop
    #\    Should Contain  $ElmntText  $Unique_ID  ignore_case=True
    #Exit For Loop if    '$Unique_ID' in '''$ElmntText'''
    #@{WebElmtsList} =  Create List  @{WebElmts}
    #${MyWebElmnt} =  ${None}
    #Set Test Variable  ${MyWebElmnt}  ${a}
    #run keyword if  $Unique_ID in $ElmntText  LOG TO CONSOLE  Hello
    #Set Test Variable    ${WE}    @{WebElmts}[${a}]
    #${WebElmText} =  Get Text  ${WE}
    #${ElmntText} =  Get Text  @{WebElmts}[${a}]
    #Log  ${ElmntText}
    #LOG TO CONSOLE  ${MyWebElmnt}
    #Exit For Loop if    '$Unique_ID' in '''$WebElmText'''
    #${stripped}=  Strip String  ${WebElmText}  mode=both
    #@{lines} =	 Split To Lines  ${stripped}
#    @{cells}=  Get WebElements  xpath://table
#    : FOR    ${a}  IN RANGE  0  100
#    \    ${CellText} =  Get Text  @{cells}[${a}]
#    \    Log  ${CellText}
#
#    Assign ID To Element  xpath://*[@class='vm-namecol' and contains(text(),${GIVEN_VM})]  TargetVM
#    Scroll Element Into View  TargetVM
#    #Table Column Should Contain  xpath://table  2  stopped
#    ${CellVal} =  Get WebElement  xpath://table/tbody/tr[2]//td[3]
#    ${CellText} =  Get Text  ${CellVal}
#    LOG  ${CellVal}
#    LOG  ${CellText}
#    #Element Text Should Be  ${CellVal}  stopped  ignore_case=True
#    ${CellText}=  Get Value  ${CellVal}
#    LOG  ${CellText}
    #Table Cell Should Contain  xpath://table/tbody/tr[2]//td[2]  stopped
    #Table Cell Should Contain  xpath://table  2  3  stopped
    #${Req_Cell} =  create list  Get Table Cell  xpath://table  1  2
#    @{Req_Cell} =  Get Table Cell  xpath://*[@id="vm"]  2  3
#    LOG  @{Req_Cell}
#    @{cells}=  Get WebElements  xpath://table
#    : FOR    ${a}  IN  0  100
#  \    Log  @{cells}[${a}]
#    #LOG  @{cells}
    #Wait Until Page Contains  ${WE}
    #    ${Req_Cell} =  Get Table Cell  xpath://*[@class="x-grid3" and contains(text(),${GIVEN_VM})]  2  3
#    LOG  ${Req_Cell}
    #Press Keys  TargetVM  RETURN
    #Element Should Be Focused  TargetVM
