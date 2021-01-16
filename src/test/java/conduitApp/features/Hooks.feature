@debug
  Feature: Hooks

    Background: hooks (Before "callonce"/ Before each "call")
#      * def result = call read('classpath:helpers/Dummy.feature')
#      * def username = result.userName

      #after hooks
      #* configure afterFeature = function() { karate.call('classpath:helpers/Dummy.feature') }
      * configure afterScenario = function() { karate.call('classpath:helpers/Dummy.feature') }
      * configure afterFeature =
      """
        function() {
          karate.log('After Feature Text');
        }
      """

    Scenario: First Scenario
      * print username
      * print 'This is first scenario'

    Scenario: Second Scenario
      * print username
      * print 'This is second scenario'