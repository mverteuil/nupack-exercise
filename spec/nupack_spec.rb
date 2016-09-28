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

    context 'with $12,456.95, 4 people and books' do
      pricer = described_class.new 12_456.95, 4, 'books'
      it 'returns $13,707.63' do
        expect(pricer.calculate).to eq(13_707.63)
      end
    end
  end
end

describe FlatMarkup do
  # Example project with $100.00, 1 worker and derp material
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

describe WorkerMarkup do
  # Example project with $100.00, 1 worker and derp material
  project_with_worker = ProjectPricer.new(100.00, 1, 'derp')
  # Example project with $100.00, no workers and derp material
  project_without_worker = ProjectPricer.new(100.00, 0, 'derp')

  describe '.check' do
    context 'has at least one worker' do 
      it 'returns true' do
        expect(described_class.check(project_with_worker)).to be true
      end
    end

    context 'has no workers' do 
      it 'returns false' do
        expect(described_class.check(project_without_worker)).to be false
      end
    end
  end

  describe '.apply' do
    it 'charges 1.2% of the base price per worker' do
      expect(described_class.apply(project_with_worker)).to eq(1.20)
    end
  end
end


describe MaterialMarkup do
  # Example project with $100.00, 1 worker and derp material
  project_without_match = ProjectPricer.new(100.00, 1, 'derp')
  # Example project with $100.00, 1 worker and drugs material
  project_with_drugs = ProjectPricer.new(100.00, 1, 'drugs')
  # Example project with $100.00, 1 worker and electronics material
  project_with_electronics = ProjectPricer.new(100.00, 1, 'electronics')
  # Example project with $100.00, 1 worker and food material
  project_with_food = ProjectPricer.new(100.00, 1, 'food')

  describe '.check' do
    context 'project has drugs' do 
      it 'returns true' do
        expect(described_class.check(project_with_drugs)).to be true
      end
    end

    context 'project has food' do 
      it 'returns true' do
        expect(described_class.check(project_with_food)).to be true
      end
    end

    context 'project has electronics' do 
      it 'returns true' do
        expect(described_class.check(project_with_electronics)).to be true
      end
    end

    context 'has a material that does not match' do 
      it 'returns false' do
        expect(described_class.check(project_without_match)).to be false
      end
    end
  end

  describe '.apply' do
    context 'project has drugs' do 
      it 'charges 7.5% of the base price' do
        expect(described_class.apply(project_with_drugs)).to eq(7.50)
      end
    end

    context 'project has food' do 
      it 'charges 13% of the base price' do
        expect(described_class.apply(project_with_food)).to eq(13.00)
      end
    end

    context 'project has electronics' do 
      it 'charges 2% of the base price' do
        expect(described_class.apply(project_with_electronics)).to eq(2.00)
      end
    end
  end
end
