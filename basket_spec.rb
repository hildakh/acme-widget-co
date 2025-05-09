require_relative 'basket'

@product_catalogue = {
  "R01" => { code: "R01", name: "Red Widget",  price: 32.95 },
  "G01" => { code: "G01", name: "Green Widget", price: 24.95 },
  "B01" => { code: "B01",   name: "Blue Widget",  price: 7.95 }
}

def run_test(items, expected_total)
  basket = Basket.new(@product_catalogue, nil, nil)
  items.each { |code| basket.add(code) }
  actual_total = basket.total

  if actual_total == expected_total.to_f
    puts "✓ #{items.join(', ')} (Expected: $#{expected_total}, Got: $#{actual_total})"
  else
    puts "✗ #{items.join(', ')} (Expected: $#{expected_total}, Got: $#{actual_total})"
  end
end

run_test(["B01", "G01"], "37.85")
run_test(["R01", "R01"], "54.38")
run_test(["R01", "G01"], "60.85")
run_test(["B01", "B01", "R01", "R01", "R01"], "98.28")
