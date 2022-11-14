class Visitor
  attr_reader :name,
              :height,
              :spending_money,
              :preferences

  def initialize(name, height, money)
    @name           = name
    @height         = height
    @spending_money = money.delete(money[0]).to_i
    @preferences    = []
  end

  def add_preferences(preference)
    preferences.push(preference)
  end

  def tall_enough(height)
    @height >= height
  end
end
