require_relative '../lib/basket'
require_relative '../lib/delivery_rules'
require_relative '../lib/red_widget_offer'

@product_catalogue = {
  "R01" => { code: "R01", name: "Red Widget",  price: 32.95 },
  "G01" => { code: "G01", name: "Green Widget", price: 24.95 },
  "B01" => { code: "B01", name: "Blue Widget",  price: 7.95 }
}

def run_test(items, expected_total)
  delivery_rules = DeliveryRules.new
  red_widget_offer = RedWidgetOffer.new
  basket = Basket.new(@product_catalogue, delivery_rules, [red_widget_offer])

  begin
    items.each { |code| basket.add(code) }
    actual_total = basket.total
    puts "✓ #{items.join(', ')} (Expected: $#{expected_total}, Got: $#{actual_total})"
  rescue InvalidProductError, ArgumentError => e
    if expected_total == "error"
      puts "✓ #{items.join(', ')} (Expected: error, Got: #{e.class})"
    else
      puts "✗ #{items.join(', ')} (Expected: $#{expected_total}, Got: #{e.class})"
    end
  end
end

run_test([], "0.00")
run_test(["INVALID"], "error")
run_test([""], "error")
run_test([12.3], "error")
run_test(["B01", "G01"], "37.85")
run_test(["R01", "R01"], "54.37")
run_test(["R01", "G01"], "60.85")
run_test(["B01", "B01", "R01", "R01", "R01"], "98.27")

