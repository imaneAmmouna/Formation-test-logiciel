*** Settings ***
Library  SeleniumLibrary
Library  RPA.CSV
Library  OperatingSystem

*** Variables ***
${EDGE_DRIVER_PATH}  C:/Users/IMANE/Downloads/edgedriver_win64/msedgedriver.exe
${URL}  https://accounts.lambdatest.com/login?_gl=1*kscq4z*_gcl_au*MTA2ODc1OTI4Ny4xNjk1NzMyOTM3
${CSV_FILE}  C:/Users/IMANE/Desktop/Formation_Testing_QA/test_automatisé_robot/input_data.csv

*** Test Cases ***
Run Tests
    [Documentation]  Run login tests with credentials from CSV
    Open Browser  ${URL}  edge  executable_path=${EDGE_DRIVER_PATH}
    ${data}  Read Table From CSV  ${CSV_FILE}  header=True
    :FOR  ${row}  IN  @{data}
    \  ${email}=  Set Variable  ${row.email}
    \  ${password}=  Set Variable  ${row.password}
    \  Log  \nStarting test with email: ${email} and password: ${password}
    \  ${result}=  Run Test Keyword And Return Status  ${email}  ${password}
    \  Run Keyword If  '${result}' == 'PASS'
    \  ...  Log  Test Passed
    \  ...  ELSE
    \  ...  Log  Test Failed
    Close Browser

*** Keywords ***
Run Test Keyword And Return Status
    [Arguments]  ${email}  ${password}
    Input Text  id:email  ${email}
    Input Text  id:password  ${password}
    Click Button  id:login-button
    ${result}  Wait Until Element Is Visible  id:dashboard  timeout=10s
    RETURN  ${result}
