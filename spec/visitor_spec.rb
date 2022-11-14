require './lib/visitor'

RSpec.describe Visitor do
  let(:visitor) {Visitor.new('Bruce', 54, '$10')}
  let(:visitor2) {Visitor.new('Tucker', 36, '$5')}
  let(:visitor3) {Visitor.new('Penny', 64, '$15')}

  it 'exists and has attributes' do
    expect(visitor).to be_a(Visitor)
    expect(visitor.name).to eq("Bruce")
    expect(visitor.height).to eq(54)
    expect(visitor.spending_money).to eq(10)
    expect(visitor.preferences).to eq([])
  end

  it 'has a method to add preferences' do
    visitor.add_preferences(:gentle)
    expect(visitor.preferences).to eq([:gentle])

    visitor.add_preferences(:water)
    expect(visitor.preferences).to eq([:gentle, :water])
  end

  it 'has a method to check if the visitor meets a height requirement' do
    expect(visitor.tall_enough(54)).to be true
    expect(visitor2.tall_enough(54)).to be false
    expect(visitor3.tall_enough(54)).to be true
    expect(visitor.tall_enough(64)).to be false

  end

end