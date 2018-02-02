## Black Thursday

Find the [project spec here](https://github.com/turingschool/curriculum/blob/master/source/projects/black_thursday.markdown).

## Project Overview
### Learning Goals

* Use tests to drive both the design and implementation of code
* Decompose a large application into components
* Use test fixtures instead of actual data when testing
* Connect related objects together through references
* Learn an agile approach to building software

## Setup
```
git clone https://github.com/Maxscores/black_thursday.git
cd black_thursday
bundle
```
To Run Test Suite: `rake`



### Spec Harness

This project was assessed with the help of a [spec harness](https://github.com/turingschool/black_thursday_spec_harness). The `README.md` file includes instructions for setup and usage.

Make sure you're at the same level as the black_thursday project:

    <my_code_directory>
    |
    |\
    | \black_thursday/
    |
    |\
    | \black_thursday_spec_harness/
    |

```
git clone https://github.com/Maxscores/black_thursday_spec_harness
cd black_thursday_spec_harness
bundle
```
To Run Test Suite: `bundle exec rake spec`
*NOTE* All Tests of Iteration 4 should be failing. We chose to do Iteration 5 instead.

## Schema
![schema](https://i.imgur.com/tUoPi6L.png)

## Command Line Interaction
To Interact from the command line run:
```
irb
require './lib/sales_engine.rb'
se = SalesEngine.load_default
```

Then start the analysis layer like so:
```
sa = SalesAnalyst.new(se)
```

### How many products do merchants sell?

Do most of our merchants offer just a few items or do they represent a warehouse?

```ruby
sa.average_items_per_merchant # => 2.88
```

And what's the standard deviation?

```ruby
sa.average_items_per_merchant_standard_deviation # => 3.26
```
### Which merchants sell the most items?

Maybe we could set a good example for our lower sellers by displaying the merchants who have the most items for sale. Which merchants are more than one standard deviation above the average number of products offered?

```ruby
sa.merchants_with_high_item_count # => [merchant, merchant, merchant]
```

### What are prices like on our platform?

Are these merchants selling commodity or luxury goods? Let's find the average price of a merchant's items (by supplying the merchant ID):

```ruby
sa.average_item_price_for_merchant(6) # => BigDecimal
```

Then we can sum all of the averages and find the average price across all merchants (this implies that each merchant's average has equal weight in the calculation):

```ruby
sa.average_average_price_per_merchant # => BigDecimal
```

### Which are our *Golden Items*?

Given that our platform is going to charge merchants based on their sales, expensive items are extra exciting to us. Which are our "Golden Items", those two standard-deviations above the average item price? Return the item objects of these "Golden Items".

```ruby
sa.golden_items # => [<item>, <item>, <item>, <item>]
```
### How many invoices does the average merchant have?

```ruby
sa.average_invoices_per_merchant # => 8.5
sa.average_invoices_per_merchant_standard_deviation # => 1.2
```

### Who are our top performing merchants?

Which merchants are more than two standard deviations *above* the mean?

```ruby
sa.top_merchants_by_invoice_count # => [merchant, merchant, merchant]
```

### Who are our lowest performing merchants?

Which merchants are more than two standard deviations *below* the mean?

```ruby
sa.bottom_merchants_by_invoice_count # => [merchant, merchant, merchant]
```

### Which days of the week see the most sales?

On which days are invoices created at more than one standard deviation *above* the mean?

```ruby
sa.top_days_by_invoice_count # => ["Sunday", "Saturday"]
```

### What percentage of invoices are not shipped?

What percentage of invoices are `shipped` vs `pending` vs `returned`? (takes symbol as argument)

```ruby
sa.invoice_status(:pending) # => 5.25
sa.invoice_status(:shipped) # => 93.75
sa.invoice_status(:returned) # => 1.00
```
