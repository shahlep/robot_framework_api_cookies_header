*** Settings ***
Library  RequestsLibrary
Library  Collections

*** Variables ***
${base_url}  https://www.youtube.com

*** Test Cases ***
test_header
    create session  my_session  ${base_url}
    ${response}=    get on session  my_session  /
    #log to console  ${response.headers}  # headers are stored as key value pair

    ${content_type_value}=   get from dictionary  ${response.headers}    Content-Type    # text/html; charset=utf-8
    ${content_encoding}=  get from dictionary  ${response.headers}    Content-Encoding
    should be equal  ${content_type_value}      text/html; charset=utf-8
    should be equal  ${content_encoding}    gzip

    ## cookie value changes dynamically so cannot check but out can check if cookie has been created??

test_cookies
    create session  my_session  ${base_url}
    ${response}=    get on session  my_session  /
    #log to console      ${response.cookies}     #displays all the cookies from response

    ## in case we have multiple cookies we can extract specific cookies
    ${cookie_val}=  get from dictionary  ${response.cookies}         CONSENT   #name of the cookie
    log to console   ${cookie_val}   ## display specific cookie value from the given name