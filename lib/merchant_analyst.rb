module MerchantAnalyst
  def total_revenue_by_date(date)
    se.invoices.find_by_date(date).map do |_, invoice|
      invoice.total
    end.sum
  end

  def top_revenue_earners(quantity = 20)
    merchants_ranked_by_revenue[0...quantity]
  end

  def merchants_ranked_by_revenue
    merchants = sorted(merchant_revenue(all_merchant_invoices))
    merchants.map do |id, revenue|
      se.merchants.find_by_id(id)
    end
  end

  def merchants_with_pending_invoices
    merchants = all_merchant_invoices.select do |merchant_id, invoices|
      invoices.any? {|invoice| invoice.is_paid_in_full? == false}
    end
    merchants.map {|merchant_id, _| se.merchants.find_by_id(merchant_id)}
  end

  def merchants_with_only_one_item
    merchants = all_merchant_items.select do |merchant, items|
      items.count == 1
    end
    merchants.map {|merchant_id, _| se.merchants.find_by_id(merchant_id)}
  end

  def merchants_with_only_one_item_registered_in_month(month)
    merchants_with_one_invoice = all_merchant_invoices_by_month(month).reduce([]) do |result, (merchant_id, invoices)|
      result << merchant_id if invoices.count == 1
      result
    end
    merchants_with_one_invoice.map {|merchant_id, _| se.merchants.find_by_id(merchant_id)}

  end

  def all_merchant_invoices_by_month(month)
    se.invoices.find_by_month(month).reduce({}) do |result, (_, invoice)|
      result[invoice.merchant_id] = [] if result[invoice.merchant_id].nil?
      result[invoice.merchant_id] << invoice
      result
    end
  end

  def all_merchant_items
    se.items.all.reduce({}) do |result, item|
      result[item.merchant_id] = [] if result[item.merchant_id].nil?
      result[item.merchant_id] << item
      result
    end
  end

  def all_merchant_invoices
    se.invoices.all.reduce({}) do |result, invoice|
      result[invoice.merchant_id] = [] if result[invoice.merchant_id].nil?
      result[invoice.merchant_id] << invoice
      result
    end
  end

  def merchant_revenue(all_merchant_invoices)
    all_merchant_invoices.reduce({}) do |result, (merchant_id, invoices)|
      result[merchant_id] = 0
      invoices.each do |invoice|
        result[merchant_id] += invoice.total
      end
      result
    end
  end

end
