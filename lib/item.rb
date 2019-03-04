class Item
  CATALOG = {
    ipd: 'Super iPad',
    mbp: 'MacBook Pro',
    atv: 'Apple TV',
    vga: 'VGA adapter',
  }.freeze

  attr_reader :key

  def initialize(key)
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
end
