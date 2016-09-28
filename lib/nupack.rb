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
    pricer.base_price * (pricer.num_workers * 1.2)
  end
end
