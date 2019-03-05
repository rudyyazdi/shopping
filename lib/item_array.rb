class ItemArray < Array
  # this method is very similar to `Array#-` the only difference is that it takes an
  # array of keys for comparison.
  # [item_1, item_2, item_3].eject([:mbp, :mbp])
  def eject(keys)
    eject_recursive(self, keys)
  end

  # this method is very similar to `Array#&` the only difference is that it takes an
  # array of keys for comparison.
  # [item_1, item_2, item_3].intersection([:mbp, :mbp])
  def intersection(keys)
    intersection_recursive(self, keys)
  end

  # whether or not all the keys exist in the given collection.
  def include_all?(keys)
    eject(keys).size == size - keys.size
  end

  def accounted_for
    self.class.new(select(&:accounted_for?))
  end

  def not_accounted_for
    self.class.new(reject(&:accounted_for?))
  end

  private

  def eject_recursive(items, keys)
    head, *tail = items
    if keys.empty? || items.empty?
      items
    elsif keys.include?(head.key)
      keys_dup = keys.dup
      keys_dup.delete_at(keys_dup.index(head.key))
      eject_recursive(tail, keys_dup)
    else
      [head, *eject_recursive(tail, keys)]
    end
  end

  def intersection_recursive(items, keys)
    head, *tail = items
    if keys.empty? || items.empty?
      []
    elsif keys.include?(head.key)
      keys_dup = keys.dup
      keys_dup.delete_at(keys_dup.index(head.key))
      [head, *intersection_recursive(tail, keys_dup)]
    else
      intersection_recursive(tail, keys)
    end
  end
end
