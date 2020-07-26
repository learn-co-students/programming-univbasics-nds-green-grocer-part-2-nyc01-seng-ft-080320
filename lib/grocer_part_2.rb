require_relative './part_1_solution.rb'

def apply_coupons(cart, coupons)
  coupons.each do |coupons_hash|
    cart_hash = find_item_by_name_in_collection(coupons_hash[:item], cart)
    if cart_hash && cart_hash[:count] >= coupons_hash[:num]
      new_hash = cart_hash.clone
      new_hash[:item] = "#{new_hash[:item]} W/COUPON"
      new_hash[:price] = coupons_hash[:cost] / coupons_hash[:num]
      new_hash[:count] = coupons_hash[:num]
      cart_hash[:count] = cart_hash[:count] - coupons_hash[:num]
      cart << new_hash
    end
  end
  cart 
end

def apply_clearance(cart)
  cart.each do |hash|
    if hash[:clearance]
      hash[:price] = (hash[:price] * 0.8).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  total_price = 0
  cart.each do |hash|
    total_price += hash[:price] * hash[:count]
  end
  if total_price > 100
    total_price *= 0.9
  end
  total_price
end
