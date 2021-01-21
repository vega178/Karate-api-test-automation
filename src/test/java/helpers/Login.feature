Feature: Login Helper

  Scenario: Login
    Given url baseUrl
    Given path '/users/login'
    And request {"user": {"email": "#(userEmail)","password": "#(userPassword)"}}
    When method Post
    Then status 200
    * def sessionToken = response.user.token