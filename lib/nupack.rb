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
    # Tier 1 markups are applied to the base price
    tier_1_markups = [FlatMarkup]
    tier_1_markup_values = tier_1_markups.map { |markup| markup.check(self) ? markup.apply(self) : 0 }
    @base_price += tier_1_markup_values.reduce(:+)

    # Tier 2 markups are applied after Tier 2 markups have been included in the base price
    tier_2_markups = [WorkerMarkup, MaterialMarkup]
    tier_2_markup_values = tier_2_markups.map { |markup| markup.check(self) ? markup.apply(self) : 0 }
    final_price = @base_price + tier_2_markup_values.reduce(:+)
    (final_price * 100.0).round / 100.0
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
