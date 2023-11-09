// Take the sizer application and add a message to count the number of links on the page.
// Bonus problem: Make the sizer follow the links on a given page, and load them as well. For example, a sizer for “google.com” would compute the size for Google and all of the pages it links to.

import scala.io._
import scala.util.{Try, Success, Failure}
import akka.actor.typed.scaladsl.Behaviors
import akka.actor.typed.scaladsl.LoggerOps
import akka.actor.typed.scaladsl.AskPattern._
import akka.actor.typed.{ ActorRef, ActorSystem, Behavior, SpawnProtocol, Props }
import scala.concurrent.{ Future }
import akka.util.Timeout
import concurrent.duration.DurationInt
import scala.concurrent.Await
import net.ruippeixotog.scalascraper.browser.JsoupBrowser
import net.ruippeixotog.scalascraper.dsl.DSL._
import net.ruippeixotog.scalascraper.dsl.DSL.Extract._
import net.ruippeixotog.scalascraper.dsl.DSL.Parse._
import net.ruippeixotog.scalascraper.model._

object Main extends App {
  object Page {
    sealed trait Protocol

    case class PageSize(url: String) extends Protocol
    case class GetPageSize(replyto: ActorRef[Long]) extends Protocol
    case class LinksCount(url: String) extends Protocol
    case class GetLinksCount(replyto: ActorRef[Long]) extends Protocol

    def behavior: Behavior[Protocol] = Behaviors.setup { ctx =>
      var size: Long = 0
      var linksCount: Long = 0

      Behaviors.receiveMessage {
        case PageSize(url) =>
          size = PageLoader.getPageSize(url)
          Behaviors.same
        case GetPageSize(replyto) =>
          replyto ! size
          Behaviors.same
        case LinksCount(url) =>
          linksCount = PageLoader.getLinksCount(url)
          Behaviors.same
        case GetLinksCount(replyto) =>
          replyto ! linksCount
          Behaviors.same
      }
    }
  }

  object PageLoader {
    def getPageSize(url : String) = {
      val source = Try(Source.fromURL(url).mkString.length)
      source match {
        case Success(result) =>
          result
        case Failure(error) =>
          0
      }
    }
    def getLinksCount(url: String) = {
      val browser = JsoupBrowser()
      val doc = browser.get(url)
      (doc >> elementList("a")).length
    }
  }

  def getPageSizeSequentially() = {
    val start = System.nanoTime
    val urls = List(
      "http://www.amazon.com/", "http://www.google.com/", "https://web.dev/", "https://epicreact.dev/", "https://react.dev/", "https://surma.dev/", "https://archlinux.org/", "https://habr.com/ru/articles/", "https://webref.ru/", "https://ru.hexlet.io/",
      "http://www.amazon.com/", "http://www.google.com/", "https://web.dev/", "https://epicreact.dev/", "https://react.dev/", "https://surma.dev/", "https://archlinux.org/", "https://habr.com/ru/articles/", "https://webref.ru/", "https://ru.hexlet.io/",
      "http://www.amazon.com/", "http://www.google.com/", "https://web.dev/", "https://epicreact.dev/", "https://react.dev/", "https://surma.dev/", "https://archlinux.org/", "https://habr.com/ru/articles/", "https://webref.ru/", "https://ru.hexlet.io/",
    )

    for(url <- urls) {
      println("Size for " + url + ": " + PageLoader.getPageSize(url))
    }

    val end = System.nanoTime
    println("Method took " + (end - start)/1000000000.0 + " seconds.")
  }

