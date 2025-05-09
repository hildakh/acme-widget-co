class Basket
  def initialize(product_catalogue, delivery_rules, offers)
    @product_catalogue = product_catalogue
    @delivery_rules = delivery_rules || [
      { min: 90, charge: 0 },
      { min: 50, charge: 2.95 },
      { min: 0, charge: 4.95 }
    ]
    @offers = offers || [
      ->(items, product_catalogue) {
        red_count = items.count { |item| item[:code] == "R01" }
        red_pairs = red_count / 2
        red_pairs * (product_catalogue["R01"][:price] / 2)
      }
    ]
    @items = []
  end

  def add(item_code)
    raise ArgumentError, "Product code must be a string" unless item_code.is_a?(String)
    product = @product_catalogue[item_code]
    raise InvalidProductError unless product
    @items << product
  end

  def total
    discount = calculate_discount
    subtotal = @items.sum{ |item| item[:price] } - discount
    (subtotal + calculate_delivery_cost(subtotal)).round(2)
  end

  private

  def calculate_discount
    @offers.sum { |offer| offer.call(@items, @product_catalogue) }
  end

  def calculate_delivery_cost(subtotal)
    @delivery_rules.find { |rule| subtotal >= rule[:min] }[:charge] || 0
  end
end

product_catalogue = {
  "R01" => { code: "R01", name: "Red Widget", price: 32.95 },
  "G01" => { code: "G01", name: "Green Widget", price: 24.95 },
  "B01" => { code: "B01", name: "Blue Widget", price: 7.95 }
}

basket = Basket.new(product_catalogue, delivery_rules = nil, offers = nil)
basket.add("R01")
basket.add("R01")
puts basket.total