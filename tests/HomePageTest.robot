*** Settings ***
Resource    ../keywords/pages/HomePageKeyword.robot


*** Variables ***


*** Test Cases ***
TC_01_TecSkool_HomePage
    [Documentation]    1. Validate Homepage And HomePage Section Functionality
    [Setup]    Run keyword      Read Excel Values     HomePage_Test_001        HomePage       APAC
    [Tags]    TC_HomePage_REG     TC_HomePage_E2E   TC_HomePage_01
    Given User Navigate To Store And Validate Fields   ${HOME_URL}
    When User Navigate To Login Page And Validate Fields  ${EMAIL_ID}    ${PASSWORD}
    Then User Validate Successful Login    ${USERNAME}
    Then User Validate Section Links
    Then User Validate Price Filter    ${TD_DICT['ELECTRONICS_SECTION'][0]}    30     50

TC_02_TecSkool_HomePage
    [Documentation]    1. Validate Global Search Input Functionality From Home Page
    [Setup]    Run keyword      Read Excel Values     HomePage_Test_002        HomePage       APAC
    [Tags]    TC_HomePage_REG     TC_HomePage_E2E    TC_HomePage_02
    Given User Navigate To Store And Validate Fields   ${HOME_URL}
    When User Navigate To Login Page And Validate Fields  ${EMAIL_ID}    ${PASSWORD}
    Then User Validate Successful Login    ${USERNAME}
    Then User Validate Global Search Functionality    ${TD_DICT['PRODUCT_NAME'][0]}

