# val = gets.chomp
# print val
# print val
# puts val
# print val
#



# Ruby program to demonstrate the yield statement

# method
def shiv(a,b)

  # statement of the method to be executed
  puts "#{a + b}Inside Method!"

  # using yield statement
  yield(102,20)

  # statement of the method to be executed
  puts "Again Inside Method!"

  # using yield statement
  yield("","13")

end

# block
shiv(2, 2){|var1,var2| puts "#{var1+var2}Inside Block!"}