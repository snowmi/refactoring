require "./samplecode"

et = Movie.new("ET", 0)
jaws = Movie.new("Jaws", 1)
anpanman = Movie.new("Anpanman", 2)

first_rental = Rental.new(jaws, 3)
second_rental = Rental.new(et, 5)
third_rental = Rental.new(anpanman, 2)

takahiro = Customer.new("Takahiro")
takahiro.add_rental(first_rental)
takahiro.statement
