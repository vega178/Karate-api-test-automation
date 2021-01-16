@debug
  Feature: Dummy

    Scenario: Dummy
      * def dataGenerator = Java.type('helpers.DataGenerator')
      * def userName = dataGenerator.getRandomUserName()
      * print userName
