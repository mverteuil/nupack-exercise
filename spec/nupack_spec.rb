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

describe FlatMarkup do
  # Example project with $100.00, 1 worker and derp category
  example_project = ProjectPricer.new(100.00, 1, 'derp')

  describe '.check' do
    it 'returns true' do
      expect(described_class.check(example_project)).to be true
    end
  end

  describe '.apply' do
    it 'returns 5% of the base price' do
      expect(described_class.apply(example_project)).to eq(5.00)
    end
  end
end
