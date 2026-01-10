hsh = {"name" => "Rakesh", "age" => 30, gender: "male"}

hsh.each do |key, value|
  puts "key is #{key} and its values is #{value}"
end

if hsh.has_key?("name")
  puts hsh["name"]
end

if hsh.has_key?("age")
  puts hsh["age"]
end

puts hsh.has_key?("name")

# symbols

sym = {:name => "Rakesh", :age => 30, :gender => "male", "name" => "Rakesh"}
sym.each do |key|
  puts "key is #{key[0]} and its values is #{key[1]}"
end
puts sym[:name] + " " + sym["name"]

a = 3
b = 1
def a(x)
  puts x
end
puts a+b
puts a(b)
puts a*b



BEGIN{
  puts 'Hello World'
}
END {
  puts 'End of the World'
}
# def add(a, b)
#   # return the result of adding a and b
#   a + b
# end
#
# def subtract(a, b)
#   # return the result of subtracting b from a
#   b - a
# end
#
# def multiply(a, b)
#   # return the result of multiplying a times b
#   a * b
# end
#
# def divide(a, b)
#   # return the result of dividing a by b
#   a / b
# end
#
# def remainder(a, b)
#   # return the remainder of dividing a by b using the modulo operator
#   a % b
# end
#
# def float_division(a, b)
#   # return the result of dividing a by b as a float, rather than an integer
#   a.to_f / b
# end
#
# def string_to_number(string)
#   # return the result of converting a string into an integer
#   string.to_i
# end
#
# def even?(number)
#   # return true if the number is even (hint: use integer's even? method)
#   number.even?
# end
#
# def odd?(number)
#   # return true if the number is odd (hint: use integer's odd? method)
#   number.odd?
# end
#
# puts float_division(11,11)
#
# # strings
# def concatenate_example(string)
#   # use concatenation to format the result to be "Classic <string>"
#   "Classic " + string
# end
#
# def concatenate(string)
#   # use concatenation to format the result to be "Hello <string>!"
#   "Hello " + string + "!"
# end
#
# def substrings(word)
#   # return the first 4 letters from the word using substrings
#   word[0,4]
# end
#
# def capitalize(word)
#   # capitalize the first letter of the word
#   word.capitalize
# end
#
# def uppercase(string)
#   # uppercase all letters in the string
#   string.upcase
# end
#
# def downcase(string)
#   # downcase all letters in the string
#   string.downcase
# end
#
# def empty_string(string)
#   # return true if the string is empty
#   string.empty?
# end
#
# def string_length(string)
#   # return the length of the string
#   string.length
# end
#
# def reverse(string)
#   # return the same string, with all of its characters reversed
# end
#
# def space_remover(string)
#   # remove all the spaces in the string using gsub
# end
