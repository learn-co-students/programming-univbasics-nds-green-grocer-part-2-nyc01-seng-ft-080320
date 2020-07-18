require_relative './part_1_solution.rb'
require 'pry'

def apply_coupons(cart, coupons)
  apply_coupon_cart = []
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  coupons.each do |coupon_item|
    current_coupon_item = find_item_by_name_in_collection(coupon_item[:item], cart)
    cart.each do |cart_item|
      if current_coupon_item[:item] == cart_item[:item] and coupon_item[:num] <= cart_item[:count]
        if cart_item[:count] == coupon_item[:num]
          update_coupon_item = cart_item.clone
          update_coupon_item[:item] += " W/COUPON"
          update_coupon_item[:price] = coupon_item[:cost]/coupon_item[:num]
          cart << update_coupon_item
          cart_item[:count] -= coupon_item[:num]
        else
          cart_item[:count] -= coupon_item[:num]
          update_coupon_item = cart_item.clone
          update_coupon_item[:item] += " W/COUPON"
          update_coupon_item[:count] = coupon_item[:num]
          update_coupon_item[:price] = coupon_item[:cost]/coupon_item[:num]
          cart << update_coupon_item
        end
      end
    end
  end
  cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  cart.each do |item|
    if item[:clearance] == true
      original_price = item[:price]
      clearance_price = (original_price - (original_price * 0.20)).round(2)
      item[:price] = clearance_price
    end
  end
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  grand_total = 0
  checkout_items = []
  checkout_items = apply_clearance(apply_coupons(consolidate_cart(cart), coupons))
#  checkout_items = consolidate_cart(cart)
#  checkout_items = apply_coupons(checkout_items, coupons)
#  checkout_items = apply_clearance(checkout_items)
  checkout_items.each do |item|
    grand_total += (item[:price] * item[:count])
  end
  if grand_total > 100
    grand_total = (grand_total - (grand_total * 0.1)).round(2)
  end
  grand_total
end
