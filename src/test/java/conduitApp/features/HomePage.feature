Feature: Test for the home page

  Background: Define URL
    Given url baseUrl

  @debug @regression
  Scenario: Get all tags
    Given path '/tags'
    When method Get
    Then status 200
    And match response.tags contains ['HITLER', 'BlackLivesMatter', 'dragons']
    And match response.tags !contains 'cars'
    And match response.tags == '#array'
    And match each response.tags == '#string'

  @debug @regression @get_articles_test_1
  Scenario: Get 10 articles from the page
    Given params { limit: 10, offset: 0}
    Given path '/articles'
    When method Get
    Then status 200
    And match response.articles == '#[10]'
    And match response.articlesCount == 500
    * def articleTitle = response.articles[0].title
