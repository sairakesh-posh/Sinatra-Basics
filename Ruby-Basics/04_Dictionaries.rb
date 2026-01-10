# Dir.mkdir('Home')
#
# temp =  Dir.new("Home")

# @param {Integer[]} nums
# @param {Integer} target
# @return {Integer[]}
def two_sum(nums, target)
  ans = []
  sum = 0
  nums.each do |val|
    sum += val
  end
  sum
end

arr = Array.new(2,6)
puts two_sum(arr , 10)