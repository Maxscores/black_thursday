require_relative './test_helper'
require './lib/sales_analyst'

class SalesAnalystTest < Minitest::Test
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

  def test_initialize_sales_analyst
    assert_instance_of SalesAnalyst, sa
  end
end
