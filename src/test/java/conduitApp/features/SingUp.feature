@ignore
Feature: Sing up new user

  Background: Preconditions
    Given url baseUrl

    Scenario: New user Sing up
      Given def userData = {"email": "estebanvegapatio+2@gmail.com", "userName": "vega178+4"}

      Given path 'users'
      And request
      """
        {
           "user": {
            "email": #(userData.email),
            "password": "Ab1234567!",
            "username": #(userData.userName)
           }
        }
      """
      When method Post
      Then status 200