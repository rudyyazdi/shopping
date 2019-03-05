require 'item'

class BasePricingRules
  class << self
    attr_reader :pricing, :policies

    def add_default_price(key, vlaue)
      @pricing ||= {}
      @pricing[key] = vlaue
    end

    def add_policy(ploicy)
      @policies ||= []
      @policies << ploicy
    end
  end

  def account_for(items)
    items.each { |i| i.default_price = pricing[i.key] }
    policies.each do |policy|
      items = policy.apply(items)
    end
    items.not_accounted_for.each { |i| i.price = i.default_price }
    items
  end

  private

  def pricing
    self.class.pricing
  end

  def policies
    self.class.policies
  end
end
