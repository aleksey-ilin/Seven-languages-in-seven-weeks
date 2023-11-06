// A Fibonacci sequence starts with two 1s. Each subsequent number is the sum of the two numbers that came before: 1, 1, 2, 3, 5, 8, 13, 21, and so on. Write a program to find the nth Fibonacci number. fib(1) is 1, and fib(4) is 3. As a bonus, solve the problem with recursion and with loops.

// Version 1
Object fib := method(num, one := 1; two := 1; result := 1; while(num > 2, result = one + two; one = two; two = result; num = num - 1); result)

// Version 2
Object fib := method(num, if(num <= 1, return num, return fib(num - 1) + fib(num - 2)))

// How would you change / to return 0 if the denominator is zero?

originDivider := Number getSlot("/");
Number / = method(num, if(num == 0, 0, self originDivider(num)))

// Write a program to add up all of the numbers in a two-dimensional array.

Object sum := method(list, result := 0; list foreach(list, list foreach(num, result = result + num)));

// Add a slot called myAverage to a list that computes the average of all the numbers in a list. What happens if there are no numbers in a list? (Bonus: Raise an Io exception if any item in the list is not a number.)

List myAverage := method( sum := 0; size := self size; self foreach(item, if(item proto type == "Number", sum = sum + item, Exception raise("Item is not a number"))); sum / size; );

// Write a prototype for a two-dimensional list. The dim(x, y) method should allocate a list of y lists that are x elements long. set(x, y, value) should set a value, and get(x, y) should return that value.

TwoDimensionalList := List clone

TwoDimensionalList dim := method(x, y,
  for(i, 1, y, self append(list()));
  self foreach(item, for(i, 1, x, item append(nil)));
)

TwoDimensionalList set := method(x, y, value, self foreach(index, item, if(index == x, item atPut(y, value))))

TwoDimensionalList get := method(x, y, self foreach(index, item, if(index == x, return item at(y))))

twoDimensionalList := TwoDimensionalList clone
write(twoDimensionalList, "\n")
twoDimensionalList dim(3, 3)
write(twoDimensionalList, "\n")
twoDimensionalList set(2, 2, "a")
write(twoDimensionalList, "\n")
twoDimensionalList get(2, 2)

twoDimensionalList set(0, 0, 1)
twoDimensionalList set(0, 1, 2)
twoDimensionalList set(0, 2, 3)
twoDimensionalList set(1, 0, 4)
twoDimensionalList set(1, 1, 5)
twoDimensionalList set(1, 2, 6)
twoDimensionalList set(2, 0, 7)
twoDimensionalList set(2, 1, 8)
twoDimensionalList set(2, 2, 9)

write(twoDimensionalList, "\n")

// Bonus: Write a transpose method so that (new_matrix get(y, x)) == matrix get(x, y) on the original list.

TwoDimensionalList transpose := method(
  matrixSize := self size;
  buffer := TwoDimensionalList clone;
  buffer dim(matrixSize ,matrixSize);
  self foreach(
    indexInnerList,
    innerList,
    innerList foreach(
      indexItem,
      value,
      buffer set(indexItem, indexInnerList, value)
    )
  )

  self foreach(
    indexInnerList,
    innerList,
    innerList foreach(
      indexItem,
      value,
      self set(indexInnerList, indexItem, buffer at(indexInnerList) at(indexItem))
    )
  )
)

twoDimensionalList := TwoDimensionalList clone
write(twoDimensionalList, "\n")
twoDimensionalList transpose
write(twoDimensionalList, "\n")

// Write the matrix to a file, and read a matrix from a file.

matrix := TwoDimensionalList clone
matrix dim(2, 2)

file := File with("matrix.txt")
file remove
file openForUpdating
file write(matrix asString)
file close

// Write a program that gives you ten tries to guess a random number from 1–100. If you would like, give a hint of “hotter” or “colder” after the first guess.

Object guessARandomNumber := method(
  write("You should guess a random number from 0 to 100. You have 10 tries.", "\n", "Input your number", "\n")
  randomNumber := (Object uniqueId asNumber / 10) asString exSlice(0, 2) asNumber
  prevDiff := nil

  for(tries, 1, 10,
    userNumber := File standardInput readLine asNumber
    currentDiff := randomNumber - userNumber
    if(userNumber == randomNumber, write("It is right answer!"); return, write("It is a wrong answer.", "\n"))
    if(tries > 1, if(currentDiff abs > prevDiff abs, write("colder", "\n"), write("hotter", "\n")))
    prevDiff = currentDiff
  )
  write("Attempts are over. You didn't guess a number", "\n")
)
