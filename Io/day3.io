// Enhance the XML program to add spaces to show the indentation structure.

// Enhance the XML program to handle attributes: if the first argument is a map (use the curly brackets syntax), add attributes to the XML program. For example: book({"author": "Tate"}...) would print <book author="Tate">:

OperatorTable addAssignOperator(":", "atPutNumber")

curlyBrackets := method(
  r := Map clone
  call message arguments foreach(arg,
    r doMessage(arg)
    )
  r
)

Map atPutNumber := method(
  self atPut(
    call evalArgAt(0) asMutable removePrefix("\"") removeSuffix("\""),
    call evalArgAt(1))
)

Builder := Object clone
Builder padding := ""
Builder forward := method(
  firstArg := call message argAt(0)
  secondArg := call message argAt(1)
  args := nil
  name := call message name
  if(firstArg name == "curlyBrackets",
    args = list(call message argAt(1))
    key := doString(firstArg asString) keys at(0)
    value := doString(firstArg asString) values at(0)
    writeln("#{padding}<" interpolate, "#{name} #{key}=\"#{value}\"" interpolate, ">")
  )
  if(firstArg name != "curlyBrackets",
    args = call message arguments
    writeln("#{padding}<" interpolate, name, ">")
  )
  padding = "#{padding}  " interpolate
  args foreach(
    arg,
    content := self doMessage(arg)
    if(content type == "Sequence", writeln("#{padding}" interpolate, content))
  )
  padding = padding exSlice(2)
  writeln("#{padding}</" interpolate, name, ">")
)

Builder  ul(
  book({"author": "Tate"}, "Bruce"),
  startup({"author": "Parviz"}, ul(li("start"), li("end"))),
	li("Io"),
	li("Lua"),
	li("JavaScript"))

// Create a list syntax that uses brackets.

squareBrackets := method(
  call message arguments
)

list := [1, 2]
write(list, "\n")
write(list at(1), "\n")
list append(4)
write(list, "\n")
