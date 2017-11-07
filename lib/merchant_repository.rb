require_relative './merchant'
class MerchantRepository

  attr_reader :merchants,
              :parent

  def initialize(merchants, parent)
    @parent = parent
    @merchants = merchants.reduce({}) do |result, merchant|
      result[merchant[:id].to_i] = Merchant.new(merchant, self)
      result
    end
  end

  def all
    merchants
  end

  def find_by_id(id)
    all[id]
  end

  def find_by_name(name)
    all.select do |id, merchant|
      merchant.name.downcase == name.downcase.to_s
    end.values[0]
  end

  def find_all_by_name(word)
    all.select do |id, merchant|
      merchant.name.downcase.include?(word.downcase)
    end.values
  end

  def find_all_customers_by_merchant_id(id)
    parent.find_all_customers_by_merchant_id(id)
  end

  def find_all_items_by_merchant_id(id)
    parent.find_items_by_merchant_id(id)
  end

  def find_all_invoices_by_merchant_id(id)
    parent.find_all_invoices_by_merchant_id(id)
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end
