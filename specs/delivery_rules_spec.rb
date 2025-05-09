require_relative '../lib/delivery_rules'

def run_test(subtotal, expected_charge)
  actual_charge = DeliveryRules.new.calculate_charges(subtotal)

  if actual_charge == expected_charge.to_f
    puts "✓ (Expected: $#{expected_charge}, Got: $#{actual_charge})"
  else
    puts "✗ (Expected: $#{expected_charge}, Got: $#{actual_charge})"
  end
end

run_test(0, 4.95)
run_test(30, 4.95)
run_test(50, 2.95)
run_test(90, 0)
