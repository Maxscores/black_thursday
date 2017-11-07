require_relative './customer'

class CustomerRepository
  attr_reader :customers,
              :parent

  def initialize(customers, parent)
    @parent = parent
    @customers = customers.reduce({}) do |result, customer|
      result[customer[:id].to_i] = Customer.new(customer, self)
      result
    end
  end

  def all
    customers.values
  end

  def find_by_id(id)
    customers[id]
  end

  def find_all_by_first_name(name)
    customers.select do |customer_id, customer|
      customer.first_name.downcase.include?(name.downcase)
    end.values
  end

  def find_all_by_last_name(name)
    customers.select do |customer_id, customer|
      customer.last_name.downcase.include?(name.downcase)
    end.values
  end

  def find_merchant_by_customer_id(customer_id)
    parent.find_merchant_by_customer_id(customer_id)
  end

  def find_all_invoices_by_customer_id(customer_id)
    parent.find_all_invoices_by_customer_id(customer_id)
  end

  def inspect
    "#<#{self.class} #{@customers.size} rows>"
  end
end
