# # frozen_string_literal: true
#
# name = 'Rakesh'
# puts name.frozen?
#
# name = name.upcase
# puts name
# puts name.frozen?
#
# name.downcase!
# puts name
#
# str = '    name     rakesh    '
# puts str.strip
#
# num = gets.to_i
# puts num
#
# if num > 10
#   puts num
# elsif num < 10
#   puts 20
# else
#   puts 400
# end
#
# ans = case num
#       when 10
#         30
#       when 20
#         30
#       when 30
#         29
#       else
#         30
#       end
# puts ans




=begin
instance variables and class instance variables
class Test
  @cust_test = "rak"
  def initialize(id, name, addr)
    @cust_id = id
    @cust_name = name
    @cust_addr = addr
  end
  def display_details()
    puts "Customer id #@cust_id"
    puts "Customer name #@cust_name"
    puts "Customer addr #@cust_addr"
  end
  def getter()
    self.class.instance_variable_get(:@cust_test)
  end
end

obj1 = Test.new(10,'rakesh', 'here')
obj2 = Test.new(11, "ram" , "home")
obj1.display_details
puts obj1.instance_variable_get(:@cust_id)
puts Test.instance_variable_set(:@cust_test, 100)
puts obj2.instance_variable_get(:@cust_test)
puts obj1.getter
=end




# global variable
# num1 = 10
# $num2 = 20
#
# puts num1
# puts $num2
#
# class Class1
#   def display
#     $num2 += 1
#     $num2
#   end
# end
# temp = Class1.new
# puts temp.display
#
# class Class2
#   def display
#     $num2
#   end
# end
# temp2 = Class2.new
# puts temp2.display




