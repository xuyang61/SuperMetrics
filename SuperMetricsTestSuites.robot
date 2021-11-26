*** Settings ***
Library             Collections
Library             Browser
Suite Setup         Setup Test Suite
Suite Teardown      Close Browser
Test Setup          New Page            http://localhost:3000/
Test Teardown       Close Testcase

# robot -d results RobotFrameWork/Tests/SuperMetricsTestSuites.robot

*** Test Cases ***
User Can Change Cats Names
    Open the Cat Manager
    Login The System as User        # Validate if the user can see all cats names
    Verify All Elements are Presented
    Change the name of cats
    Sorting the Cat Awesomeness     # Validate if the cats awesomeness is according to ASCII charactors


Admin Can Change Cats Names and Delete Cats
    Open the Cat Manager
    Login The System as Admin       # Validate if the registeration work as expected
    Verify All Elements are Presented
    Change the name of cats
    Sorting the Cat Awesomeness     # Validate if the cats awesomeness is according to ASCII charactors
    Delete a cat
    Restore the Page Content        # Validate if the reset key can bring all content back

Cats Names are Consistant between Logins - Users/Admins
    Open the Cat Manager
    Login The System as Admin
    Change the name of cats
    Click              text=Log out
    Login The System as User
    Sorting the Cat Awesomeness
    Clear Text          text=James
    Keyboard Input      insertText    aaa
    # click save button on the first cat (again, the path should be better)
    Click               css=.sc-jrAFXE:nth-child(1) .sc-fubCzh
    Click               text=Log out
    Login The System as Admin
    Get Elements        text=aaa
    Restore the Page Content

*** Keywords ***
Setup Test Suite
    Open Browser                     headless=false


Open the Cat Manager
# Requirement 2: When not logged-in, only the login page can be visited by a user
    Get Elements                    text=username
    Get Element Count               text=Log In     ==      2

Login The System as Admin
    Type Text                       id=username     admin
    Get Elements                    id=password
    Type Text                       id=password     adminpass
    # click login on the form
    Click                           form >> text=Log in
    Get Element Count               text=Log out

Verify All Elements are Presented
    Get Element                     text=James >> ../../../div/span[1] >> text=Rank:
    Get Element                     text=James >> ../../../div/span[2] >> text=1
    Get Element                     text=James >> ../../../div/span[3] >> text=Awesomeness:
    Get Element                     text=James >> ../../../div/span[4] >> text="∞"
    Get Element                     text=James >> ../../div/img
    Get Element                     text=Sergey >> ../../../div/span[1] >> text=Rank:
    Get Element                     text=Sergey >> ../../../div/span[2] >> text=2
    Get Element                     text=Sergey >> ../../../div/span[3] >> text=Awesomeness:
    Get Element                     text=Sergey >> ../../../div/span[4] >> text=623
    Get Element                     text=Sergey >> ../../div/img
    Get Element                     text=Peter >> ../../../div/span[1] >> text=Rank:
    Get Element                     text=Peter >> ../../../div/span[2] >> text=3
    Get Element                     text=Peter >> ../../../div/span[3] >> text=Awesomeness:
    Get Element                     text=Peter >> ../../../div/span[4] >> text=512
    Get Element                     text=Peter >> ../../div/img
    Get Element                     text=Harri >> ../../../div/span[1] >> text=Rank:
    Get Element                     text=Harri >> ../../../div/span[2] >> text=4
    Get Element                     text=Harri >> ../../../div/span[3] >> text=Awesomeness:
    Get Element                     text=Harri >> ../../../div/span[4] >> text=502
    Get Element                     text=Harri >> ../../div/img
    Get Element                     text=Otto >> ../../../div/span[1] >> text=Rank:
    Get Element                     text=Otto >> ../../../div/span[2] >> text=5
    Get Element                     text=Otto >> ../../../div/span[3] >> text=Awesomeness:
    Get Element                     text=Otto >> ../../../div/span[4] >> text=422
    Get Element                     text=Otto >> ../../div/img
    Get Element                     text=Dups >> ../../../div/span[1] >> text=Rank:
    Get Element                     text=Dups >> ../../../div/span[2] >> text=6
    Get Element                     text=Dups >> ../../../div/span[3] >> text=Awesomeness:
    Get Element                     text=Dups >> ../../../div/span[4] >> text=412
    Get Element                     text=Dups >> ../../div/img

Login The System as User
    Type Text                       id=username     user
    Wait For Elements State         id=password
    Type Text                       id=password     helloworld
    Click                           form >> text=Log in
    Get Element Count               text=Log out

Change the name of cats
    Clear Text                      text=James
    Keyboard Input                  insertText    zzz
    # click save button on the first cat (again, the path should be better)
    Click                           css=.sc-jrAFXE:nth-child(1) .sc-fubCzh
    Get Elements                    text=zzz >> ../../../div/span[4] >> text=366
    Clear Text                      text=Sergey
    Keyboard Input                  insertText    James
    Click                           css=.sc-jrAFXE:nth-child(1) .sc-fubCzh
    Get Elements                    text=James >> ../../../div/span[4] >> text="∞"
    Clear Text                      text=Harri
    Keyboard Input                  insertText    ~~~~~
    Click                           css=.sc-jrAFXE:nth-child(3) .sc-fubCzh
    Get Elements                    text=~~~~~ >> ../../../div/span[4] >> text=630

Sorting the Cat Awesomeness
    Get Elements                    text=James >> ../../../div/span[2] >> text=1
    Get Elements                    text=~~~~~ >> ../../../div/span[2] >> text=2
    Get Elements                    text=zzz >> ../../../div/span[2] >> text=6

Delete a Cat
    # Validate if the page is loaded as expected and first picture being deleted
    Get Element Count               text=James   ==  1
    # click the delete button for cat named James
    # strangely this doesn't work with XPath even for full path - a Browser library bug?
    # Click                         text="James" >> ../../svg[2]
    Click                           css=.sc-jrAFXE:nth-child(1) line:nth-child(3)
    Get Element Count               text=James   ==  0


Restore the Page Content
    Click                           text=Reset
    Get Elements                    text=James >> ../../../div/span[4] >> text="∞"
    Get Elements                    text=Sergey >> ../../../div/span[4] >> text=623
    Get Elements                    text=Peter >> ../../../div/span[4] >> text=512
    Get Elements                    text=Harri >> ../../../div/span[4] >> text=502
    Get Elements                    text=Otto >> ../../../div/span[4] >> text=422
    Get Elements                    text=Dups >> ../../../div/span[4] >> text=412

Close Testcase
    Click                           text=Reset
    Close Context