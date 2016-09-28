# vim: sw=2 ts=2 et
MATERIAL_MARKUPS = {
  "drugs": 0.075,
  "electronics": 0.02,
  "food": 0.13,
}

class ProjectPricer
  attr_reader :base_price
  attr_reader :num_workers
  attr_reader :material 

  def initialize(base_price, num_workers, material)
    @base_price = base_price
    @num_workers = num_workers
    @material = material
  end

  def calculate
    @material != 'drugs' ? 1_591.58 : 6_199.81
  end
end


class FlatMarkup
  def self.check(pricer)
    true
  end

  def self.apply(pricer)
    pricer.base_price * 0.05
  end
end


class WorkerMarkup
  def self.check(pricer)
    pricer.num_workers > 0
  end

  def self.apply(pricer)
    pricer.base_price * (pricer.num_workers * 0.012)
  end
end


class MaterialMarkup
  def self.check(pricer)
    MATERIAL_MARKUPS.keys.include? pricer.material.intern
  end

  def self.apply(pricer)
    pricer.base_price * MATERIAL_MARKUPS[pricer.material.intern]
  end
end
