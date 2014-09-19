# Assigns the arg passed when the file is executed
filename = ARGV.first
# Opens a local file and calls it txt
txt = open(filename)
# Confirms the user input
puts "Here's your file #{filename}:"
# Outputs the contents of the file
print txt.read
# Outputs a label
print "Type the filename again: "
# Gets user input
file_again = $stdin.gets.chomp
# Opens a local file and calls it txt_again
txt_again = open(file_again)
# Outputs the contents of the file
print txt_again.read
txt_again.close()