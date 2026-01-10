# num = gets.to_i
num = 1
puts num

if num > 10
  puts num
elsif num < 10
  puts 20
else
  puts 400
end

ans = case num
      when 10
        30
      when 20
        30
      when 30
        29
      else
        30
      end
puts ans

i = 3
while i > 0
  puts "i is #{i}"
  i -= 1;
end

for i in 6..10
  puts "i is " + i.to_s
end

5.times do |number|
  puts "Alternative fact number #{number}"
end


# redo and reset

temp=1
#
for i in 2..20
  if i==10 && temp==1
    puts "redo #{i}"
    temp=0
    redo
  end
  puts i
end

temp=1
#
20.times do |i|
  if i==10 && temp==1
    puts "redo #{i}"
    temp=0
    retry
  end
  puts i
end
