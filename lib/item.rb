class Item
  CATALOG = {
    ipd: 'Super iPad',
    mbp: 'MacBook Pro',
    atv: 'Apple TV',
    vga: 'VGA adapter',
  }.freeze

  attr_accessor :price, :default_price
  attr_reader :key

  def initialize(key)
    unless CATALOG.key?(key)
      raise ArgumentError, "item should be one the following types: #{CATALOG.keys}"
    end

    @key = key
    @accounted_for = false
  end

  def name
    CATALOG[key]
  end

  def accounted_for?
    @accounted_for
  end

  def accounted_for!
    @accounted_for = true
  end

  def ==(other)
    other.is_a?(self.class) && key == other.key
  end
end
