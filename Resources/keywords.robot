*** Settings ***
Library                     SeleniumLibrary
Library                     robot.libraries.DateTime

*** Keywords ***
Begin Web Test
    Open browser                        about:blank     ${BROWSER}

User succesfully logs in and books a car
    User is on the start page
    User succesfully logs in
    Startdate is today's date
    Enddate is today's date
    User continues to page to choose a car
    User chooses an available car

User is on the start page
    Load Page
    Verify page loaded

Load Page
    Go to                               ${URL}

Verify page loaded
    Wait until page contains            Infotiv Car Rental

User succesfully logs in
    Enter e-mail
    Enter password
    Click login
    Verify succesfully logged in

Enter e-mail
    Click element                       id=email
    Input text                          id=email         ellen.kranzen@iths.se

Enter password
    Click element                       id=password
    Input password                      id=password    hemligt

Click login
    Click element                       id=login

Verify succesfully logged in
    Wait until page contains            You are signed in as E
    ${actual_text}                      Get text          id=welcomePhrase
    Should be equal                     "${actual_text}"         "You are signed in as E"

Startdate is today's date
    ${todays_date}                      Get Current Date    result_format=%Y-%m-%d
    ${start_date}                       Get value    id=start
    Should Be Equal	                    "${todays_date}"     "${start_date}"

Enddate is today's date
    ${todays_date}                      Get Current Date    result_format=%Y-%m-%d
    ${start_date}                       Get value    id=end
    Should Be Equal	                    "${todays_date}"     "${start_date}"

User continues to page to choose a car
    Click element                       id=continue
    Verify showCars page loaded

Verify showCars page loaded
    Wait until page contains            What would you like to drive?
    ${actual_text}                      Get text               id=questionText
    Should be equal                     "${actual_text}"      "What would you like to drive?"

User chooses an available car
    Click element                       id=bookModelSpass5
    Verify confirmBook page loaded

Verify confirmBook page loaded
    Wait until page contains            Pickup date:
    ${actual_text}                      Get text                id=questionText
    Should be equal                     "${actual_text}"        "Confirm booking of Tesla Model S"

User succesfully confirms the booking
    Enter card number
    Enter name of card holder
    Enter month
    Enter year
    Enter CVC
    Click Confirm
    Verify succesful booking

Enter card number
    Click element                        id=cardNum
    Input text                           id=cardNum     1111000011110000

Enter name of card holder
    Click element                       id=fullName
    Input text                          id=fullName     E K

Enter month
    Click element                       xpath://*[@id="confirmSelection"]/form/select[1]
    Click element                       xpath://*[@id="month6"]

Enter year
    Click element                       xpath://*[@id="confirmSelection"]/form/select[2]
    Click element                       xpath://*[@id="month2022"]

Enter CVC
    Click element                       id=cvc
    Input text                          id=cvc      000

Click confirm
    Click element                        id=confirm

Verify succesful booking
    ${todays_date}                      Get Current Date    result_format=%Y-%m-%d
    Wait until page contains            You can view your booking on your page
    ${actual_text}                      Get text                id=questionTextSmall
    Should be equal                     "${actual_text}"        "A Tesla Model S is now ready for pickup ${todays_date}"

The booking should be visible under my page
    Click My page
    Verfify myPage loaded
    Verify the right brand is booked
    Verify the right model is booked

Click My page
    Click element                       id=mypage

Verfify myPage loaded
    Wait until page contains            My bookings
    ${actual_text}                      Get text       id=historyText
    Should be equal                     "${actual_text}"        "My bookings"

Verify the right brand is booked
    ${actual_brand}                     Get text            id=make1
    Should be equal                     "${actual_brand}"   "Tesla"

Verify the right model is booked
    ${actual_model}                     Get text            id=model1
    Should be equal                     "${actual_model}"   "Model S"

Cancel booking
    sleep                              1 s
    Click button                       xpath://*[@id="unBook1"]
    Handle Alert
    Click button                       id=mypage
    Verify booking cancelled

Verify booking cancelled
    ${actual_text}                     Get text     id=historyText
    Should be equal                    "${actual_text}"     "You have no bookings"

End Web Test
    Cancel booking
    Close browser
