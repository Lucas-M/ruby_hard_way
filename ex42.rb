## Animal is-a object look at the extra credit
class Animal
end

## Dog is-a animal
class Dog < Animal

	def initialize(name)
		## dog has-a name
		@name = name
	end
end

## Cat is-a animal
class Cat < Animal

	def initialize(name)
		## Cat has-a name
		@name = name
	end
end

## Person is-a object
class Person

	def initialize(name)
		## person has-a name
		@name = name

		## Person has-a pet of some kind
		@pet = nil
	end

	attr_accessor :pet
end

# Employee is-a person
class Employee < Person

	def initailize(name, salary)
		## ?? hmm what is this strange magic
		super(name)
		## Employee has-a salary
		@salary = salary
	end

end

class Employee < Person

  def initialize(name, salary)
    ## ?? hmm what is this strange magic?
    super(name)
    ## ??
    @salary = salary
  end

end




## Fish is an object
class Fish
end

## salmon is-a Fish
class Salmon < Fish
end

## Halibut is-a Fish
class Halibut < Fish
end

## rover is-a dog
rover = Dog.new("Rover")
 
## satan is-a Cat
satan = Cat.new("Satan")

## mary is-a Person
mary = Person.new("Mary")

## mary has-a pet called satan
mary.pet = satan

## frank is a person with a salary of 120000
frank = Employee.new("Frank", 120000)

## frank has-a pet called rover
frank.pet = rover

## flipper is-a fish
flipper = Fish.new()

## crouse is-a salmon is-a fish
crouse = Salmon.new()

## harry is-a halibut is-a fish
harr = Halibut.new()

# ## Animal is-a object look at the extra credit
# class Animal
# end

# ## ??
# class Dog < Animal

#   def initialize(name)
#     ## ??
#     @name = name
#   end
# end

# ## ??
# class Cat < Animal

#   def initialize(name)
#     ## ??
#     @name = name
#   end
# end

## ??
# class Person

#   def initialize(name)
#     ## ??
#     @name = name

#     ## Person has-a pet of some kind
#     @pet = nil
#   end

#   attr_accessor :pet
# end

# ## ??
# class Employee < Person

#   def initialize(name, salary)
#     ## ?? hmm what is this strange magic?
#     super(name)
#     ## ??
#     @salary = salary
#   end

# end

# ## ??
# class Fish
# end

# ## ??
# class Salmon < Fish
# end

# ## ??
# class Halibut < Fish
# end


# ## rover is-a Dog
# rover = Dog.new("Rover")

# ## ??
# satan = Cat.new("Satan")

# ## ??
# mary = Person.new("Mary")

# ## ??
# mary.pet = satan

# ## ??
# frank = Employee.new("Frank", 120000)

# ## ??
# frank.pet = rover

# ## ??
# flipper = Fish.new()

# ## ??
# crouse = Salmon.new()

# ## ??
# harry = Halibut.new()