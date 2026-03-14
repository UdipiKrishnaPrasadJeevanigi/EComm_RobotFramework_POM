*** Settings ***
Resource    keywords/pages/HomePageKeyword.robot


*** Variables ***


*** Test Cases ***
TC_01_TecSkool_HomePage
    [Documentation]    1. Validate Homepage And HomePage Section Functionality
    Given User Navigate To Store And Validate Fields   ${HOME_URL}
    When User Navigate To Login Page And Validate Fields  ${EMAIL_ID}    ${PASSWORD}
    Then User Validate Successful Login    ${USERNAME}
    Then User Validate Section Links
    Then User Validate Price Filter    ${ELECTRONICS_SECTION}    30     50

TC_02_TecSkool_HomePage
    [Documentation]    1. Validate Global Search Input Functionality From Home Page
    Given User Navigate To Store And Validate Fields   ${HOME_URL}
    When User Navigate To Login Page And Validate Fields  ${EMAIL_ID}    ${PASSWORD}
    Then User Validate Successful Login    ${USERNAME}
    Then User Validate Global Search Functionality    ${HEADPHONES}
