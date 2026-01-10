# # Ruby program of Operator Overloading
# class Comparable_operator
#   attr_accessor :name
#
#   # Initialize the name
#   def initialize(name)
#     @name=name
#   end
#
# end
# puts Comparable_operator.new('ZDave') > Comparable_operator.new('Rakesh')


# @param {Integer} x
# @return {Boolean}

hsh = {}
str = ""
str.chars.each do |c|
  if hsh.include?(c)
    hsh[c] += 1
  else
    hsh[c] = 1
  end
end

hsh.each do |k, v|
  puts "key is #{k} and value is #{v}"
end

str = "Hello guys, this is rakesh"
puts str.delete(' ')

arr = [1,2,35,6,72,6,1]
for i in 0..(arr.length-1)/2
  temp = arr[i]
  arr[i] = arr[arr.length-i-1]
  arr[arr.length-i-1] = temp
end
arr.each do |i|
  puts i
end

puts
#remove duplicates
arr = arr.uniq
puts arr