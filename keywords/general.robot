*** Settings ***
Library    OperatingSystem
Library    SeleniumLibrary
Library    String
Library    Collections
Library    ../Library/excel_operations.py
Resource    ../keywords/pages/CartPageKeyword.robot
Variables        ../data/general_data.py

*** Variables ***
${BROWSER}       chrome
${PAGE_URL}      https://testcart.tecskool.com/
${BUTTON_TYPE}       //button[@type = "replace"]
${BUTTON_DATATEST_ID}    //button[@data-testid = "replace"]
${H1_TEXT}          //h1[text() = "replace"]
${H2_TEXT}          //h2[text() = "replace"]
${H3_TEXT}          //h3[text() = "replace"]
${INPUT_NAME}       //input[@name = "replace"]
${INPUT_ARIA_LABEL}    //input[contains(@aria-label , "replace")]
${INPUT_CONTAINS_CLASS}  //input[contains(@class , "replace")]
${INPUT_PLACEHOLDER}    //input[@placeholder = "replace"]
${INPUT_DATATEST_ID}    //input[@data-testid = "replace"]
${BUTTON_TEXT}     //button[@text = "replace"]
${INPUT_TYPE}       //input[@type = "replace"]
${IMG_TITLE}        //img[contains(@title , "replace")]
${SPAN_TXT}         //span[text() = "replace"]
${SPAN_TITLE}       //span[@title = "replace"]
${SPAN_CLASS}       //span[@class = "replace"]
${SPAN_DATATEST_ID}    //span[@data-testid = "replace"]
${SPAN_CONTAINS_TXT}    //span[contains(text() , "replace")]
${SPAN_CONTAINS_CLASS}  //span[contains(@class , "replace")]
${A_TEXT}            //a[text() = "replace"]
${A_CONTAINS_HREF}    //a[contains(@href , "replace")]
${A_HREF}         //a[@href = "replace"]
${A_DATATEST_ID}    //a[@data-testid = "replace"]
${DIV_DATATEST_ID}    //div[@data-testid = "replace"]

${HOME_URL}        https://testcart.tecskool.com/
${USERNAME}    Demo User
${EMAIL_ID}     demo@tecskool.com
${EMAIL_ID_INVALID}    demo2@tecskool.com
${PASSWORD}        Password123
${PASSWORD_INVALID}     Password1

*** Keywords ***
Launch Browser
    [Documentation]    Launch browser with specified popup behavior
    ${chrome_options}=    Evaluate    selenium.webdriver.ChromeOptions()    modules=selenium.webdriver
    ${headless}=          Set Variable    --headless=new
    ${no_sandbox}=        Set Variable    --no-sandbox
    ${shm}=               Set Variable    --disable-dev-shm-usage
    ${gpu}=               Set Variable    --disable-gpu
    Call Method    ${chrome_options}    add_argument    ${headless}
    Call Method    ${chrome_options}    add_argument    ${no_sandbox}
    Call Method    ${chrome_options}    add_argument    ${shm}
    Call Method    ${chrome_options}    add_argument    ${gpu}
    Open Browser    ${PAGE_URL}    chrome    options=${chrome_options}

Read Excel Values
    [Documentation]    Keyword to fetch the values from the excel sheet
    [Arguments]    ${TC_NAME}   ${SHEET_NAME}    ${COUNTRY}
    ${RESULT_DIR}    Set Variable    ${EXECDIR}\
    ${EXCEL_FILE_LOC}    Set Variable    ${RESULT_DIR}/data/${COUNTRY}/TestData.xlsx
    ${EXCEL_FILE_LOC}   Replace String    ${EXCEL_FILE_LOC}    /    \\
    ${TD_DICT}   Read Excel Row  ${TC_NAME}   ${SHEET_NAME}  ${EXCEL_FILE_LOC}
    Set Global Variable    ${TD_DICT}
    log   ${TD_DICT}
    Set Test Variable    ${LANGUAGERUNTIME}    ${TD_DICT['EXECUTION_LANGUAGE'][0]}
    RETURN  ${TD_DICT}

Click Element Using Javascript
    [Documentation]    Click element using JavaScript with XPath
    [Arguments]    ${xpath}
    ${element}=    Get WebElement    xpath:${xpath}
    Execute Javascript    arguments[0].scrollIntoView(true); arguments[0].click();    ARGUMENTS    ${element}

Get Base URL
    [Documentation]    Get Base URL of the current page
    ${CURRENT URL}    Get Location
    ${SPLIT CURRENT URL}       Split String    ${current_url}    separator=.com
    ${BASE URL}     Get From List    ${split_current_url}    0
    RETURN        ${BASE_URL}

Replace Xpath And Click
    [Documentation]    Replace Xpath And Wait For Element
    [Arguments]    ${XPATH}  ${NAME}
    ${STR}    Replace String  ${XPATH}  replace  ${NAME}
    Wait Until Element Is Visible    ${STR}     ${TIMEOUT_10S}
    ${RES}     run keyword and return status    Click Element    ${STR}
    IF    '${RES}'==False
        Click Element Using Javascript  ${STR}
    END

Click Shadow DOM Element
    [Arguments]    ${host_selector}    ${input_selector}
    Execute Javascript
    ...    document.querySelector('${host_selector}').shadowRoot.querySelector('${input_selector}').click();

Replace Xpath And Wait
    [Documentation]    Replace Xpath And Wait For Element
    [Arguments]    ${XPATH}  ${NAME}
    ${STR}    Replace String  ${XPATH}  replace  ${NAME}
    Wait Until Element Is Visible    ${STR}     ${TIMEOUT_10S}
    Capture Page Screenshot

Replace Xpath And Input Text
    [Documentation]    Generic Keyword to Input Text
    [Arguments]    ${XPATH}  ${NAME}    ${VAL}
    ${STR}    Replace String  ${XPATH}  replace  ${NAME}
    Wait Until Page Contains Element    ${STR}
    Input Text     ${STR}    ${VAL}

Navigate To Application
    [Documentation]    Keyword to Navigate to certain App through app url
    [Arguments]    ${APP_NAME}
    ${BASE_URL}    Set Variable    ${APP_NAME}
    Go To    ${BASE_URL}

Navigate To Page
    [Documentation]    Keyword to Navigate to certain page through url
    [Arguments]    ${PAGE_NAME}
    ${BASE_URL}    Get Base URL
    ${RES_URL}      Set Variable       ${BASE_URL}/${PAGE_NAME}/
    Go To     ${RES_URL}

Capture Screenshot To Screenshot Folder
    [Documentation]    This Keyword defines the movement of screenshots to screenshot folder
    Capture Page Screenshot
    Create Directory    ${EXECDIR}/screenshots
    @{PNG_LIST}    List Files In Directory    ${EXECDIR}    *.png
    FOR     ${i}    IN     @{PNG_LIST}
        Move File    ${EXECDIR}/${i}    ${EXECDIR}/screenshots/${i}
    END

User Logout From The Application
    [Documentation]    Keyword Defines The LogOut Functionality
    Replace Xpath And Wait   ${BUTTON_DATATEST_ID}    ${ACCOUNT_BTN}
    Replace Xpath And Click  ${BUTTON_DATATEST_ID}    ${ACCOUNT_BTN}
    Replace Xpath And Wait   ${BUTTON_DATATEST_ID}    ${LOGOUT_BTN}
    Replace Xpath And Click  ${BUTTON_DATATEST_ID}    ${LOGOUT_BTN}

Close Browser
    [Documentation]    Keyword defenition for closing the browser
    Close All Browsers