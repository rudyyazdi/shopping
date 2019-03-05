class Checkout
  attr_reader :pricing_rule, :items

  def initialize(pricing_rule)
    @pricing_rule = pricing_rule
    @items = ItemArray.new
  end

  def scan(item)
    @items.push(item)
  end

  def total
    pricing_rule.account_for(items)
    items.sum(&:price)
  end
end
