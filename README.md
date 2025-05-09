# 🛒 Shopping Basket Implementation

A Ruby shopping basket system built with extensibility and clarity in mind. It supports a configurable product catalogue, tiered delivery rules, and pluggable special offers.

---

## 📦 Overview

This project models a shopping basket system for **Acme Widget Co**, supporting:

- Adding items using item code
- Calculating of total price with delivery and discount rules
- Modular design following OOP principles

---
## 🚀 Installation

```bash
git clone https://github.com/hildakh/acme-widget-co.git
cd acme-widget-co
```

## 🧪 Usage

```ruby
basket = Basket.new(product_catalogue, delivery_rules, offers)
basket.add("R01")         # Add item by product code
puts basket.total         # Calculate final price
```

## 🧱 Components
  ### 📘 Product Catalogue
  - Stores product data (code, name, price)
  - Validates product codes
  - Raises InvalidProductError for unknown products

  ### 🚚 Delivery Rules
    Calculates shipping cost based on subtotal after discounts:

  ### 🧮 Delivery Charge
  - $0 to $49.99 ->	$4.95
  - $50 to $89.99 -> $2.95
  - $90 and above	-> Free

  ### 🎁 Offers
  - Supports multiple offer strategies via class injection
  - Each offer must implement
    ```ruby
      calculate_discount(items, catalogue)
    ```
  - Offers are applied before delivery is calculated
    - Example offer:
      Buy 1 Red Widget, get the second at half price.

## ⚠️ Error Handling
  ```ruby
    begin
      basket.add("INVALID")
    rescue InvalidProductError
      # Handle unknown product
    rescue ArgumentError
      # Handle non-string product code
    end
  ```

## 🧠 Assumptions
  - Product codes are strings
  - Prices are in USD, with precision up to 2 decimal places
  - Delivery is calculated after applying discounts
  - Offers can stack if more than one is present
  - Empty baskets total to $0.00
  - Quantities are whole numbers (no partials)

## 🧪 Testing
  Run unit tests for core components:

  ```bash
    ruby specs/basket_spec.rb
    ruby specs/delivery_rules_spec.rb
    ruby specs/red_widget_offer_spec.rb
  ```
