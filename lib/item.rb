class Item
  IPD = :ipd
  MBP = :mbp
  ATV = :atv
  VGA = :vga

  CATALOG = {
    IPD => 'Super iPad',
    MBP => 'MacBook Pro',
    ATV => 'Apple TV',
    VGA => 'VGA adapter',
  }.freeze

  attr_accessor :price, :default_price
  attr_reader :key

  def initialize(key)
    unless CATALOG.key?(key)
      raise ArgumentError, "item should be one the following types: #{CATALOG.keys}"
    end

    @key = key
  end

  def name
    CATALOG[key]
  end

  def accounted_for?
    !@price.nil?
  end

  def ==(other)
    other.is_a?(self.class) && key == other.key
  end
end
