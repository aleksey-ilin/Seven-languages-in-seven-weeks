// Write a game that will take a tic-tac-toe board with X, O, and blank characters and detect the winner or whether there is a tie or no winner yet. Use classes where appropriate.
// Bonus problem: Let two players play tic-tac-toe.

val printBoard = (board: Array[Array[String]]) => {
	println("Board:")
	println(board(0)(0) + "|" + board(0)(1) + "|" + board(0)(2))
	println("-----")
	println(board(1)(0) + "|" + board(1)(1) + "|" + board(1)(2))
	println("-----")
	println(board(2)(0) + "|" + board(2)(1) + "|" + board(2)(2))
}

val checkFinishGame = (board: Array[Array[String]]) => {
	var isGameFinished = false

	val row1 = board(0)
	val row2 = board(1)
	val row3 = board(2)

	if(
		row1.forall(item => item == "X") ||
		row2.forall(item => item == "X") ||
		row3.forall(item => item == "X")
	) {
		println("First player win!")
		isGameFinished = true
	}

	if(
		row1.forall(item => item == "O") ||
		row2.forall(item => item == "O") ||
		row3.forall(item => item == "O")
) {
		println("Second player win!")
		isGameFinished = true
	}

	val col1 = Array(board(0)(0), board(1)(0), board(2)(0))
	val col2 = Array(board(0)(1), board(1)(1), board(2)(1))
	val col3 = Array(board(0)(2), board(1)(2), board(2)(2))

	if(
		col1.forall(item => item == "X") ||
		col2.forall(item => item == "X") ||
		col3.forall(item => item == "X")
	) {
		println("First player win!")
		isGameFinished = true
	}

	if(
		col1.forall(item => item == "O") ||
		col2.forall(item => item == "O") ||
		col3.forall(item => item == "O")
	) {
		println("Second player win!")
		isGameFinished = true
	}

	val diag1 = Array(board(0)(0), board(1)(1), board(2)(2))
	val diag2 = Array(board(2)(0), board(1)(1), board(0)(2))

	if(
		diag1.forall(item => item == "X") ||
		diag2.forall(item => item == "X")
	) {
		println("First player win!")
		isGameFinished = true
	}

	if(
		diag1.forall(item => item == "O") ||
		diag2.forall(item => item == "O")
	) {
		println("Second player win!")
		isGameFinished = true
	}

	if(
		!(row1 contains (" ")) &&
		!(row2 contains (" ")) &&
		!(row3 contains (" ")) &&
		!isGameFinished
	) {
		println("Tie")
		isGameFinished = true
	}

	if(isGameFinished) {
		println("Finish game")
	}

	isGameFinished
}

val makeMove = (player: String, board: Array[Array[String]]) => {
	if(player == "first") {
		println("The first player moves. You play with 'X'.")
		println("Input line and column. For example 21. 2 - row, 1 - column:")

		val firstPlayerInput = scala.io.StdIn.readInt()
		val firstPlayerInputRow = firstPlayerInput / 10
		val firstPlayerInputCol = firstPlayerInput % 10

		board(firstPlayerInputRow)(firstPlayerInputCol) = "X"

		printBoard(board)
	}

	if(player == "second") {
		println("The second player moves. You play with 'O'.")
		println("Input line and column. For example 21. 2 - row, 1 - column:")

		val secondPlayerInput = scala.io.StdIn.readInt()
		val secondPlayerInputRow = secondPlayerInput / 10
		val secondPlayerInputCol = secondPlayerInput % 10

		board(secondPlayerInputRow)(secondPlayerInputCol) = "O"

		printBoard(board)
	}
}

object TicTacToe extends App {
	println("Start")

	var row1 = Array(" ", " ", " ")
	var row2 = Array(" ", " ", " ")
	var row3 = Array(" ", " ", " ")

	var board = Array(row1, row2, row3)

	var currentPlayer = "first"

	printBoard(board)

	while(!checkFinishGame(board)) {
		makeMove(currentPlayer, board)

		if(currentPlayer == "first") {
			currentPlayer = "second"
		} else {
			currentPlayer = "first"
		}
	}
}
