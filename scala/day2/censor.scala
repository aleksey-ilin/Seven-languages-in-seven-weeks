// Write a Censor trait with a method that will replace the curse words Shoot and Darn with Pucky and Beans alternatives. Use a map to store the curse words and their alternatives.
// Load the curse words and alternatives from a file.

import scala.collection.mutable.HashMap

object App extends Censor {
  def main(args: Array[String]): Unit = {
    val str = "One Shoot Two Darn Three"
    val newStr = replaceCurseWord(str)
    println(newStr)
  }
}

trait Censor {
  def replaceCurseWord = (str: String) => {
    // val words = Map("Shoot" -> "Pucky", "Darn" -> "Beans") - part 1

    val words = new HashMap[String, String]

    val source = scala.io.Source.fromFile("words.txt")
    val lines = try source.mkString.trim() finally source.close()

    lines.split("\n").foreach((line) => {
      val wordsFromLine = line.split(" ")
      words += wordsFromLine(0) -> wordsFromLine(1)
    })

    str
      .split(" ")
      .map((word) => if (word == "Shoot" || word == "Darn") words(word) else word)
      .mkString(" ")
  }
}
