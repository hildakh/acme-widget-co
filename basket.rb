class Basket
  def initialize(product_catalogue, delivery_rules, offers)
    @product_catalogue = product_catalogue
    @delivery_rules = delivery_rules
    @offers = offers
    @items = []
  end

  def add(item_code)
    product = @product_catalogue[item_code]
    @items << product if product
  end

  def total
    subtotal = @items.sum{ |item| item[:price] }
    (subtotal + calculate_delivery_cost(subtotal)).round(2)
  end

  private

  def calculate_delivery_cost(subtotal)
    case subtotal
    when 0...50 then  4.95
    when 50...90 then 2.95
    else 0
    end
  end
end

product_catalogue = {
  "R01" => { name: "Red Widget", price: 32.95 },
  "G01" => { name: "Green Widget", price: 24.95 },
  "B01" => { name: "Blue Widget", price: 7.95 }
}

basket = Basket.new(product_catalogue, delivery_rules = nil, offers = nil)
basket.add("R01")
puts basket.total