class First
  public
  def print_1
    puts "Hello 1"
  end
  protected
  def print_2
    puts "Hello 2"
  end
  private
  def print_3
    puts "Hello 3"
  end
end

class Second < First
  def print_4
    puts "Hello 4"
  end
end

obj1 = First.new
obj2 = Second.new

p "h"
puts "h"




# leetcode - valid parenthesis

# @param {String} s
# @return {Boolean}


def is_valid(s)
  stack = []
  s.chars.each do |c|
    if c == "[" || c == "{" || c == "("
      stack.push(c)
    elsif c == "}" || c == ")" || c == "]"
      last = stack.pop
      case c
      when "]"
        if last == "["
          next
        else
          return false
        end
      when "}"
        if last == "{"
          next
        else
          return false
        end
      when ")"
        if last == "("
          next
        else
          return false
        end
      else
        return false
      end
    end
  end
  stack.empty? ? true : false
end

puts is_valid("()[]{[")