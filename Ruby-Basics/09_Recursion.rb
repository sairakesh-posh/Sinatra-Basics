def fibonacci(n)
  if n<2
    return n
  end
  fibonacci(n - 1) + fibonacci(n - 2)
end

puts fibonacci(3)

# Ruby program to illustrate instance variables using constructor

class Geek
  attr_accessor :geekName
  # constructor
  def initialize()

    # instance variable
    @geekName = "R2J"
  end

  # defining method displayDetails
  def displayDetails()
    puts "Geek name is #@geekName"
  end

end

# creating an object of class Geeks
obj=Geek.new()

# calling the instance methods of class Geeks
obj.displayDetails()
puts obj.geekName