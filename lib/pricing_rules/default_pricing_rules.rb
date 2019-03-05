require 'policies/free_item_policy'
require 'policies/bulk_discount_policy'

class DefaultPricingRules < BasePricingRules
  add_default_price Item::IPD, 549_99
  add_default_price Item::MBP, 1_399_99
  add_default_price Item::ATV, 109_50
  add_default_price Item::VGA, 30_00

  # after you buy two apple tvs you get the thrid one for free:
  add_policy FreeItemPolicy.new(
    bought_item_key: Item::ATV,
    bought_item_quantity: 2,
    free_item_key: Item::ATV,
  )

  # after you buy a MacBook Pro you get a free vga adapter:
  add_policy FreeItemPolicy.new(
    bought_item_key: Item::MBP,
    bought_item_quantity: 1,
    free_item_key: Item::VGA,
  )

  # the brand new Super iPad will have a bulk discounted applied, where the price will drop to $499.99 each, if someone buys more than 4
  add_policy BulkDiscountPolicy.new(
    item_key: Item::IPD,
    minimum_quantity: 4,
    discount_price: 499_99
  )
end
