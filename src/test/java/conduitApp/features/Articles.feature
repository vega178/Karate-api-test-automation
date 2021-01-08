
@smoke
Feature: Articles

  Background: Define URL
      Given url baseUrl
      #* def loginService = callonce read('classpath:helpers/login.feature')
      #* def loginService = callonce read('classpath:helpers/login.feature') {"email": "estebanvegapatio@gmail.com","password": "Ab1234567!"}
      #* def sessionToken = loginService.sessionToken

  @debug #@ignore
    Scenario: Create a new article
      #Given header Authorization = 'Token ' + sessionToken
      Given path '/articles/'
      And request {"article":{"tagList":[],"title":"Test Article","description":"Test Description","body":"Bla bla"}}
      When method Post
      Then status 200
      * def testArticleTitle = call read('HomePage.feature@get_articles_test_1')
      * def articleTitle = testArticleTitle.articleTitle
      And match response.article.title == articleTitle
      Then print 'value response --- ',articleTitle

  @debug
    Scenario: Create and Delete a new article
      #Given header Authorization = 'Token ' + sessionToken
      Given path '/articles/'
      And request {"article":{"tagList":[],"title":"Delete Article1","description":"Test Description","body":"Bla bla"}}
      When method Post
      Then status 200
      * def articleId = response.article.slug

      Given params { limit: 10, offset: 0}
      Given path '/articles'
      When method Get
      Then status 200
      And match response.articles[0].title == 'Delete Article1'

      #Given header Authorization = 'Token ' + sessionToken
      Given path '/articles',articleId
      When method Delete
      Then status 200

      Given params { limit: 10, offset: 0}
      Given path '/articles'
      When method Get
      Then status 200
      And match response.articles[0].title != 'Delete Article1'
