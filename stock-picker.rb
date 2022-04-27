def stock_picker(stocks)
  most_profitable_days = []
  profit = 0
  stocks.each_with_index do |buying_price, buying_index|
    selling_price = stocks[buying_index..-1].max
    selling_index = stocks.index(selling_price)
    if selling_price - buying_price > profit
      most_profitable_days = [buying_index, selling_index]
      profit = selling_price - buying_price
    end
  end
  p most_profitable_days
end

stock_picker([17, 3, 6, 9, 15, 8, 6, 1, 10])
