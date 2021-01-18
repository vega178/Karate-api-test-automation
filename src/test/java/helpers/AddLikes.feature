
  Feature: Add likes

    Background:
      * url baseUrl

    Scenario: add likes
      Given path 'articles',articleSlug,'favorite'
      And request {}
      When method Post
      Then status 200
      * def likesCount = response.articles[0].favoritesCount
