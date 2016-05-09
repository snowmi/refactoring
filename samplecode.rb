# encodling:utf-8

# ----- DefaultPriceモジュール -----
module DefaultPrice
  def frequent_renter_points(days_rented)
    1
  end
end

# ----- Movieクラス ------
class Movie
  REGULAR = 0
  NEW_RELEASE = 1
  CHILDRENS = 2

  attr_reader :title
  attr_reader :price_code

  def price_code=(value)
    @price_code = value
    @price = case price_code
    when REGULAR; RegularPrice.new
    when NEW_RELEASE; NewReleasePrice.new
    when CHILDRENS; ChildrensPrice.new
    end
  end

  def initialize(title, the_price_code)
    @title, self.price_code = title, the_price_code
  end

  def charge(days_rented)
    @price.charge(days_rented)
  end

  def frequent_renter_points(days_rented)
    @price.frequent_renter_points(days_rented)
  end
end


# ----- RegularPriceクラス -----
class RegularPrice
  include DefaultPrice
  def charge(days_rented)
    result = 2
    result += (days_rented - 2) * 1.5 if days_rented > 2
    result
  end
end

# ----- NewReleasePriceクラス -----
class NewReleasePrice
  def charge(days_rented)
    days_rented * 3
  end

  def frequent_renter_points(days_rented)
    days_rented > 1 ? 2 : 1
  end
end

# ----- ChildrensPrice -----
class ChildrensPrice
  include DefaultPrice
  def charge(days_rented)
    result = 1.5
    result += (days_rented - 3) * 1.5 if days_rented > 3
    result
  end
end

# ----- Rentalクラス -----
class Rental
  attr_reader :movie, :days_rented

  def initialize(movie, days_rented)
    @movie, @days_rented = movie, days_rented
  end

  # 金額を計算
  def charge
    movie.charge(days_rented)
  end

  def frequent_renter_points
    movie.frequent_renter_points(days_rented)
  end

end

# ----- Customerクラス -----
class Customer
  attr_reader :name

  def initialize(name)
    @name = name
    @rentals = []
  end

  def add_rental(arg)
    @rentals << arg
  end

  def statement
    result = "Rental Record for #{@name}\n"
    @rentals.each do |element|
      # このレンタルの料金を表示
      result += "\t" + element.movie.title + "\t" + element.charge.to_s + "\n"
    end

    # フッター行を追加
    result += "Amount owed is #{total_charge}\n"
    result += "You earned #{total_frequent_renter_points} frequent renter points"
    result
  end

  def html_statement
    result = "<h1>Rentals for <em>#{@name}</em></h1><p>\n"
    @rentals.each do |element|
      result += "\t" + element.movie.title + ": " + element.charge.to_s + "<br>\n"
    end

    result += "<p>You owe <em>#{total_charge}</em><p>\n"
    result += "On this rental you earned" + "<em>#{total_frequent_renter_points}</em> " + "frequent renter points<p>"
    result
  end
  private

  def total_charge
    @rentals.inject(0) { |sum, rental| sum + rental.charge }
  end

  def total_frequent_renter_points
    @rentals.inject(0) { |sum, rental| sum + rental.frequent_renter_points}
  end
end
