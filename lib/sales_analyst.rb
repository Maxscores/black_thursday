require 'bigdecimal'
require_relative './sales_engine'
require_relative './invoice_analyst'
require_relative './merchant_analyst'

class SalesAnalyst
  include InvoiceAnalyst
  include MerchantAnalyst

  attr_reader :se

  def initialize(sales_engine)
    @se = sales_engine
  end
end
