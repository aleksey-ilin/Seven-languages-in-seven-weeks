# Print the string “Hello, world.”

puts 'hello, world'

# For the string “Hello, Ruby,” find the index of the word “Ruby.”

'Hello, Ruby'.index('Ruby')

# Print your name ten times.

# Version 1
x = 0
while x < 10
  x = x + 1
  puts 'Aleksey'
end

# Version 2
for i in (0..9)
  puts 'Aleksey'
end

# Print the string “This is sentence number 1,” where the number 1 changes from 1 to 10.

for i in (1..10)
  puts "This is sentence number #{i}"
end

# Bonus problem: If you’re feeling the need for a little more, write a program that picks a random number. Let a player guess the number, telling the player whether the guess is too low or too high. (Hint: rand(10) will generate a random number from 0 to 9, and gets will read a string from the keyboard that you can translate to an integer.)

right_answer = rand(10)
puts right_answer

user_answer = gets.to_i

while right_answer != user_answer
  puts "Right number is greater than #{user_answer}" if right_answer > user_answer
  puts "Right number is less than #{user_answer}" if right_answer < user_answer

  user_answer = gets.to_i
end

puts 'You guessed!'
