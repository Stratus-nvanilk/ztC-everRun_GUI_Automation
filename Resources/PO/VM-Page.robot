*** Settings ***
Library  SeleniumLibrary
Library  RemoteSwingLibrary

*** Variables ***
${VMPageNav} =  id=vmNav
${StartVMButton} =  xpath://*[@id="ext-gen763"]
${VMPageTitle} =  xpath://*[@class='vmTitle viewTitle']


*** Keywords ***
Go To VM Page
    Click Element  ${VMPageNav}

    Wait Until Page Contains Element  ${VMPageTitle}
    Element Text Should Be  ${VMPageTitle}  Virtual Machines  ignore_case=True
    Page Should Contain Element  xpath://*[contains(text(),"Virtual Machines")]

Select a given VM
    [Arguments]  ${GIVEN_VM}
    Log  The given VM to be selected is ${GIVEN_VM}
    Assign ID To Element  xpath://*[@class='vm-namecol' and contains(text(),${GIVEN_VM})]  TargetVM
    Wait Until Page Contains Element  TargetVM  3 min  30 sec
    Click Element  TargetVM
    Set Focus To Element  TargetVM
    Press Keys  TargetVM  RETURN
    #Element Should Be Focused  TargetVM
    ${VMText} =  Get Text  TargetVM
    LOG  ${VMText}
    Element Text Should Be  TargetVM  ${GIVEN_VM}  ignore_case=True

Start Selected VM
    Wait Until Keyword Succeeds  3 min  30 sec  Element Should Be Visible  ${StartVMButton}
    Element Should Be Enabled  ${StartVMButton}
    Click Button  ${StartVMButton}
    sleep  60s

    #===========================================================================================


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