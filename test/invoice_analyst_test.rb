require_relative './test_helper'
require './lib/invoice_analyst'

class InvoiceAnalystTest < Minitest::Test
  attr_reader :se,
              :sa

  def setup
    @se = SalesEngine.from_csv({
      :items => "./test/fixture/item_truncated.csv",
      :merchants => './test/fixture/merchants_truncated.csv',
      :invoices => './test/fixture/invoice_truncated.csv'}
    )
    @sa = SalesAnalyst.new(se)
  end

  def test_average_invoices_per_merchant
    result = sa.average_invoices_per_merchant

    assert_equal 1.8, result
  end

  def test_top_merchants_by_invoice_count
    result = sa.top_merchants_by_invoice_count

    assert_equal 1, result.count
  end

  def test_bottom_merchants_by_invoice_count
    result = sa.bottom_merchants_by_invoice_count

    assert_equal 0, result.count
  end

  def test_top_days_by_invoice_count
    result = sa.top_days_by_invoice_count

    assert_equal ['Saturday'], result
  end

  def test_invoice_count_by_day
    result = sa.invoice_count_by_day

    assert_equal 4, result.count
  end

  def test_standard_deviation_of_invoices_per_day
    result = sa.standard_deviation_of_invoices_per_day

    assert_equal 1.41, result
  end

  def test_precentage_of_invoice_status
    pending = sa.invoice_status(:pending)
    shipped = sa.invoice_status(:shipped)
    returned = sa.invoice_status(:returned)

    assert_equal 0.11, pending
    assert_equal 0.67, shipped
    assert_equal 0.22, returned
  end
end
