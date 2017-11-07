require_relative './transaction'

class TransactionRepository
  attr_reader :transactions,
              :parent

  def initialize(transactions, parent)
    @parent = parent
    @transactions = transactions.reduce({}) do |result, trans|
      result[trans[:invoice_id].to_i] = [] if !result[trans[:invoice_id].to_i]
      result[trans[:invoice_id].to_i] << Transaction.new(trans, self)
      result
    end
  end

  def all
    transactions.values.flatten
  end

  def find_by_id(transaction_id)
    invoices = transactions.select do |id, invoice|
      invoice.any? {|transaction| transaction.id == transaction_id.to_i}
    end.values.flatten
    invoices.find {|transaction| transaction.id == transaction_id.to_i}
  end

  def find_all_by_invoice_id(invoice_id)
    return [] if transactions[invoice_id].nil?
    transactions[invoice_id]
  end

  def find_all_by_credit_card_number(num)
    invoices = transactions.select do |id, invoice|
      invoice.any? {|transaction| transaction.credit_card_number == num.to_i}
    end.values.flatten
    invoices.find_all {|transaction| transaction.credit_card_number == num.to_i}
  end

  def find_all_by_result(result)
    invoices = transactions.select do |id, invoice|
      invoice.any? {|transaction| transaction.result == result}
    end.values.flatten
    invoices.find_all{|transaction| transaction.result == result}
  end

  def find_invoice_by_invoice_id(invoice_id)
    parent.find_invoice_by_invoice_id(invoice_id)
  end

  def inspect
    "#<#{self.class} #{@transactions.size} rows>"
  end
end
