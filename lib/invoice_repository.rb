require_relative './invoice'

class InvoiceRepository
  attr_reader :invoices, :parent

  def initialize(invoices, parent)
    @parent = parent
    @invoices = invoices.reduce({}) do |result, invoice|
      result[invoice[:id].to_i] = Invoice.new(invoice, self)
      result
    end
  end

  def all
    invoices.values
  end

  def find_by_id(id)
    invoices[id]
  end

  def find_all_by_customer_id(customer_id)
    invoices.select do |id, invoice|
      invoice.customer_id == customer_id
    end.values
  end

  def find_all_by_merchant_id(merchant_id)
    invoices.select do |id, invoice|
      invoice.merchant_id == merchant_id
    end.values
  end

  def find_all_by_status(status)
    invoices.select do |id, invoice|
      invoice.status == status.downcase.to_sym
    end.values
  end

  def find_merchant_by_id(merchant_id)
    parent.find_merchant_by_id(merchant_id)
  end

  def find_items_by_invoice_id(invoice_id)
    parent.find_items_by_invoice_id(invoice_id)
  end

  def find_transaction_by_invoice_id(invoice_id)
    parent.find_transaction_by_invoice_id(invoice_id)
  end

  def find_customer_by_id(customer_id)
    parent.find_customer_by_id(customer_id)
  end

  def find_invoice_items_by_invoice_id(invoice_id)
    parent.find_invoice_items_by_invoice_id(invoice_id)
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end
end
