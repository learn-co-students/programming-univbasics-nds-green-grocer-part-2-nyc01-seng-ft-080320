require_relative './part_1_solution.rb'
require "pry"

def consolidate_cart(cart)
  index = 0
  new_cart = []
  
  cart.each do |grocery_item|
    current_item = find_item_by_name_in_collection(grocery_item[:item], new_cart)
    if current_item
      new_cart_index = 0
      new_cart.each do |new_cart_item|
        if new_cart_item[:item] === current_item[:item]
          new_cart_item[:count] += 1
        end
        new_cart_index += 1
      end
    else
      grocery_item[:count] = 1
      new_cart << grocery_item
    end
    index += 1
  end
  new_cart
end

def apply_coupons(cart, coupons)
  index = 0 
  coupons.each do |coupon|
    item_with_coupon = find_item_by_name_in_collection(coupon[:item], cart)
    item_in_basket = !!item_with_coupon 
    big_enough_count = item_in_basket && item_with_coupon[:count] >= coupon[:num]
      if item_in_basket && big_enough_count
        cart << { :item => "#{item_with_coupon[:item]} W/COUPON",
                  :price => coupon[:cost] / coupon[:num],
                  :clearance => item_with_coupon[:clearance],
                  :count => coupon[:num]
                }
        item_with_coupon[:count] -= coupon[:num]
      end 
      index += 1 
    end
    cart 
  end

def apply_clearance(cart)
  cart.map do |item|
   if item[:clearance] 
     item[:price] = (item[:price] - (item[:price] * 0.20)).round(2)
    end
  item   
  end
end 

def checkout(cart, coupons)
consolidated_cart = consolidate_cart(cart)
couponed_cart = apply_coupons(consolidated_cart, coupons)
clearanced_cart = apply_clearance(couponed_cart)

total = 0 

 clearanced_cart.each do |item|
  total += item[:price] * item[:count] 
end


total = (total- (total * 0.10)) if total > 100 
  total.round(2)
end 

