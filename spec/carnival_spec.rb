require './lib/carnival'

RSpec.describe Carnival do
  let(:carnival) {Carnival.new("Super Sick Carnival", "1 Week")}
  let(:ride) {Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })}
  let(:ride2) {Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 5, excitement: :gentle })}
  let(:ride3) {Ride.new({ name: 'Roller Coaster', min_height: 54, admission_fee: 2, excitement: :thrilling })}
  let(:visitor1) {Visitor.new('Bruce', 54, '$10')}
  let(:visitor2) {Visitor.new('Tucker', 36, '$5')}
  let(:visitor3) {Visitor.new('Penny', 64, '$15')}

  it 'exists and has accessible attributes' do
    expect(carnival).to be_a(Carnival)
    expect(carnival.name).to eq("Super Sick Carnival")
    expect(carnival.duration).to eq("1 Week")
    expect(carnival.rides).to eq([])
  end

  it 'has a method to add rides' do
    carnival.add_ride(ride)
    expect(carnival.rides).to eq([ride])

    carnival.add_ride(ride2)
    expect(carnival.rides).to eq([ride, ride2])

    carnival.add_ride(ride3)
    expect(carnival.rides).to eq([ride, ride2, ride3])
  end

  it 'has a method to determine the most popular ride' do
    visitor1.add_preferences(:gentle)
    visitor2.add_preferences(:gentle)
    visitor3.add_preferences(:thrilling)
    carnival.add_ride(ride)
    carnival.add_ride(ride2)
    carnival.add_ride(ride3)

    5.times do ride3.board_rider(visitor3)
    end
    expect(carnival.most_popular).to eq(ride3)

    4.times do ride.board_rider(visitor1) 
    end
    2.times do ride.board_rider(visitor2)
    end
    expect(carnival.most_popular).to eq(ride)
  end

  it 'has a method to determine most profitable ride' do
    visitor1.add_preferences(:gentle)
    visitor2.add_preferences(:gentle)
    visitor3.add_preferences(:thrilling)
    carnival.add_ride(ride)
    carnival.add_ride(ride2)
    carnival.add_ride(ride3)

    2.times do ride3.board_rider(visitor3)
    end
    expect(carnival.most_profitable).to eq(ride3)

    5.times do ride.board_rider(visitor1)
    end
    expect(carnival.most_profitable).to eq(ride)
  end

  it 'has a method to calculate total revenue' do
    visitor1.add_preferences(:gentle)
    visitor2.add_preferences(:gentle)
    visitor3.add_preferences(:thrilling)
    carnival.add_ride(ride)
    carnival.add_ride(ride2)
    carnival.add_ride(ride3)

    2.times do ride3.board_rider(visitor3)
    end
    expect(carnival.total_revenue).to eq(4)

    5.times do ride.board_rider(visitor1)
    end
    expect(carnival.total_revenue).to eq(9)
  end

  it 'has a method to find the number of visitors' do
    visitor1.add_preferences(:gentle)
    visitor2.add_preferences(:gentle)
    visitor3.add_preferences(:thrilling)
    carnival.add_ride(ride)
    carnival.add_ride(ride2)
    carnival.add_ride(ride3)

    ride3.board_rider(visitor3)
    expect(carnival.number_of_visitors).to eq(1)

    2.times do ride.board_rider(visitor1)
    end
    expect(carnival.number_of_visitors).to eq(2)

    ride.board_rider(visitor2)
    expect(carnival.number_of_visitors).to eq(3)

    visitor1.add_preferences(:thrilling)
    ride3.board_rider(visitor1)
    expect(carnival.number_of_visitors).to eq(3)
  end

  xit 'has a method to find visitors favorite ride' do
    visitor1.add_preferences(:gentle)
    visitor1.add_preferences(:thrilling)
    visitor2.add_preferences(:gentle)
    visitor3.add_preferences(:thrilling)
    carnival.add_ride(ride)
    carnival.add_ride(ride2)
    carnival.add_ride(ride3)

    ride.board_rider(visitor1)
    expect(carnival.fav_rides).to eq({visitor1 => ride})

    ride.goard_rider(visitor2)
    expect(carnival.fav_rides).to eq({visitor1 => ride,
                                      visitor2 => ride})

    ride3.board_rider(visitor3)
    expect(carnival.fav_rides).to eq({visitor1 => ride,
                                      visitor2 => ride,
                                      visitor3 => ride3})

    2.times do ride3.board_rider(visitor1)
    end
    expect(carnival.fav_rides).to eq({visitor1 => ride3,
                                      visitor2 => ride,
                                      visitor3 => ride3})
  end


end