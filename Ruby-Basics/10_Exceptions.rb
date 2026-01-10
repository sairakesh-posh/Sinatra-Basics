#!/usr/bin/ruby
puts "Raised Exception:\n"
begin
  a = 30
  b = 0

  # raises the exception only if the condition is true
  raise ZeroDivisionError.new 'b should not be 0' if b == 0
  print "a/b = ", (1 + 2) * (a / b)
rescue ZeroDivisionError => e
  puts e.message

  # prints the error stack, but a raised exception has zero stack
  puts e.backtrace
end

puts "\nRuntime Exception:\n"
begin
  a = 30
  b = 0
  x=(1 + 2) * (a / b)

  # raises the exception only if the condition is true
  #raise ZeroDivisionError.new 'b should not be 0' if b == 0
  print "a/b = ", (1 + 2) * (a / b)
rescue ZeroDivisionError => e

  # prints the message=>(divided by 0)
  # from ZeroDivisionError class
  puts e.message
  puts e.backtrace
end