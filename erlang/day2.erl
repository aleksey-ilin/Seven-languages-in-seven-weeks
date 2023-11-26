-module(day2).
-export([get_value_by_keyword/2]).
-export([get_shopping_list_with_total_price/1]).
-export([get_tic_tac_toe_result_1/1]).
-export([get_tic_tac_toe_result_2/1]).

% Consider a list of keyword-value tuples, such as [{erlang, "a functional language"}, {ruby, "an OO language"}]. Write a function that accepts the list and a keyword and returns the associated value for the keyword.

get_value_by_keyword(List, Keyword) ->
  [Result] = [Value || {Key, Value} <- List, Key == Keyword],
  Result.

% day2:get_value_by_keyword([{erlang, "a functional language"}, {ruby, "an OO language"}], ruby).

% Consider a shopping list that looks like [{item quantity price}, ...]. Write a list comprehension that builds a list of items of the form [{item total_price}, ...], where total_price is quantity times price.

get_shopping_list_with_total_price(Food) ->
  [{Item, Quantity * Price} || {Item, Quantity, Price} <- Food].
% day2:get_shopping_list_with_total_price([{apple, 2, 5}, {banana, 3, 7}, {orange, 5, 5}]).

% Bonus problem:
% Write a program that reads a tic-tac-toe board presented as a list or a tuple of size nine. Return the winner (x or o) if a winner has been determined, cat if there are no more possible moves, or no_winner if no player has won yet.

% Version 1

get_tic_tac_toe_result_1([Val, Val, Val, _, _, _, _, _, _]) when Val == x; Val == o -> Val;
get_tic_tac_toe_result_1([_, _, _, Val, Val, Val, _, _, _]) when Val == x; Val == o -> Val;
get_tic_tac_toe_result_1([_, _, _, _, _, _, Val, Val, Val]) when Val == x; Val == o -> Val;

get_tic_tac_toe_result_1([Val, _, _, Val, _, _, Val, _, _]) when Val == x; Val == o -> Val;
get_tic_tac_toe_result_1([_, Val, _, _, Val, _, _, Val, _]) when Val == x; Val == o -> Val;
get_tic_tac_toe_result_1([_, _, Val, _, _, Val, _, _, Val]) when Val == x; Val == o -> Val;

get_tic_tac_toe_result_1([Val, _, _, _, Val, _, _, _, Val]) when Val == x; Val == o -> Val;
get_tic_tac_toe_result_1([_, _, Val, _, Val, _, Val, _, _]) when Val == x; Val == o -> Val;

get_tic_tac_toe_result_1(Board) ->
  BoardHasEmptyValue = lists:all(fun(Val) -> (Val == x) or (Val == o) end, Board),
  if
    BoardHasEmptyValue -> no_winner;
    true -> cat
  end.

% winner x
% day2:get_tic_tac_toe_result_1([x, x, x, o, 1, o, o, 1, 1]).
% winner o
% day2:get_tic_tac_toe_result_1([o, 1, x, x, o, 1, x, 1, o]).
% cat
% day2:get_tic_tac_toe_result_1([o, 1, 1, 1, 1, 1, x, 1, 1]).
% no_winner
% day2:get_tic_tac_toe_result_1([x, x, o, o, o, x, x, x, o]).

% Version 2

is_more_possible_moves(true) -> no_winner;
is_more_possible_moves(false) -> cat.

get_tic_tac_toe_result_2([Val, Val, Val, _, _, _, _, _, _]) when Val == x; Val == o -> Val;
get_tic_tac_toe_result_2([_, _, _, Val, Val, Val, _, _, _]) when Val == x; Val == o -> Val;
get_tic_tac_toe_result_2([_, _, _, _, _, _, Val, Val, Val]) when Val == x; Val == o -> Val;

get_tic_tac_toe_result_2([Val, _, _, Val, _, _, Val, _, _]) when Val == x; Val == o -> Val;
get_tic_tac_toe_result_2([_, Val, _, _, Val, _, _, Val, _]) when Val == x; Val == o -> Val;
get_tic_tac_toe_result_2([_, _, Val, _, _, Val, _, _, Val]) when Val == x; Val == o -> Val;

get_tic_tac_toe_result_2([Val, _, _, _, Val, _, _, _, Val]) when Val == x; Val == o -> Val;
get_tic_tac_toe_result_2([_, _, Val, _, Val, _, Val, _, _]) when Val == x; Val == o -> Val;

get_tic_tac_toe_result_2(Board) ->
  BoardFull = lists:all(fun(Val) -> (Val == x) or (Val == o) end, Board),
  is_more_possible_moves(BoardFull).

% winner x
% day2:get_tic_tac_toe_result_2([x, x, x, o, 1, o, o, 1, 1]).
% winner o
% day2:get_tic_tac_toe_result_2([o, 1, x, x, o, 1, x, 1, o]).
% cat
% day2:get_tic_tac_toe_result_2([o, 1, 1, 1, 1, 1, x, 1, 1]).
% no_winner
% day2:get_tic_tac_toe_result_2([x, x, o, o, o, x, x, x, o]).
