# Reverse the elements of a list.

reverse([Head|[]], [Head]).
reverse([Head|Tail], ReversedList) :- reverse(Tail, CurrentReversedList), append(CurrentReversedList, [Head], ReversedList).

# Find the smallest element of a list.

# Version 1

minNum(Num1, Num2, Num1) :- Num1 < Num2.
minNum(Num1, Num2, Num2) :- Num1 > Num2.
# Prolog has min function: A is min(nan, 1). It can be used instead of the minNum function.

minEl([Head|[]], Head).

minEl([Head1|[Head2|[]]], Head2) :- Head1 > Head2.
minEl([Head1|[Head2|[]]], Head1) :- Head1 =< Head2.

minEl([Head1|[Head2|Tail2]], Min) :- minNum(Head1, Head2, Min1), minEl(Tail2, Min2), minNum(Min1, Min2, Min).

# Version 2

minEl([Head|[]], Head).
minEl([Head|Tail], Min) :- minEl(Tail, Min1), minNum(Min1, Head, Min).

# minEl([2, 1, 3], What).
# minEl([6, 1, 5, 3], What).

# Sort the elements of a list.

sortList([Head1|[Head2|[]]], [Head2|[Head1|[]]]) :- Head1 > Head2.
sortList([Head1|[Head2|[]]], [Head1|[Head2|[]]]) :- Head1 =< Head2.

sortList(List, SortedList) :-
  minEl(List, Min),
  select(Min, List, ListWithoutMinEl),
  sortList(ListWithoutMinEl, SrotedListWithoutMinEl),
  append([Min], SrotedListWithoutMinEl, SortedList).

# sortList([2, 1], What).
# sortList([3, 1, 2], What).
# sortList([4, 2, 5, 1], What).
