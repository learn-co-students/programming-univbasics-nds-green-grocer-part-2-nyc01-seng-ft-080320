require_relative './part_1_solution.rb'

def mk_coupon_hash(c)
  rounded_unit_price = (c[:cost].to_f * 1.0 / c[:num]).round(2) #formula for coupon with rounded price
  {
    :item => "#{c[:item]} W/COUPON", #creates "ITEM W/COUPON"
    :price => rounded_unit_price, #rounds the unit price with formula above
    :count => c[:num] #the number of items with coupon
  }
end


def apply_coupon_to_cart(matching_item, coupon, cart)
  matching_item[:count] -= coupon[:num] #says if your item number is higher than coupon number a coupon can be applied
  item_with_coupon = mk_coupon_hash(coupon) #gives all items with coupon
  item_with_coupon[:clearance] = matching_item[:clearance] #compares the two values and checks for clearances as well as coupons
  cart << item_with_coupon #sends the item with coupon to the hash
end

def apply_coupons(cart, coupons)
  i = 0
  while i < coupons.count do #while the count is lower than the amount of coupons
    coupon = coupons[i] #gives index of which coupon to use
    item_with_coupon = find_item_by_name_in_collection(coupon[:item], cart) #uses previous method to compare the item with coupon to the cart
    item_is_in_basket = !!item_with_coupon #the item is in basket and has a coupon
    count_is_big_enough_to_apply = item_is_in_basket && item_with_coupon[:count] >= coupon[:num] #and there are enough items and coupons to apply

    if item_is_in_basket and count_is_big_enough_to_apply
      apply_coupon_to_cart(item_with_coupon, coupon, cart) #if we satisfy those conditions we apply to coupon to the cart
    end
    i += 1
  end

  cart
end


def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  i = 0 
  while i < cart.length do 
    item = cart[i]
    if item[:clearance]
      discounted_price = ((1 - 0.2) * item[:price]).round(2) 
      item[:price] = discounted_price
end
i += 1 
end
cart
end

def items_total(i)
  i[:count] * i[:price]
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
  total = 0
  i=0 
  finishcart = consolidate_cart(cart)
  apply_coupons(finishcart, coupons)
  apply_clearance(finishcart)
  while i < finishcart.length do
    total += items_total(finishcart[i])
    i += 1
end
 total >= 100 ? total * (1.0 - 0.1) : total
end
