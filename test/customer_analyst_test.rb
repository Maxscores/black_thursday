require_relative './test_helper'
require 'bigdecimal'
require './lib/sales_analyst'

class CustomerAnalystTest < Minitest::Test
  attr_reader :se,
              :sa

  def setup
    @se = SalesEngine.from_csv({
      :items => "./test/fixture/item_truncated.csv",
      :merchants => './test/fixture/merchants_truncated.csv',
      :invoices => './test/fixture/invoice_truncated.csv',
      :customers => './test/fixture/customer_truncated.csv',
      :invoice_items => './test/fixture/invoice_item_truncated.csv',
      :transactions => './test/fixture/transactions_truncated.csv'
    })
    @sa = SalesAnalyst.new(se)
  end

  def test_customer_analyst_top_buyers
    two = sa.top_buyers(2)
    twenty = sa.top_buyers

    assert_instance_of Customer, two.first
    assert_instance_of Customer, two.last
    assert_equal 2, two.count
    assert_equal 6, twenty.count
  end

  def test_top_merchant_for_customer
    merchant_1 = sa.top_merchant_for_customer(297)
    merchant_2 = sa.top_merchant_for_customer(413)
    no_customer_with_id = sa.top_merchant_for_customer(99999)

    assert_equal 'Madewithgitterxx', merchant_1.name
    assert_equal 'Madewithgitterxx', merchant_2.name
    assert_nil no_customer_with_id
  end

  def test_one_time_buyers
    one_time_buyers = sa.one_time_buyers

    assert_instance_of Customer, one_time_buyers.first
    assert_equal 14, one_time_buyers.count
    assert_equal 1, one_time_buyers.first.fully_paid_invoices.length
  end

  def test_one_time_buyers_top_items
    top_item = sa.one_time_buyers_top_items

    assert_equal 1, top_item.length
    assert_equal [263395721], [top_item.first.id]
    assert_instance_of Item, top_item.first
  end

  def test_items_bought_in_year
    items = sa.items_bought_in_year(297, 2014)
    no_items_for_year = sa.items_bought_in_year(297, 2019)
    no_customer_with_id = sa.items_bought_in_year(99999, 2019)

    assert_equal 1, items.count
    assert_instance_of Item, items.first
    assert_equal 263511690, items.first.id
    assert_equal 'Adidas Klaus Fischer Cordoba Fußballschuh', items.first.name
    assert_equal 0, no_items_for_year.count
    assert_equal 0, no_customer_with_id.count
  end

  def test_highest_volume_items
    items = sa.highest_volume_items(297)
    no_customer_with_id = sa.highest_volume_items(99999)

    assert_equal 1, items.count
    assert_equal 263395721, items.first.id
    assert_nil no_customer_with_id
  end

  def test_customers_with_unpaid_invoices
    customers = sa.customers_with_unpaid_invoices

    assert_equal 5, customers.count
    assert_equal 297, customers.first.id
  end

  def test_best_invoice_by_revenue
    invoice = sa.best_invoice_by_revenue

    assert_equal 1495, invoice.id
    assert_equal 15620.53, invoice.total
  end

  def test_best_invoice_by_quantity
    invoice = sa.best_invoice_by_quantity
    quantity = sa.invoice_quantity(invoice)

    assert_equal 1495, invoice.id
    assert_equal 29, quantity
  end
end
