class BulkDiscountPolicy
  attr_reader :item_key, :minimum_quantity, :discount_price

  def initialize(item_key:, minimum_quantity:, discount_price:)
    @item_key = item_key
    @minimum_quantity = minimum_quantity
    @discount_price = discount_price
  end

  def apply(item_array)
    discount_items = item_array.select { |i| i.key == item_key }
    non_discount_items = item_array.reject { |i| i.key == item_key }
    if discount_items.size >= minimum_quantity
      discount_items = discount_items.each do |i|
        i.price = discount_price
        i.accounted_for!
      end
      discount_items + non_discount_items
    else
      item_array
    end
  end
end
