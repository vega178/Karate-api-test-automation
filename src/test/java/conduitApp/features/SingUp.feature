
Feature: Sing up new user

  Background: Preconditions
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * def randomEmail = dataGenerator.getRandomEmail()
    * def randomUserName = dataGenerator.getRandomUserName()
    Given url baseUrl

    Scenario: New user Sing up
      * def timeValidator = read('classpath:helpers/timeValidator.js')
      * def jsFunction =
      """
        function () {
          var DataGenerator = Java.type('helpers.DataGenerator')
          var generator = new DataGenerator()
          return generator.getRandomName()
        }
      """
      * def chuckNorrisName = call jsFunction

      Given path 'users'
      And request
      """
        {
           "user": {
            "email": #(randomEmail),
            "password": "Ab1234567!",
            "username": #(chuckNorrisName)
           }
        }
      """
      When method Post
      Then status 200
      And match response ==
      """
        {
            "user": {
                "id": "#number",
                "email": #(randomEmail),
                "createdAt": "#? timeValidator(_)",
                "updatedAt": "#? timeValidator(_)",
                "username": #(chuckNorrisName),
                "bio": null,
                "image": null,
                "token": "#string"
            }
        }
      """

      Scenario Outline: Validate sing up error messages
        Given path 'users'
        And request
        """
          {
             "user": {
              "email": <email>,
              "password": <password>,
              "username":<username>
             }
          }
        """
        When method Post
        Then status 422
        And match response == <errorResponse>

        Examples:
          |         email              | password   | username                          | errorResponse                                                                     |
          |estebanvegapatio+3@gmail.com| Ab1234567! | #(randomUserName)                 | {"errors":{"email":["has already been taken"]}}                                   |
          |#(randomEmail)              | Ab1234567! | vega178+7                         | {"errors":{"username":["has already been taken"]}}                                |
          |estebanvegapatio+3          | Ab1234567! | #(randomUserName)                 | {"errors":{"email":["is invalid"]}}                                               |
          |#(randomEmail)              | Ab1234567! | vega178+77777777777777777777      | {"errors":{"username":["is too long (maximum is 20 characters)"]}}                |
          |#(randomEmail)              | A          | #(randomUserName)                 | {"errors":{"password":["is too short (minimum is 8 characters)"]}}                |
          |                            | Ab1234567! | #(randomUserName)                 | {"errors":{"email":["can't be blank"]}}                                           |
          |#(randomEmail)              |            | #(randomUserName)                 | {"errors":{"password":["can't be blank"]}}                                        |
          |#(randomEmail)              | Ab1234567! | ""                                | {"errors":{"username":["can't be blank","is too short (minimum is 1 character)"]}}|
