class BulkDiscountPolicy
  attr_reader :item_key, :minimum_quantity, :discount_price

  def initialize(item_key:, minimum_quantity:, discount_price:)
    @item_key = item_key
    @minimum_quantity = minimum_quantity
    @discount_price = discount_price
  end

  def apply(item_array)
    discount_items = item_array.not_accounted_for.select { |i| i.key == item_key }
    if discount_items.size >= minimum_quantity
      discount_items.each { |i| i.price = discount_price }
    end
  end
end
