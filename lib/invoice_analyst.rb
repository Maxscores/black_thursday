module InvoiceAnalyst
  def average_invoices_per_merchant
    (se.invoices.invoices.count.to_f / se.merchants.merchants.count).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    Math.sqrt(count_all_invoices_for_each_merchant.map do |invoice_count|
      (average_invoices_per_merchant - invoice_count) ** 2
    end.sum / (se.merchants.merchants.count - 1 )).round(2)
  end

  def count_all_invoices_for_each_merchant
    se.merchants.merchants.map do |merchant|
      merchant.invoices.count
    end
  end

  def top_merchants_by_invoice_count
    se.merchants.merchants.reduce([]) do |result, merchant|
      if merchant.invoices.count >= top_merchants_by_invoice_threshold
        result << merchant
      end
      result
    end
  end

  def top_merchants_by_invoice_threshold
    twice_stdev = (2 * average_items_per_merchant_standard_deviation)
    average_invoices_per_merchant + twice_stdev
  end

  def bottom_merchants_by_invoice_count
    se.merchants.merchants.reduce([]) do |result, merchant|
      if merchant.invoices.count <= bottom_merchants_by_invoice_threshold
        result << merchant
      end
      result
    end
  end

  def bottom_merchants_by_invoice_threshold
    twice_stdev = (2 * average_items_per_merchant_standard_deviation)
    return 0 if (average_invoices_per_merchant - twice_stdev) < 0
    average_invoices_per_merchant - twice_stdev
  end

  def top_days_by_invoice_count
    invoice_count_by_day.reduce([]) do |result, (day, count)|
      if count >= threshold_for_top_invoice_days
        result << day
      end
      result
    end
  end

  def threshold_for_top_invoice_days
    average_invoices_per_day + standard_deviation_of_invoices_per_day
  end

  def standard_deviation_of_invoices_per_day
    Math.sqrt(invoice_count_by_day.values.map do |value|
      (average_invoices_per_day - value) ** 2
    end.sum / (7 - 1 )).round(2)
  end

  def invoice_count_by_day
    se.invoices.invoices.reduce({}) do |result, invoice|
      day = invoice.created_at.strftime('%A')
      result[day] = 0 if result[day].nil?
      result[day] += 1
      result
    end
  end

  def average_invoices_per_day
    (se.invoices.invoices.count) / 7
  end

  def invoice_status(status)
    separated = se.invoices.invoices.reduce({}) do |result, invoice|
      result[invoice.status] = 0 if result[invoice.status].nil?
      result[invoice.status] += 1
      result
    end
    (separated[status].to_f / se.invoices.invoices.count).round(2)
  end
end
