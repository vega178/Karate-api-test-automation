
Feature: Articles

  Background: Define URL
    Given url baseUrl
    * def articleBodyData = read('classpath:conduitApp/bodyParameters/newArticlesBodyParameters.json')
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * set articleBodyData[0].article.title = __gatling.Title
    * set articleBodyData[0].article.description = __gatling.Description
    * set articleBodyData[0].article.body = __gatling.Body

    * def sleep = function(ms){ java.lang.Thread.sleep(ms) }
    * def pause = karate.get('__gatling.pause', sleep)

  Scenario: Create and Delete a new article
    * configure headers = {"Authorization": #('Token ' + __gatling.token)}
    Given path '/articles/'
    And request articleBodyData[0].article
    And header karate-name = 'Title requested: ' + __gatling.Title
    When method Post
    Then status 200
    * def articleId = response.article.slug

    * pause(5000)

    Given path '/articles',articleId
    When method Delete
    Then status 200
