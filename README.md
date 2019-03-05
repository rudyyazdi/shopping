## assumptions:

- One VGA adapter needs to be scanned per MacBook Pro otherwise there is no discount.
- All the prices are in cents for simplicity.

## notes:

- The stipulated pricing rules are implemented in `DefaultPricingRules`. In case the pricing rules change, another subclass of BasePricingRules can be created and populated with the new default prices and policies.
- Policies are also extensible in a way that new policies can be added the just need to implement the `apply` method that takes a `item_array` and modifies the pricings of the items.
- The following test scenarios are implemented as integration test in `spec/lib/checkout_spec.rb`:
  - SKUs Scanned: atv, atv, atv, vga Total expected: $249.00
  - SKUs Scanned: atv, ipd, ipd, atv, ipd, ipd, ipd Total expected: $2718.95
  - SKUs Scanned: mbp, vga, ipd Total expected: $1949.98