  def getPageSizeConcurrently() = {
    val start = System.nanoTime
    val urls = List(
      "http://www.amazon.com/", "http://www.google.com/", "https://web.dev/", "https://epicreact.dev/", "https://react.dev/", "https://surma.dev/", "https://archlinux.org/", "https://habr.com/ru/articles/", "https://webref.ru/", "https://ru.hexlet.io/",
      "http://www.amazon.com/", "http://www.google.com/", "https://web.dev/", "https://epicreact.dev/", "https://react.dev/", "https://surma.dev/", "https://archlinux.org/", "https://habr.com/ru/articles/", "https://webref.ru/", "https://ru.hexlet.io/",
      "http://www.amazon.com/", "http://www.google.com/", "https://web.dev/", "https://epicreact.dev/", "https://react.dev/", "https://surma.dev/", "https://archlinux.org/", "https://habr.com/ru/articles/", "https://webref.ru/", "https://ru.hexlet.io/",
    )
    implicit val system: ActorSystem[SpawnProtocol.Command] = ActorSystem(SpawnProtocol(), "root")
    implicit val ec: scala.concurrent.ExecutionContext = system.executionContext
    implicit val timeout: Timeout = Timeout(15.seconds)
    var results: Array[Future[Long]] = Array()

    for(url <- urls) {
      val pageFuture: Future[ActorRef[Page.Protocol]] =
        system.ask(SpawnProtocol.Spawn(Page.behavior, "page", Props.empty, _))
      pageFuture.foreach{ page =>
        page ! Page.PageSize(url)
        val result: Future[Long] = page ? Page.GetPageSize.apply
        println("Size for " + url + ": " + Await.result(result, 10.seconds))
        results :+= result

        if(results.length == urls.length) {
          val end = System.nanoTime
          println("Method took " + (end - start)/1000000000.0 + " seconds.")
        }
      }
    }
  }

  def getPageLinksCountConcurrently() = {
    val urls = List("https://webref.ru/", "https://ru.hexlet.io/", "https://surma.dev/")
    implicit val system: ActorSystem[SpawnProtocol.Command] = ActorSystem(SpawnProtocol(), "root")
    implicit val ec: scala.concurrent.ExecutionContext = system.executionContext
    implicit val timeout: Timeout = Timeout(15.seconds)

    for(url <- urls) {
      val pageFuture: Future[ActorRef[Page.Protocol]] =
        system.ask(SpawnProtocol.Spawn(Page.behavior, "page", Props.empty, _))
      pageFuture.foreach{ page =>
        page ! Page.LinksCount(url)
        val linksCount: Future[Long] = page ? Page.GetLinksCount.apply
        println("Site " + url + " has " + Await.result(linksCount, 10.second) + " links.")
      }
    }
  }

  def getPageInnerLinksLengthConcurrently() = {
    val urls = List("https://webref.ru/", "https://ru.hexlet.io/", "https://surma.dev/")

    implicit val system: ActorSystem[SpawnProtocol.Command] = ActorSystem(SpawnProtocol(), "root")
    implicit val ec: scala.concurrent.ExecutionContext = system.executionContext
    implicit val timeout: Timeout = Timeout(15.seconds)
    val browser = JsoupBrowser()

    for(url <- urls) {
      val doc = browser.get(url)
      val hrefList = Try((doc >> elementList("a") >> attrs("href")))
      hrefList match {
        case Success(result) =>
          Success(result)
        case Failure(error) =>
          List()
      }

      if(hrefList.isSuccess) {
        for(hrefContainer <- hrefList.get) {
          val href = hrefContainer.toList(0)
          if (href contains "http") {
            val pageFuture: Future[ActorRef[Page.Protocol]] =
              system.ask(SpawnProtocol.Spawn(Page.behavior, "page", Props.empty, _))
            pageFuture.foreach{ page =>
              page ! Page.PageSize(href)
              val result: Future[Long] = page ? Page.GetPageSize.apply
              println("Size for " + href + ": " + Await.result(result, 10.seconds) + " (parent url is " + url + ")")
            }
          }
        }
      }
    }
  }

  println("!!! Sequential run !!!")
  getPageSizeSequentially()

  println("!!! Concurrent run !!!")
  getPageSizeConcurrently()

  println("!!! getPageLinksCountConcurrently !!!")
  getPageLinksCountConcurrently()

  println("!!! getPageInnerLinksLengthConcurrently !!!")
  getPageInnerLinksLengthConcurrently()
}
