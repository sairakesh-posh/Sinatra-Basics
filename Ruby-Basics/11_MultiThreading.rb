# Ruby program to illustrate
# creation of threads

#!/usr/bin/ruby

# first method
def Geeks1
  a = 0
  while a <= 3

    puts "Geeks1: #{a}"

    # to pause the execution of the current
    # thread for the specified time
    sleep(1)

    # incrementing the value of a
    a = a + 1
  end

end

# Second method
def Geeks2
  b = 0

  while b <= 3

    puts "Geeks2: #{b}"

    # to pause the execution of the current
    # thread for the specified time
    sleep(0.5)

    # incrementing the value of a
    b = b + 1
  end

end

# creating thread for first method
x = Thread.new{Geeks1()}

# creating thread for second method
y= Thread.new{Geeks2()}

# using Thread.join method to
# wait for the first thread
# to finish
x.join

# using Thread.join method to
# wait for the second thread
# to finish
y.join


puts "Process End"



arr1=["hello","world"]

# used join printing in one line

puts arr1.join(" :")