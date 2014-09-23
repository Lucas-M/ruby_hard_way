class Parent

	def implicit()
		puts "PARANT implicit()"
	end
end

class Child < Parent
	end

	dad = Parent.new()
	son = Child.new()

	dad.implicit()
	son.implicit()