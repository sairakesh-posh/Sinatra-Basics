# frozen_string_literal: true
# @param {Integer[]} height
# @return {Integer}'

def trap(*height)
  sum = 0
  height.each_with_index do |val, ind|
    l_max = height[0]
    r_max = height[-1]
    for i in 0..ind-1
      if l_max < height[i]
        l_max = height[i]
      end
    end
    for i in ind+1..height.size-1
      if r_max < height[i]
        r_max = height[i]
      end
    end
    min = l_max < r_max ? l_max : r_max
    if min > height[ind]
      sum += min - height[ind]
    else
      next
    end
  end
  sum
end

def trapping(height)
  sum = 0
  l_ind = 0
  r_ind = height.size-1
  height.each_with_index do |val, ind|

  end
end
puts trap(0,1,0,2,1,0,1,3,2,1,2,1)