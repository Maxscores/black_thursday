require_relative './item'

class ItemRepository
  attr_reader :items,
              :parent

  def initialize(items, parent)
    @parent = parent
    @items = items.reduce({}) do |result, item|
      result[item[:id].to_i] = Item.new(item, self)
      result
    end
  end

  def all
    items.values
  end

  def find_by_id(id)
    items[id]
  end

  def find_by_name(name)
    items.select do |id, item|
      item.name.downcase == name.downcase
    end.values[0]
  end

  def find_all_with_description(phrase)
    items.select do |id, item|
      item.description.downcase.include?(phrase.downcase)
    end.values
  end

  def find_all_by_price(price)
    items.select do |id, item|
      item.unit_price == price
    end.values
  end

  def find_all_by_price_in_range(range)
    items.select do |id, item|
      range.include?(item.unit_price)
    end.values
  end

  def find_all_by_merchant_id(merchant_id)
    items.select do |id, item|
      item.merchant_id.to_s == merchant_id.to_s
    end.values
  end

  def find_merchant_by_id(merchant_id)
    parent.find_merchant_by_id(merchant_id)
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end
end
