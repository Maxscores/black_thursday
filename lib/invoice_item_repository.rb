require_relative './invoice_item'
class InvoiceItemRepository

  attr_reader :invoice_items,
              :parent

  def initialize(invoice_items, parent)
    @parent = parent
    @invoice_items = invoice_items.reduce({}) do |result, invoice_item|
      key = invoice_item[:invoice_id].to_i
      result[key] = [] if !result[key]
      result[key] << InvoiceItem.new(invoice_item, self)
      result
    end
  end

  def all
    invoice_items.values.flatten
  end

  def find_by_id(invoice_item_id)
    invoice = invoice_items.select do |id, invoice|
      invoice.any? {|invoice_item| invoice_item.id == invoice_item_id.to_i}
    end.values.flatten
    invoice.find {|invoice_item| invoice_item.id == invoice_item_id.to_i}
  end

  def find_all_by_item_id(item_id)
    invoices = invoice_items.select do |id, invoice|
      invoice.any? {|invoice_item| invoice_item.item_id == item_id.to_i}
    end.values.flatten
    invoices.find_all {|invoice_item| invoice_item.item_id == item_id.to_i}
  end

  def find_all_by_invoice_id(invoice_id)
    return [] if invoice_items[invoice_id.to_i].nil?
    invoice_items[invoice_id.to_i]
  end

  def inspect
    "#<#{self.class} #{@invoice_items.size} rows>"
  end

  private

end
