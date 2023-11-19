-module(day1).
-import(string,[split/2]).
-import(lists,[concat/1]).
-import(io,[fwrite/1]).
-import(io,[write/1]).
-export([worlds_count/1]).
-export([count_to_ten/0]).
-export([print_result/1]).

% Write a function that uses recursion to return the number of words in a string.

worlds_count("") -> 0;

worlds_count(String) ->
  List = split(String, " "),
  [_|Tail] = List,
  concat(List),
  1 + worlds_count(Tail).

% Write a function that uses recursion to count to ten.

print_number(10) -> write(10);

print_number(Number) ->
  write(Number),
  fwrite("\n"),
  print_number(Number + 1).

count_to_ten() -> print_number(1).

% Write a function that uses matching to selectively print “success” or “error: message” given input of the form {error, Message} or success

print_result(success) -> fwrite("success");
print_result({error, Message}) -> fwrite("error: " ++ Message).
