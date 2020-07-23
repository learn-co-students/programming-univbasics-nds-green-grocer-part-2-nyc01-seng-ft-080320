require 'pry'

def find_item_by_name_in_collection(name, collection)
  collection.find {|x| x[:item] == name}
end

cart_test = [
      {:item => "BEETS", :price => 2.50, :clearance => false},
      {:item => "BEER", :price => 13.00, :clearance => false},
      {:item => "BEER", :price => 13.00, :clearance => false},
      {:item => "BEER", :price => 13.00, :clearance => false}
]

def consolidate_cart(cart)
  new_cart = []
  cart.each do |item|
    item_data = find_item_by_name_in_collection(item[:item], new_cart)
    if item_data
      new_cart.each do |new_item|
        if new_item[:item] === item_data[:item]
           new_item[:count] += 1
        end
      end
    else
      item[:count] = 1
      new_cart << item
    end
  end
  new_cart
end