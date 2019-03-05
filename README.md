## assumptions:

- one VGA adapter needs to be scanned per MacBook Pro otherwise there is no discount.
- all the prices are in cents for simplicity

## notes:

- the stipulated pricing rules are implemented in `DefaultPricingRules`. In case the pricing rules change, another subclass of BasePricingRules can be created and populated with the new default prices and policies.
- Policies are also extensible in a way that new policies can be added the just need to implement the `apply` method that takes a `item_array` and modifies the pricings of the items.
- The mentioned test scenarios are implemented as integration test in `spec/lib/checkout_spec.rb`
