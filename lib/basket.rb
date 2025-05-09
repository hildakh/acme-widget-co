class InvalidProductError < StandardError; end

class Basket
  def initialize(product_catalogue, delivery_rules, offers)
    @product_catalogue = product_catalogue
    @delivery_rules = delivery_rules
    @offers = offers
    @items = []
  end

  def add(item_code)
    raise ArgumentError, "Product code must be a string" unless item_code.is_a?(String)
    product = @product_catalogue[item_code]
    raise InvalidProductError unless product
    @items << product
  end

  def total
    return 0 unless @items.any?

    discount = @offers.sum { |offer| offer.calculate_discount(@items, @product_catalogue) }
    subtotal = @items.sum{ |item| item[:price] } - discount
    (subtotal + @delivery_rules.calculate_charges(subtotal)).round(2)
  end
end
