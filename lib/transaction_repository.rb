require_relative './transaction'

class TransactionRepository
  attr_reader :transactions,
              :parent

  def initialize(transactions, parent)
    @parent = parent
    @transactions = transactions.reduce({}) do |result, transaction|
      result[transaction[:id].to_i] = Transaction.new(transaction, self)
      result
    end
  end

  def all
    transactions.values
  end

  def find_by_id(id)
    transactions[id]
  end

  def find_all_by_invoice_id(invoice_id)
    transactions.select do |id, transaction|
      transaction.invoice_id == invoice_id
    end.values
  end

  def find_all_by_credit_card_number(number)
    transactions.select do |id, transaction|
      transaction.credit_card_number == number
    end.values
  end

  def find_all_by_result(result)
    transactions.select do |id, transaction|
      transaction.result.downcase == result.downcase
    end.values
  end

  def find_invoice_by_invoice_id(invoice_id)
    parent.find_invoice_by_invoice_id(invoice_id)
  end

  def inspect
    "#<#{self.class} #{@transactions.size} rows>"
  end
end
