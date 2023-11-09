ThisBuild / scalaVersion := "3.2.2"

val AkkaVersion = "2.8.5"

lazy val sizer = project
  .in(file("."))
  .settings(
    name := "Sizer",
    libraryDependencies ++= Seq(
      "com.typesafe.akka" %% "akka-actor" % AkkaVersion,
      "com.typesafe.akka" %% "akka-actor-typed" % AkkaVersion,
      "com.typesafe.akka" %% "akka-testkit" % AkkaVersion % Test,
      "ch.qos.logback" % "logback-classic" % "1.2.11",
      "net.ruippeixotog" %% "scala-scraper" % "3.1.0"
    )
  )

resolvers += "Akka library repository".at("https://repo.akka.io/maven")
