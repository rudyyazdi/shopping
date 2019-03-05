class FreeItemPolicy
  attr_reader :bought_item_key, :bought_item_quantity, :free_item_key

  def initialize(bought_item_key:, bought_item_quantity:, free_item_key:)
    @bought_item_key = bought_item_key
    @bought_item_quantity = bought_item_quantity
    @free_item_key = free_item_key
  end

  def apply(item_array)
    if item_array.include_all?(required_item_keys)
      bought_items = item_array.intersection(bought_item_keys)
      # bought items take the default price
      bought_items = bought_items.each { |i| i.price = i.default_price }
      free_items = item_array.not_accounted_for.intersection(free_item_keys)
      # free item is free!
      free_items = free_items.each { |i| i.price = 0 }
      rest_of_the_items = item_array.not_accounted_for
      ItemArray.new([bought_items, free_items, rest_of_the_items].flatten)
    else
      item_array
    end
  end

  private

  def bought_item_keys
    [bought_item_key] * bought_item_quantity
  end

  def free_item_keys
    [free_item_key]
  end

  # the item keys that need to be inside the basket for the discount policy to be applicable.
  def required_item_keys
    bought_item_keys + free_item_keys
  end
end
