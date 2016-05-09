require "./samplecode"

et = Movie.new("ET", Movie::REGULAR)
jaws = Movie.new("Jaws", Movie::NEW_RELEASE)
anpanman = Movie.new("Anpanman", Movie::CHILDRENS)

first_rental = Rental.new(jaws, 3)
second_rental = Rental.new(et, 5)
third_rental = Rental.new(anpanman, 2)

snowmi = Customer.new("Snowmi")

snowmi.add_rental(first_rental)
puts "----- Only first_rental -----"
puts snowmi.statement

snowmi.add_rental(second_rental)
puts "----- Add second_rental -----"
puts snowmi.statement

snowmi.add_rental(third_rental)
puts "----- Add third_rental -----"
puts snowmi.statement

puts "html section"
puts snowmi.html_statement
