class Carnival
  attr_reader :name,
              :duration,
              :rides

  def initialize(name, duration)
    @name     = name
    @duration = duration
    @rides    = []
  end

  def add_ride(ride)
    rides.push(ride)
  end

  def most_popular
    rides.max_by do |ride|
      ride.total_count
    end
  end

  def most_profitable
    rides.max_by do |ride|
      ride.total_revenue
    end
  end

  def total_revenue
    rides.sum { |ride| ride.total_revenue }
  end


end