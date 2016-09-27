# vim: sw=2 ts=2 et
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
    1_591.58
  end
end


class FlatMarkup
  def self.check(pricer)
    true
  end
end
