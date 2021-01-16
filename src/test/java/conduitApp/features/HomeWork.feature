@debug
  Feature: Home Work

    Background: Preconditions
      * url baseUrl
      * def initialCount = 0
      * def articleBodyData = read('classpath:conduitApp/bodyParameters/newArticlesBodyParameters.json')
      * def timeValidator = read('classpath:helpers/timeValidator.js')
      * def dataGenerator = Java.type('helpers.DataGenerator')
      * set articleBodyData[0].comment.body = dataGenerator.getRandomComment()

    Scenario: Favorite Articles
      Given params { limit: 10, offset: 0}
      Given path '/articles'
      When method Get
      Then status 200
      * def favoriteArticle = response.articles[0].favoritesCount
      * def articleSlug = response.articles[0].slug

      Given path '/articles/',articleSlug,'favorite'
      And request {}
      When method Post
      Then status 200
      And match response ==
      """
          {
            "article": {
                "title": "#string",
                "slug": "#string",
                "body": "#string",
                "createdAt": "#? timeValidator(_)",
                "updatedAt": "#? timeValidator(_)",
                "tagList": "#array",
                "description": "#string",
                "author": {
                    "username": "#string",
                    "bio": null,
                    "image": "#string",
                    "following": "#boolean"
                },
                "favorited": #boolean,
                "favoritesCount": "#number"
            }
          }
      """
      And match response.article.favoritesCount == initialCount + 1
      Given params { favorited: vega178, limit: 1, offset: 0 }
      Given path '/articles'
      When method Get
      Then status 200
      And match response ==
      """
        {
          "articles": [
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
                    "bio": null,
                    "image": "#string",
                    "following": "#boolean"
                },
                "favorited": #boolean,
                "favoritesCount": "#number"
              }
          ],
          "articlesCount": "#number"
       }
      """
      And match response.articles[*].slug contains any articleSlug

    @debug
      Scenario: Comment articles
        Given params { limit: 10, offset: 0}
        Given path '/articles'
        When method Get
        Then status 200
        * def articleSlug = response.articles[0].slug

        Given path '/articles',articleSlug,'comments'
        And request articleBodyData[0].comment
        Given method Post
        Then status 200
        And match response ==
        """
          {
            "comment": {
                 "id": "#number",
                "createdAt": "#? timeValidator(_)",
                "updatedAt": "#? timeValidator(_)",
                "body": "#string",
                "author": {
                    "username": "#string",
                    "bio": null,
                    "image": "#string",
                    "following": #boolean
                }
            }
          }
        """

        Given path '/articles',articleSlug,'comments'
        When method Get
        Then status 200
        And match response.comments[0] ==
        """
           {
            "id": "#number",
            "createdAt": "#? timeValidator(_)",
            "updatedAt": "#? timeValidator(_)",
            "body": "#string",
            "author": {
                "username": "#string",
                "bio": null,
                "image": "#string",
                "following": #boolean
            }
          }
        """
        * def commentsCount = response.comments.length


