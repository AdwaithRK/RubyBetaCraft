require 'pry'

$price = [{item: "Banana", price: 0.99, sale: {}},
         {item: "Bread", price: 2.17, sale: {quantity: 3, offer_price: 6.00}},
         {item: "Apple", price: 0.89, sale: {}},
         { item: "Milk", price: 3.97, sale: {quantity: 2, offer_price: 5.00}}  ]

def price_sale
    $price.map{|x| x[:item]}.map(&:downcase)
end

def get_item_price(item)
    p "item here is #{item}"
    $price.select{|x| x[:item].downcase == item.downcase}.first
end

def get_discounted_and_not_discounted_quantity(item_price, item_count)
    discount_item = 0
    offer_count = item_price[:sale][:quantity]
    while(offer_count <= item_count)
        item_count = item_count - offer_count 
        discount_item += 1
    end
    return {discounted: discount_item, non_discounted: item_count}
end

def count_words(string)
    words = string.split(",").map(&:strip).map(&:downcase).select{|x| price_sale.include?(x) }
    frequency = Hash.new(0)
    words.each { |word| frequency[word.downcase] += 1 }
    return frequency
end

def get_price(items)
    display_list = []
    items = count_words(items)
    total_price = 0.0
    total_discounted_price = 0.0
    item_total_real_price = 0.0
    item_discounted_price = 0.0
    items.each do |x|
        item_display = {}
        item_display[:name] = x[0]
        item_display[:quantity] = x[1]
        item_price = get_item_price(x[0])
        item_total_real_price = item_price[:price] * x[1]
        if(!item_price[:sale]&.empty?)
            item_prices = get_discounted_and_not_discounted_quantity(item_price, x[1])
            item_discounted_price = item_prices[:discounted] * item_price[:sale][:offer_price] + item_prices[:non_discounted] * item_price[:price]
        else
            item_discounted_price = item_total_real_price
        end
        item_display[:price] = item_discounted_price
        total_discounted_price += item_discounted_price
        total_price += item_total_real_price

        display_list.push(item_display)
    end
    display_price(display_list,  total_price, total_discounted_price)
end

def display_price(display_list, total_price, total_discounted_price)
    print "\n\nItem\t\tQuantity\t\tPrice\n\n"
    print "---------------------------------------------------\n\n"
    display_list.each do |item|
        print "#{item[:name].capitalize}\t\t#{item[:quantity]}\t\t#{item[:price]}\n\n"
    end

    print "Total price : $#{total_discounted_price}\n"
    if(total_price - total_discounted_price)
        print "You saved $#{total_price - total_discounted_price} today.\n"
    end
end

def collect_data
    print "Please enter all the items purchased separated by a comma\n"
    items = gets

    get_price(items)
end 

collect_data







