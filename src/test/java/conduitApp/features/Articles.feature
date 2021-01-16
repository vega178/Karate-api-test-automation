
@smoke @parallel=false
Feature: Articles

  Background: Define URL
      Given url baseUrl
      * def articleBodyData = read('classpath:conduitApp/bodyParameters/newArticlesBodyParameters.json')
      * def dataGenerator = Java.type('helpers.DataGenerator')
      * set articleBodyData[0].article.title = dataGenerator.getRandomArticleValues().title
      * set articleBodyData[0].article.description = dataGenerator.getRandomArticleValues().description
      * set articleBodyData[0].article.body = dataGenerator.getRandomArticleValues().body
      #* def loginService = callonce read('classpath:helpers/login.feature')
      #* def loginService = callonce read('classpath:helpers/login.feature') {"email": "estebanvegapatio@gmail.com","password": "Ab1234567!"}
      #* def sessionToken = loginService.sessionToken

  @debug
    Scenario: Create a new article
      #Given header Authorization = 'Token ' + sessionToken
      Given path '/articles/'
      And request articleBodyData[0].article
      When method Post
      Then status 200
      * def testArticleTitle = call read('HomePage.feature@get_articles_test_1')
      * def articleTitle = testArticleTitle.articleTitle
      And match response.article.title == articleBodyData[0].article.title

  @debug
    Scenario: Create and Delete a new article
      #Given header Authorization = 'Token ' + sessionToken
      Given path '/articles/'
      And request articleBodyData[0].article
      When method Post
      Then status 200
      * def articleId = response.article.slug

      Given params { limit: 10, offset: 0}
      Given path '/articles'
      When method Get
      Then status 200
      And match response.articles[0].title == articleBodyData[0].article.title

      #Given header Authorization = 'Token ' + sessionToken
      Given path '/articles',articleId
      When method Delete
      Then status 200

      Given params { limit: 10, offset: 0}
      Given path '/articles'
      When method Get
      Then status 200
      And match response.articles[0].title != articleBodyData[0].article.title
