require_relative './test_helper'
require 'bigdecimal'
require './lib/sales_analyst'

class InvoiceAnalystTest < Minitest::Test
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

  def test_average_invoices_per_merchant
    result = sa.average_invoices_per_merchant

    assert_equal 6.8, result
  end

  def test_top_merchants_by_invoice_count
    result = sa.top_merchants_by_invoice_count

    assert_equal 0, result.count
  end

  def test_bottom_merchants_by_invoice_count
    result = sa.bottom_merchants_by_invoice_count

    assert_equal 0, result.count
  end

  def test_top_days_by_invoice_count
    result = sa.top_days_by_invoice_count

    assert_equal ['Wednesday'], result
  end

  def test_precentage_of_invoice_status
    pending = sa.invoice_status(:pending)
    shipped = sa.invoice_status(:shipped)
    returned = sa.invoice_status(:returned)

    assert_equal BigDecimal(882)/100, pending
    assert_equal BigDecimal(8529)/100, shipped
    assert_equal BigDecimal(588)/100, returned
  end
end
