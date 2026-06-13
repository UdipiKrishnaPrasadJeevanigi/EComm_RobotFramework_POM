*** Settings ***
Resource    ../keywords/pages/CheckoutPageKeyword.robot
Suite Setup     Load Config
Suite Teardown    Close Browser

*** Variables ***




*** Test Cases ***
TC_01_TecSkool_CheckOutPage
    [Documentation]    1. Validate CheckOutPage Functionality
    [Setup]    Run keyword      Read Excel Values     CheckOutPage_Test_001        CheckoutPage       APAC
    [Tags]    TC_CheckOutPage_REG     TC_HomePage_E2E   TC_CheckOutPage_01
    Given User Navigate To Store And Validate Fields   ${HOME_URL}
    When User Navigate To Login Page And Validate Fields  ${EMAIL_ID}    ${PASSWORD}
    Then User Navigate To Checkout Page And Validate Fields
    Then User Logout From The Application

TC_02_TecSkool_CheckOutPage
    [Documentation]    1. Validate Global Search Input Functionality From Home Page
    [Setup]    Run keyword      Read Excel Values     CheckOutPage_Test_002        CheckoutPage       APAC
    [Tags]    TC_CheckOutPage_REG     TC_CheckOutPage_E2E    TC_CheckOutPage_02
    Given User Navigate To Store And Validate Fields   ${HOME_URL}
    When User Navigate To Login Page And Validate Fields  ${EMAIL_ID}    ${PASSWORD}
    Then User Add Items To Cart And Validate    ${TD_DICT['CHECKOUT_PRODUCT_NAME'][0]}
    Then User Navigate To Checkout Page And Validate Fields
    Then User Checkout Added Items And Validate   ${TD_DICT['DELIVERY_OPTION'][0]}