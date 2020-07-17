def find_item_by_name_in_collection(name, collection)
  index = 0

  collection.each do |grocery_item|
    return grocery_item if grocery_item[:item] === name 
    index += 1
  end

  nil
end


# def consolidate_cart(cart)
#   index = 0
#   new_cart = []
  
#   cart.each do |grocery_item|
#     current_item = find_item_by_name_in_collection(grocery_item[:item], new_cart)
#     if current_item
#       new_cart_index = 0
#       new_cart.each do |new_cart_item|
#         if new_cart_item[:item] === current_item[:item]
#           new_cart_item[:count] += 1
#         end
#         new_cart_index += 1
#       end
#     else
#       grocery_item[:count] = 1
#       new_cart << grocery_item
#     end
#     index += 1
#   end
#   new_cart
# end
def consolidate_cart(cart)
  new_cart = []
  i = 0 
  while i < cart.length do 
    new_cart_item = find_item_by_name_in_collection(cart[i][:item], new_cart)
    if new_cart_item != nil 
      new_cart_item[:count] += 1 
    else 
      new_cart_item = {
      :item => cart[i][:item],
      :price => cart[i][:price],
      :clearance => cart[i][:clearance],
      :count => 1 
    }
      new_cart << new_cart_item
    end 
    i +=1 
    end
  new_cart
  
end