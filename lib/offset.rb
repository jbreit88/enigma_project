class Offset

  attr_reader :date

  def initialize(date)
    @date = date
  end

  def square_date
    @date.to_i ** 2
  end


end
