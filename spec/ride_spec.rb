require './lib/ride'

RSpec.describe Ride do
  let(:ride) {Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })}
  let(:ride2) {Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 5, excitement: :gentle })}
  let(:ride3) {Ride.new({ name: 'Roller Coaster', min_height: 54, admission_fee: 2, excitement: :thrilling })}
  let(:visitor1) {Visitor.new('Bruce', 54, '$10')}
  let(:visitor2) {Visitor.new('Tucker', 36, '$5')}
  let(:visitor3) {Visitor.new('Penny', 64, '$15')}

    it 'exists and has attributes' do
      expect(ride).to be_a(Ride)
      expect(ride.name).to eq("Carousel")
      expect(ride.min_height).to eq(24)
      expect(ride.admission_fee).to eq(1)
      expect(ride.excitement).to eq(:gentle)
      expect(ride.total_revenue).to eq(0)
    end

    it 'has a board rider method which adds riders and stores how many times theyve ridden' do
      expect(ride.rider_log).to eq({})

      visitor1.add_preferences(:gentle)
      visitor2.add_preferences(:gentle)
      ride.board_rider(visitor1)

      expect(ride.rider_log).to eq({visitor1 => 1})
      ride.board_rider(visitor2)
      ride.board_rider(visitor1)
      expect(ride.rider_log).to eq({visitor1 => 2, visitor2 => 1})

      expect(visitor1.spending_money).to eq(8)
      expect(visitor2.spending_money).to eq(4)
      expect(ride.total_revenue).to eq(3)
    end

    it 'works on multiple rides and riders will not ride if no preference' do
      visitor2.add_preferences(:thrilling)
      visitor3.add_preferences(:thrilling)
      ride3.board_rider(visitor1)

      expect(ride3.rider_log).to eq({})
      
      ride3.board_rider(visitor2)

      expect(ride3.rider_log).to eq({})

      ride3.board_rider(visitor3)

      expect(ride3.rider_log).to eq({visitor3 => 1})
      expect(ride3.total_revenue).to eq(2)
      expect(visitor2.spending_money).to eq(5)
      expect(visitor1.spending_money).to eq(10)
    end

    it 'has a method to total its rider count' do
      visitor1.add_preferences(:gentle)
      visitor2.add_preferences(:gentle)
      visitor2.add_preferences(:thrilling)
      visitor3.add_preferences(:thrilling)
      ride.board_rider(visitor1)

      expect(ride.total_count).to eq(1)

      3.times do ride.board_rider(visitor2) end
      expect(ride.total_count).to eq(4)

      ride3.board_rider(visitor3)
      expect(ride3.total_count).to eq(1)

      ride3.board_rider(visitor1)
      expect(ride3.total_count).to eq(1)
    end

end