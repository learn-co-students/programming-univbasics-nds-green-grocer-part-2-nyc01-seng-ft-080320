require_relative './part_1_solution.rb'
require 'pry';

def apply_coupons(cart, coupons)
  cart.each_with_index {|item, i|
    coupon = find_item_by_name_in_collection(item[:item], coupons)
    if (coupon)
      coupItem = {};
      coupItem[:item] = "#{item[:item]} W/COUPON";
      coupItem[:price] = coupon[:cost] / coupon[:num];
      coupItem[:clearance] = item[:clearance];
      coupItem[:count] = item[:count] - (item[:count] % coupon[:num]);
      item[:count] = item[:count] % coupon[:num];
      cart.push(coupItem);
    end
  }
  return cart;
end

def apply_clearance(cart)
  newCart = cart.map {|item|
    if (item[:clearance])
      item[:price] *= 0.8;
      item;
    else
      item;
    end
  }
  return newCart;
end

#LOOKS LIKE A GOOD CHANCE 2 USE REDUCE
def checkout(cart, coupons)
  dCart = apply_clearance(apply_coupons(consolidate_cart(cart), coupons));

  sum = dCart.reduce(0) {|total, item|
    total + (item[:price] * item[:count]);
    #lol i spent waaay to long justing summing the price without multiplying by qty...
  }

  if (sum > 100)
    sum *= 0.9;
  end
  return sum.round(2);
end
