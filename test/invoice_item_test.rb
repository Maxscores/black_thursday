require_relative 'test_helper'
require './lib/invoice_item'

class InvoiceItemRepositoryTest < Minitest::Test
  attr_reader :invocie_item_1, :invoice_item_2

  def setup
    parent = mock("parent")
    @invocie_item_1 = InvoiceItem.new({
      :id => "1",
      :item_id => "223454178",
      :invoice_id => "1",
      :quantity => "7",
      :unit_price => "400",
      :created_at => "2012-03-27",
      :updated_at => "2012-04-27"
      }, parent)
    @invoice_item_2 = InvoiceItem.new({
      :id => "3",
      :item_id => "22454278",
      :invoice_id => "2",
      :quantity => "4",
      :unit_price => "10001",
      :created_at => '2016-01-11 09:34:06 UTC',
      :updated_at => '2007-06-04 21:35:10 UTC'
    }, parent)
  end

  def test_can_be_initialized_with_attributes
    assert_equal 1, invocie_item_1.id
    assert_equal 223454178, invocie_item_1.item_id
    assert_equal 1, invocie_item_1.invoice_id
    assert_equal 7, invocie_item_1.quantity
    assert_equal 4, invocie_item_1.unit_price
    assert_equal Time.parse("2012-03-27"), invocie_item_1.created_at
    assert_equal Time.parse("2012-04-27"), invocie_item_1.updated_at
    assert_instance_of InvoiceItem, invocie_item_1
  end

  def test_can_be_initialized_with_other_attributes
    assert_equal 3, invoice_item_2.id
    assert_equal 22454278, invoice_item_2.item_id
    assert_equal 2, invoice_item_2.invoice_id
    assert_equal 4, invoice_item_2.quantity
    assert_equal 100.01, invoice_item_2.unit_price
    assert_equal Time.parse("2016-01-11 09:34:06 UTC"), invoice_item_2.created_at
    assert_equal Time.parse("2007-06-04 21:35:10 UTC"), invoice_item_2.updated_at
    assert_instance_of InvoiceItem, invoice_item_2
  end

  def test_unit_price_to_dollars
    assert_equal 4.00, invocie_item_1.unit_price_to_dollars
    assert_equal 100.01, invoice_item_2.unit_price_to_dollars
  end
end
