# this one is like your scripts with ARGV

def print_two(*args)
	arg1, arg2 = args
	puts "arg1: #{arg1}, arg2: #{arg2}"
end

# ok, that *args is actuall pointless, we can just do this
def print_two_again(arg1, arg2)
	puts "arg1: #{arg1}, arg2: #{arg2}"
end

# this just takes onke argument
def print_one(arg1)
	puts "arg1: #{arg1}"
end

# this one takes no arguments
def print_none()
    puts "I got nothin'."
end

print_two("Tom", "Mac")
print_two_again("Tom", "Mac")
print_one("First!")
print_none()