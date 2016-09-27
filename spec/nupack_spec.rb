# vim: sw=2 ts=2 et
require 'nupack'

describe ProjectPricer do
  describe '#calculate' do
    context 'with $1,299.99, 3 people and food' do
      pricer = described_class.new 1_299.99, 3, 'food'
      it 'returns $1,591.58' do
        expect(pricer.calculate).to eq(1_591.58) 
      end
    end

    context 'with $5,432.00, 1 person and drugs' do
      pricer = described_class.new 5_432.00, 1, 'drugs'
      it 'returns $6,199.81' do
        expect(pricer.calculate).to eq(6_199.81)
      end
    end
  end
end
