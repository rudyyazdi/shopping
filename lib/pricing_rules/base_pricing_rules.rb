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
      # this loop ensures that the policy is applied to the items as many times as necessary
      while
        accounted_for_size = items.accounted_for.size
        policy.apply(items)
        break if accounted_for_size == items.accounted_for.size
      end
    end
    items.not_accounted_for.each { |i| i.price = i.default_price }
  end

  private

  def pricing
    self.class.pricing
  end

  def policies
    self.class.policies
  end
end
