require_relative './part_1_solution.rb'
require 'pry'

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    og_item = find_item_by_name_in_collection(coupon[:item], cart)
    if og_item != nil && og_item[:count] >= coupon[:num] 
      og_item[:count] -= coupon[:num] 
      cart << {item: coupon[:item] + " W/COUPON", price: coupon[:cost] / coupon[:num], clearance: og_item[:clearance], count: coupon[:num]}
    end
  end
  cart
end

def apply_clearance(cart)
  cart.map do |item|
    if item[:clearance]
      item[:price] = (item[:price]*0.8).round(2)
    end
    item
  end
end

def checkout(cart, coupons)
  
  ultimate_cart = apply_clearance(apply_coupons(consolidate_cart(cart), coupons))
  
  bill = 0
  
  ultimate_cart.each {|item| bill += item[:count]*item[:price]}
  
  bill > 100 ? bill *= 0.9 : bill
  bill.round(2)
end
