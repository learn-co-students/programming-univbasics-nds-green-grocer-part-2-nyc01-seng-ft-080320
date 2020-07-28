require_relative './part_1_solution.rb'
require 'pry'

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  cart.each_with_index {|val, index|
  
    available_coupon = find_item_by_name_in_collection(val[:item], coupons)
    
    if available_coupon && val[:count] / available_coupon[:num] > 0
      coupon_item = {}
      coupon_item[:item] = available_coupon[:item] + " W/COUPON"
      coupon_item[:price] = available_coupon[:cost] / available_coupon[:num]
      coupon_item[:clearance] = val[:clearance]
      coupon_item[:count] = (val[:count] / available_coupon[:num]) * available_coupon[:num]
      cart.push(coupon_item)
      cart[index][:count] = val[:count] % available_coupon[:num]
      #binding.pry
    end
    }
    cart  
  
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  
  cart.map{ |cart_item|
    if cart_item[:clearance]
      cart_item[:price] *= 0.8
    end
  }
  cart
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
  
  consolidated_cart = consolidate_cart(cart)
  cart_with_coupons = apply_coupons(consolidated_cart, coupons)
  cart_with_clearance = apply_clearance(cart_with_coupons)
  total = get_total(cart_with_clearance)
end

def get_total(cart)
  total = 0
  cart.each{ |item_in_cart|
    total += item_in_cart[:price]*item_in_cart[:count]
  }
  if total > 100
    total *= 0.9
  end
  return total.round(1)
end
