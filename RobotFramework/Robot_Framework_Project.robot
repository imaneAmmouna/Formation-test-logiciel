*** Settings ***
Library           SeleniumLibrary

*** Variables ***
${BROWSER}        Edge
${LOGIN_PAGE}     https://accounts.lambdatest.com/login
${DATA_FILE}      C:/Users/IMANE/Desktop/Formation_Testing_QA/test_automatisé_robot/input_data.csv
${OUTPUT_FILE}    C:/Users/IMANE/Desktop/Formation_Testing_QA/test_automatisé_robot/output_results.csv

*** Test Cases ***
TestCase1
    [Documentation]    c'est la documentation du premier cas de test du projet Robot Framework Project
    Log    bienvenue à mon premier cas de test
    Log    je suis dans robot framework
    Log    j'ai arrivé à la fin du test

TestCase2
    open browser    https://tutoriels.edu.lat/    Edge
    Maximize Browser Window
    Close Browser

Test Text Input compte existe
    Open Browser    https://accounts.lambdatest.com/login    Edge
    Wait Until Element Is Visible    id=email    timeout=10
    Input Text    id=email    i.ougni@umi.edu.ac.ma
    Input Text    id=password    123456789
    Click Element    login-button
    Sleep    10
    Close Browser

Test Text Input compte n'existe pas
    Open Browser    https://accounts.lambdatest.com/login    Edge
    Wait Until Element Is Visible    id=email    timeout=10
    Input Text    id=email    khadija@gmail.com
    Input Text    id=password    123456789
    Click Element    login-button
    Sleep    10
    Close Browser

Test Radio Buttons
    Open Browser    https://formy-project.herokuapp.com/radiobutton    Edge
    Wait Until Element Is Visible    xpath=//input[@value='option1']    timeout=10
    # Select "Radio button 1"
    Click Element    xpath=//input[@value='option1']
    Sleep    2
    # Select "Radio button 2"
    Click Element    xpath=//input[@value='option2']
    Sleep    2
    Close Browser

Test Checkboxes
    Open Browser    https://formy-project.herokuapp.com/checkbox    Edge
    Wait Until Element Is Visible    xpath=//input[@id='checkbox-1']    timeout=10
    # Select and Deselect Checkbox 1
    Click Element    xpath=//input[@id='checkbox-1']
    Sleep    2
    Click Element    xpath=//input[@id='checkbox-1']
    Sleep    2
    # Select and Deselect Checkbox 2
    Click Element    xpath=//input[@id='checkbox-2']
    Sleep    2
    Click Element    xpath=//input[@id='checkbox-2']
    Sleep    2
    # Select Checkbox 1 and 3, then Deselect them
    Click Element    xpath=//input[@id='checkbox-1']
    Sleep    2
    Click Element    xpath=//input[@id='checkbox-3']
    Sleep    2
    Click Element    xpath=//input[@id='checkbox-1']
    Sleep    2
    Click Element    xpath=//input[@id='checkbox-3']
    Sleep    2
    # Select all Checkboxes, then Deselect them
    Click Element    xpath=//input[@id='checkbox-1']
    Sleep    2
    Click Element    xpath=//input[@id='checkbox-2']
    Sleep    2
    Click Element    xpath=//input[@id='checkbox-3']
    Sleep    2
    Click Element    xpath=//input[@id='checkbox-1']
    Sleep    2
    Click Element    xpath=//input[@id='checkbox-2']
    Sleep    2
    Click Element    xpath=//input[@id='checkbox-3']
    Sleep    2
    Close Browser

Test Dropdown List
    Open Browser    https://www.globalsqa.com/demo-site/select-dropdown-menu/    Edge
    Wait Until Element Is Visible    xpath=//select    timeout=10
    # Select option by value
    Select From List By Value    xpath=//select    AFG
    Sleep    2
    # Select option by index
    Select From List By Index    xpath=//select    5
    Sleep    2
    # Select option by visible text
    Select From List By Label    xpath=//select    India
    Sleep    2
    Close Browser
    *** Settings ***

Library
        SeleniumLibrary

Library
        OperatingSystem

Library
        CSVLibrary

Example Test Case
    Open Browser    ${LOGIN_PAGE}    ${BROWSER}
    ${data}=    Read CSV File    ${DATA_FILE}
    :FOR    ${row}    IN    @{data}
    \    ${num_cas_test}    Set Variable    ${row}[0]
    \    ${email}    Set Variable    ${row}[1]
    \    ${password}    Set Variable    ${row}[2]
    \    Log    Testing with email: ${email} and password: ${password}
    \    ${result}    Run Keyword And Ignore Error    Login With Credentials    ${email}    ${password}
    \    ${message}    Set Variable If    '${result}' == 'PASS'    Success    Fail
    \    ${status}    Set Variable If    '${result}' == 'PASS'    1    0
    \    Append To CSV File    ${OUTPUT_FILE}    ${num_cas_test}    ${status}    ${message}
    Close Browser

*** Keywords ***
Login With Credentials
    [Arguments]    ${email}    ${password}
    Go To    ${LOGIN_PAGE}
    Input Text    id=email    ${email}
    Input Text    id=password    ${password}
    Click Button    id=login-button
    ${logged_in}=    Wait Until Page Contains Element    id=user-profile
    Run Keyword If    not ${logged_in}    Fail    Login failed
    [Return]    PASS
