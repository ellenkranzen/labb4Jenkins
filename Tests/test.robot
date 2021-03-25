*** Settings ***
Documentation               Lab 2 - Vg-del Gherkin
Resource                    ../Resources/keywords.robot
Library                     SeleniumLibrary
Library                     robot.libraries.DateTime
Test Setup                  Begin Web Test
Test Teardown               End Web Test

*** Variables ***
${BROWSER}                  headlesschrome
${URL}                      http://rental7.infotiv.net/

*** Test Cases ***
User can from start page: log in, book a car and see booking
    [Documentation]                                 Testar hela navigationsflödet för att boka en bil
    [Tags]                                          VG_test
    Given user succesfully logs in and books a car
    And user succesfully confirms the booking
    Then the booking should be visible under My page
