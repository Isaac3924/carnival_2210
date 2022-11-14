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

  def number_of_visitors
    list_visitors.count
  end

  def list_visitors
    rides.flat_map do |ride|
      ride.rider_log.keys
    end.uniq
  end

  # def fav_rides
  #   Hash.new[list_visitors] = vis_favs
  # end

  # def vis_favs
  #   rides.max_by do |ride, rider|
  #     ride.rider_log[rider]
  #   end
  # end
end