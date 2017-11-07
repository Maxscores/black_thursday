require_relative './invoice_item'
class InvoiceItemRepository

  attr_reader :invoice_items,
              :parent

  def initialize(invoice_items, parent)
    @parent = parent
    @invoice_items = invoice_items.reduce({}) do |result, invoice_item|
      result[invoice_item[:id].to_i] = InvoiceItem.new(invoice_item, self)
      result
    end
  end

  def all
    invoice_items
  end

  def find_by_id(id)
    all[id]
  end

  def find_all_by_item_id(item_id)
    all.select do |id, invoice_item|
      invoice_item.item_id.to_i == item_id.to_i
    end.values
  end

  def find_all_by_invoice_id(invoice_id)
    all.select do |id, invoice_item|
      invoice_item.invoice_id.to_i == invoice_id.to_i
    end.values
  end

  def inspect
    "#<#{self.class} #{@invoice_items.size} rows>"
  end

  private

end
