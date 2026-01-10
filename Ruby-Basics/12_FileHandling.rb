# https://www.geeksforgeeks.org/file-handling-in-ruby/
# create file

fileobject = File.new("sample.txt", "w+")

file2=File.new("sample2.txt", "w+")

fileobject.syswrite("i am learning ruby in geeks for geeks")

fileobject.close();


fileobjet= File.open("sample.txt","r+")

# read mentiones character then it will print upto the entered values
#
print(fileobjet.sysread(3))

puts(fileobjet.sysread(4))
# read entire content from a file
#
puts(fileobjet.read())
#
# readlines function return as a array
#
puts(fileobjet.readlines())


file2.write("i learnt file handling in ruby language")

file2.close()

puts File.rename("sample2.txt", "newsample.txt")

puts File.delete("newsample.txt")

puts File.readable?("sample.txt")

puts File.writable?("newsample.txt")

puts File.file?("newsample.txt")

puts File.file?("sample.txt")

