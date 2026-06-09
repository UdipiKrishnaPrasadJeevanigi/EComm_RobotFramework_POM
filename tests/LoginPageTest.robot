*** Settings ***
Resource    ../keywords/pages/LoginPageKeyword.robot
Resource    ../keywords/pages/HomePageKeyword.robot
Test Teardown    Close Browser

*** Variables ***


*** Test Cases ***
TC_01_LoginPage_Tecskool_store
    [Documentation]    1. Navigate to Application URL and validate required fields in the home page
    [Tags]    TC_LoginPage_REG    TC_LoginPage_E2E     TC_LoginPage_01

    Given User Navigate To Store And Validate Fields   ${HOME_URL}
    When User Navigate To Login Page And Validate Fields  ${EMAIL_ID}    ${PASSWORD}
    Then User Validate Successful Login    ${USERNAME}
    Then User Logout From The Application
    
TC_02_LoginPage_Invalid_Credentials
    [Documentation]    Login Functionality Validation Using Wrong Credentials
    [Tags]    TC_LoginPage_REG    TC_LoginPage_E2E    TC_LoginPage_02
    Given User Navigate To Store And Validate Fields   ${HOME_URL}
    When User Navigate To Login Page And Validate Fields  ${EMAIL_ID_INVALID}    ${PASSWORD}
    Then User Validate Successful Login    ${USERNAME}
    Then Close All Browsers
