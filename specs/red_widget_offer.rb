require_relative '../lib/red_widget_offer'

def run_test(items, catalogue, expected_discount)
  actual_discount = RedWidgetOffer.new.calculate_discount(items, catalogue)

  if actual_discount == expected_discount.to_f
    puts "✓ Discount: Expected $#{expected_discount}, Got $#{actual_discount}"
  else
    puts "✗ Discount: Expected $#{expected_discount}, Got $#{actual_discount}"
  end
end

CATALOGUE = {
  "R01" => { code: "R01", name: "Red Widget",  price: 32.95 }
}

run_test([{code: "R01"}], CATALOGUE, 0)
run_test([{code: "R01"}, {code: "R01"}], CATALOGUE, 16.48)
run_test([{code: "R01"}, {code: "R01"}, {code: "R01"}], CATALOGUE, 16.48)
run_test([{code: "R01"}, {code: "R01"}, {code: "R01"}, {code: "R01"}], CATALOGUE, 32.95)
