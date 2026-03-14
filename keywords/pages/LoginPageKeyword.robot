*** Settings ***
Resource    keywords/general.robot


*** Variables ***
${USERNAME_INFO_LABEL}    //span[@class = "info-label"]/following-sibling::span[@data-testid = "profile-name" and contains(text() , "replace")]

*** Keywords ***
User Navigate To Store And Validate Fields 
     [Documentation]    This keyword describes steps for navigating to store page
     [Arguments]    ${APP_URL}
     Launch Browser
     Navigate To Application    ${APP_URL}
     
User Navigate To Login Page And Validate Fields
     [Documentation]    Keyword Definition For User Navigate To Login Page And Validate Fields
     [Arguments]    ${USERNAME_VAL}    ${PASSWORD_VAL}
     Replace Xpath And Wait   ${BUTTON_DATATEST_ID}    ${ACCOUNT_BTN}
     Replace Xpath And Click  ${BUTTON_DATATEST_ID}    ${ACCOUNT_BTN}
     Capture Page Screenshot
     Wait Until Keyword Succeeds    40 sec  2 sec     Replace Xpath And Wait    ${H2_TEXT}    ${LOGIN_PAGE_LABEL}
     Replace Xpath And Input Text    ${INPUT_NAME}    ${EMAIL_INPUT}   ${USERNAME_VAL}
     Replace Xpath And Input Text    ${INPUT_NAME}    ${PASSWORD_INPUT}    ${PASSWORD_VAL}
     Capture Page Screenshot
     Replace Xpath And Wait     ${BUTTON_DATATEST_ID}    ${LOGIN_SUBMIT_BTN}
     Replace Xpath And Click    ${BUTTON_DATATEST_ID}    ${LOGIN_SUBMIT_BTN}
     ${ERROR_VAL}    Replace String    ${DIV_DATATEST_ID}  replace   ${LOGIN_ERROR}
     ${STA}    Run Keyword And Return Status    Wait Until Element Is Visible    ${ERROR_VAL}
     IF    '${STA}' == 'True'
         LOG     "Incorrect Credentials"
     END
     Capture Page Screenshot

User Validate Successful Login
     [Documentation]    Keyword Definition For Successful Login
     [Arguments]    ${USERNAME_VAL}
     Replace Xpath And Wait   ${BUTTON_DATATEST_ID}    ${ACCOUNT_BTN}
     Replace Xpath And Click  ${BUTTON_DATATEST_ID}    ${ACCOUNT_BTN}
     ${STA}    Run Keyword And Return Status    Replace Xpath And Wait   ${USERNAME_INFO_LABEL}    ${USERNAME_VAL}
     IF     '${STA}' == 'True'
         LOG    Login Unsuccessful
     END
     Replace Xpath And Click     ${A_DATATEST_ID}    ${LOGO_LINK}
