*** Settings ***
Library           SeleniumLibrary
Library           OperatingSystem
Library           CSVLibrary

*** Variables ***
${BROWSER}        Edge
${URL}     https://accounts.lambdatest.com/login


*** Test Cases ***
Test Lambdatest
    Open Browser    ${URL}    ${BROWSER}
    ${data}    Read CSV File To List    C:/Users/IMANE/Desktop/Formation_Testing_QA/test_automatisé_robot/input_data.csv
    FOR    ${row}    IN    @{data}
        ${num_cas_test}    ${email}    ${password}    ${row}
        Login With Credentials    ${email}    ${password}    ${num_cas_test}
    END
    Close Browser

*** Keywords ***
Login With Credentials
    [Arguments]    ${email}    ${password}    ${num_cas_test}
    Go To    ${URL}
    Input Text    id=email    ${email}
    Input Text    id=password    ${password}
    Click Button    css=.login__btn
    ${url_after_login}    Get Location
    Run Keyword If    '${url_after_login}' == '${URL}'    Login Passed    ${num_cas_test}
    ...    ELSE    Login Failed    ${num_cas_test}

Login Passed
    [Arguments]    ${num_cas_test}
    Log    Test Case ${num_cas_test} passed
    ${results}    Create List    ${num_cas_test}    1    OK
    Write To CSV File    C:/Users/IMANE/Desktop/Formation_Testing_QA/test_automatisé_robot/output_data.csv    ${results}

Login Failed
    [Arguments]    ${num_cas_test}
    Log    Test Case ${num_cas_test} failed
    ${results}    Create List    ${num_cas_test}    0    KO
    Write To CSV File    C:/Users/IMANE/Desktop/Formation_Testing_QA/test_automatisé_robot/output_data.csv    ${results}