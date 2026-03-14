*** Settings ***
Resource    keywords/pages/LoginPageKeyword.robot

*** Variables ***
${SECTION_LINKS}    //a[@href = "#" and @class = "nav-link"]

*** Keywords ***
User Validate Section Links
    [Documentation]    Keyword Definition to Validate Sections In Home Page
    @{SECTIONS_LIST_LINKS}    Get Webelements    ${SECTION_LINKS}
    @{SECTIONS_LIST}    Create List
    ${SECTIONS_LIST_LENGTH}    Get Length    ${SECTIONS_LIST_LINKS}
    FOR    ${i}    IN RANGE       0     ${SECTIONS_LIST_LENGTH}
        ${VAR}    Get Text  ${SECTIONS_LIST_LINKS}[${i}]
        Append To List    ${SECTIONS_LIST}    ${VAR}
    END
    Set Global Variable         ${SECTIONS_LIST}

Go To Section Page
     [Arguments]    ${PAGE_NAME_VAL}
     Replace Xpath And Wait     ${A_TEXT}    ${PAGE_NAME_VAL}
     Replace Xpath And Click    ${A_TEXT}    ${PAGE_NAME_VAL}

User Validate Price Filter
    [Documentation]    Keyword defines price filter functionality
    [Arguments]    ${SECTION_NAME_VAL}    ${PRICE_MIN_VAL}    ${PRICE_MAX_VAL}
    Go To Section Page     ${SECTION_NAME_VAL}
    Replace Xpath And Wait     ${H3_TEXT}    ${PRICE_RANGE}
    ${VAL}   Replace String     ${H3_TEXT}    replace    ${PRICE_RANGE}
    Scroll Element Into View    ${VAL}
    Capture Page Screenshot
    Replace Xpath And Wait  ${INPUT_DATATEST_ID}    ${PRICE_MIN}
    Replace Xpath And Wait  ${INPUT_DATATEST_ID}    ${PRICE_MAX}
    Replace Xpath And Input Text    ${INPUT_DATATEST_ID}    ${PRICE_MIN}    ${PRICE_MIN_VAL}
    Replace Xpath And Input Text    ${INPUT_DATATEST_ID}    ${PRICE_MAX}     ${PRICE_MAX_VAL}
    Replace Xpath And Wait   ${BUTTON_DATATEST_ID}    ${APPLY_PRICE_FILTER}
    Replace Xpath And Click  ${BUTTON_DATATEST_ID}    ${APPLY_PRICE_FILTER}
    Capture Screenshot To Screenshot Folder

User Validate Global Search Functionality
     [Documentation]    User Validate Global Search Functionality
     [Arguments]    ${INPUT_VAL}
     Wait Until Keyword Succeeds    40 sec  2 sec     Replace Xpath And Wait  ${INPUT_DATATEST_ID}    ${SEARCH_INPUT}
     Replace Xpath And Input Text    ${INPUT_DATATEST_ID}    ${SEARCH_INPUT}    ${INPUT_VAL}
     User Get Product Count For Global Search Input
     Capture Page Screenshot

User Get Product Count For Global Search Input
    [Documentation]    Keyword gets the total product count for the global search input
    Replace Xpath And Wait    ${SPAN_DATATEST_ID}    ${PRODUCT_COUNT}
    ${RES}    Replace String  ${SPAN_DATATEST_ID}  replace  ${PRODUCT_COUNT}
    ${COUNT}    Get Text    ${RES}
    LOG    ${COUNT}