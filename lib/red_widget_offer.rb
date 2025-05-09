class RedWidgetOffer
  def calculate_discount(items, product_catalogue)
    red_count = items.count { |item| item[:code] == "R01" }
    red_pairs = red_count / 2
    red_pairs * (product_catalogue["R01"][:price] / 2)
  end
end