require_relative './test_helper'
require 'bigdecimal'
require './lib/sales_analyst'

class ItemAnalystTest < Minitest::Test
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
  
  def test_it_can_determine_average_items_per_merchant
    assert_equal 1.4, sa.average_items_per_merchant
  end

  def test_it_can_determine_standard_deviation_items_per_merchant
    assert_equal 0.89, sa.average_items_per_merchant_standard_deviation
  end

  def test_determine_merchants_with_most_items
    result = sa.merchants_with_high_item_count

    assert_equal "Madewithgitterxx", result[0].name
  end

  def test_determines_average_price_for_merchants
    merchant_average_1 = sa.average_item_price_for_merchant(12334185)
    no_merchant_with_id = sa.average_item_price_for_merchant(123)

    assert_equal 12.83, merchant_average_1
    assert_nil no_merchant_with_id
  end

  def test_determines_average_average_price_per_merchants
    result = sa.average_average_price_per_merchant

    assert_equal BigDecimal(5457)/100, result
  end

  def test_it_can_determine_standard_deviation_items_price
    result = sa.standard_deviation_of_item_price

    assert_equal BigDecimal(5256)/100, result
  end

  def test_it_can_determine_the_golden_items
    result = sa.golden_items

    assert_equal 1, result.count
    assert_equal 'Custom Hand Made Miniature Bicycle', result[0].name
  end
end
