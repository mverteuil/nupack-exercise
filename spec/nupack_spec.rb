# vim: sw=2 ts=2 et
require 'nupack'

describe ProjectPricer do
  describe '#calculate' do
    pricer = described_class.new
    context 'with $1,299.99, 3 people and food' do
      it 'returns $1,591.58' do
        expect(pricer.calculate(1_299.99, 3, 'food')).to eq(1_591.58) 
      end
    end
  end
end
