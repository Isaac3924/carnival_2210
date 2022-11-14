class Ride
  attr_reader :name,
              :min_height,
              :admission_fee,
              :excitement,
              :total_revenue,
              :rider_log

  def initialize(input)
    @name           = input[:name]
    @min_height     = input[:min_height]
    @admission_fee  = input[:admission_fee]
    @excitement     = input[:excitement]
    @total_revenue  = 0
    @rider_log      = {}
  end

  def board_rider(rider)
    if check_height_and_prefs(rider) == false
      return
    elsif  rider_log.include?(rider)
      rider_log[rider] += 1
    else 
      rider_log[rider] = 1
    end
    rider.spending_money -= admission_fee
    @total_revenue += admission_fee
  end

  def check_height_and_prefs(rider)
    rider.tall_enough(@min_height) && rider.preferences.include?(@excitement)
  end

  def total_count
    rider_log.values.sum
  end
        
end
