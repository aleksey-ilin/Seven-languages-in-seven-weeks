// Use foldLeft to compute the total size of a list of strings.

object Sum extends App {
	val list = List("one", "tow", "three")

	val result = list.foldLeft(0)((sum, value) => sum + value.size)
	println(result)
}
