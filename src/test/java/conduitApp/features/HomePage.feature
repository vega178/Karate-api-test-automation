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
    And match response.tags contains any ['fish', 'dog', 'dragons']
    And match response.tags == '#array'
    And match each response.tags == '#string'

  @debug @regression @get_articles_test_1
  Scenario: Get 10 articles from the page
    * def timeValidator = read('classpath:helpers/timeValidator.js')

    Given params { limit: 10, offset: 0}
    Given path '/articles'
    When method Get
    Then status 200
    And match response.articlesCount == 500
    And match response.articlesCount != 1000
    And match response == { "articles": "#[10]", "articlesCount": 500 }
    And match response.articles[0].createdAt contains '2021'
    # "[*]: loop through the array"
    And match response.articles[*].favoritesCount contains 0
    # "..": search in any part of the response"
    And match response..bio contains null
    And match each response..following == false
    # "#datatype" : fuzzy matching
    And match each response..following == '#boolean'
    And match each response..favoritesCount == '#number'
    # "##datatype" : optional datatype / loop through each item and ignore the value that contains null
    And match each response..bio == '##string'
    # all Schema validation
    And match each response.articles ==
    """
       {
            "title": "#string",
            "slug": "#string",
            "body": "#string",
            "createdAt": "#? timeValidator(_)",
            "updatedAt": "#? timeValidator(_)",
            "tagList": "#array",
            "description": "#string",
            "author": {
                "username": "#string",
                "bio": "##string",
                "image": "#string",
                "following": "#boolean"
            },
            "favorited": "#boolean",
            "favoritesCount": "#number"
        }
    """
    * def articleTitle = response.articles[0].title
