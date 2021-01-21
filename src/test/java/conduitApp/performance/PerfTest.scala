package conduitApp.performance

import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._
import scala.concurrent.duration.DurationInt

import conduitApp.performance.helpers.CreateDynamicallyTokens

class PerfTest extends Simulation {

  CreateDynamicallyTokens.createAccessTokens()

  val protocol = karateProtocol(
    "/api/articles/{articleId}" -> Nil
  )

  protocol.nameResolver = (req, ctx) => req.getHeader("karate-name")

  val createArticle = scenario("Create and delete article")
    .feed(csv("articles.csv").random)
    .feed(Iterator.continually(Map("token" -> CreateDynamicallyTokens.getNextToken)))
    .exec(karateFeature("classpath:conduitApp/performance/createArticle.feature"))

  setUp(
    createArticle.inject(
      atOnceUsers(1),
      nothingFor(4.seconds),
      constantUsersPerSec(1) during(3.seconds),
      constantUsersPerSec(2) during(10.seconds),
      rampUsersPerSec(2) to 10 during (20.seconds),
      nothingFor(5.seconds),
      constantUsersPerSec(1) during(5.seconds)
    ).protocols(protocol)
  )

}