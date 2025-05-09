class DeliveryRules
  RULES = [
    { min: 90, charge: 0 },
    { min: 50, charge: 2.95 },
    { min: 0, charge: 4.95 }
  ]

  def calculate_charges(subtotal)
    RULES.find { |rule| subtotal >= rule[:min] }[:charge]
  end
end