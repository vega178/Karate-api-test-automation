@ignore
Feature: Sing up new user

  Background: Preconditions
    * def dataGenerator = Java.type('helpers.DataGenerator')
    Given url baseUrl

    Scenario: New user Sing up
      * def randomEmail = dataGenerator.getRandomEmail()
      #* def randomUserName = dataGenerator.getRandomUserName()
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