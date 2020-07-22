require_relative './part_1_solution.rb'

def apply_coupons(cart, coupons)
  
  cart_with_coupons = []
  
  cart.each do |item_hash|

    has_coupon = find_item_by_name_in_collection(item_hash[:item], coupons)
    
    if has_coupon
      
      # check if there's enough in the cart to qualify for the coupon
      if item_hash[:count] >= has_coupon[:num] 
      
        orig_count = item_hash[:count]
        remainder = item_hash[:count] % has_coupon[:num]

        # add coupon-less item to cart_with_coupons, update count for coupon-less item to equal remainder 
        cart_with_coupons << item_hash
        cart_with_coupons[-1][:count] = remainder
        
        # now they definitely divide evenly
        cart_with_coupons << {
          item: "#{item_hash[:item]} W/COUPON",
          price: has_coupon[:cost].to_f / has_coupon[:num].to_f,
          clearance: item_hash[:clearance],
          count: orig_count - remainder
        }
      end
      
    # if there is no coupon, just shovel it into cart_with_coupons as is
    else
      cart_with_coupons << item_hash
    end
  end
  cart_with_coupons
end

def apply_clearance(cart)
  
  cart.each do |item_hash|
    if item_hash[:clearance]
      item_hash[:price] = (item_hash[:price] * 0.8).round(2)
    end
  end
end

def checkout(cart, coupons)
  
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  
  total = 0
  
  cart.each do |item_hash|
    total = total + (item_hash[:price] * item_hash[:count]).round(2)
  end
  
  if total > 100
    total = (total * 0.9).round(2)
  end
  
  total
end
