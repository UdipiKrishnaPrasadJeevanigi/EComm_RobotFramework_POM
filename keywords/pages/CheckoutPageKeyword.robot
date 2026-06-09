*** Settings ***
Resource    ../../keywords/pages/HomePageKeyword.robot

*** Variables ***
${ADD_TO_CART_BUTTON}     //h3[contains(text() , "replace")]/following::button[contains(@data-testid , "add-to-cart")][1]

*** Keywords ***

User Navigate To Checkout Page And Validate Fields
    [Documentation]    User Navigate To Checkout Page And Validate Fields
    Replace Xpath And Wait      ${BUTTON_DATATEST_ID}    ${CART_BUTTON}
    Replace Xpath And Click     ${BUTTON_DATATEST_ID}    ${CART_BUTTON}
    Capture Page Screenshot
    Replace Xpath And Wait      ${H2_TEXT}        ${SHOPPING_CART}
    Capture Page Screenshot
    
User Checkout Added Items And Validate
    [Documentation]    User Checkout Added Items And Validate
    [Arguments]    ${DELIVERY_TYPE}
    Replace Xpath And Scroll To Element       ${BUTTON_DATATEST_ID}    ${PROCEED_TO_CHECKOUT}
    Wait Until Keyword Succeeds   10s   500ms     Replace Xpath And Scroll To Element    ${H3_TEXT}    ${ORDER_SUMMARY}
    Replace Xpath And Wait   ${BUTTON_DATATEST_ID}    ${PROCEED_TO_CHECKOUT}
    Replace Xpath And Click  ${BUTTON_DATATEST_ID}    ${PROCEED_TO_CHECKOUT}
    Capture Page Screenshot
    Replace Xpath And Wait   ${H2_TEXT}    ${CHECKOUT}
    Replace Xpath And Input Text    ${INPUT_NAME}    ${SHIPPING_NAME}    ${TD_DICT['FULL_NAME'][0]}
    Replace Xpath And Input Text    ${INPUT_NAME}    ${SHIPPING_ADDRESS_INPUT}    ${TD_DICT['ADDRESS'][0]}
    Replace Xpath And Input Text    ${INPUT_NAME}    ${SHIPPING_CITY_INPUT}         ${TD_DICT['CITY'][0]}
    Replace Xpath And Input Text    ${INPUT_NAME}    ${SHIPPING_ZIP_INPUT}     ${TD_DICT['ZIP_CODE'][0]}
    Replace Xpath And Click     ${INPUT_DATATEST_ID}    ${DELIVERY_TYPE}


User Add Items To Cart And Validate
    [Documentation]   User Add Items To Cart And Validate
    [Arguments]    ${PRODUCT_NAME_VAL}
    Replace Xpath And Scroll To Element   ${ADD_TO_CART_BUTTON}    ${PRODUCT_NAME_VAL}
    Replace Xpath And Click  ${ADD_TO_CART_BUTTON}    ${PRODUCT_NAME_VAL}
    Capture Page Screenshot
