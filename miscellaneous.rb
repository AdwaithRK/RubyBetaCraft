# Miscellaneous task unrelated to business logic
module Miscellaneous

    @@price = [{item: "Banana", price: 0.99, sale: {}},
        {item: "Bread", price: 2.17, sale: {quantity: 3, offer_price: 6.00}},
        {item: "Apple", price: 0.89, sale: {}},
        { item: "Milk", price: 3.97, sale: {quantity: 2, offer_price: 5.00}}  ]

    def count_items(string)
        # Count items by splitting w.r.t comma(,) and filter out items not in the static list
        words = string.split(",").map(&:strip).map(&:downcase).select{|x| price_sale.include?(x) }
        frequency = Hash.new(0)
        words.each { |word| frequency[word.downcase] += 1 }
        frequency
    end

    def display_price(display_list, total_price, total_discounted_price)
        print "\n\nItem\t\tQuantity\t\tPrice\n\n"
        print "---------------------------------------------------\n\n"
        display_list.each do |item|
            print "#{item[:name].capitalize}\t\t#{item[:quantity]}\t\t#{item[:price]}\n\n"
        end
        # we find the difference b/w price without discount i.e total price and total discounted price to find savings 
        print "Total price : $#{total_discounted_price}\n"
        if(total_price - total_discounted_price)
            print "You saved $#{(total_price - total_discounted_price).round(2)} today.\n"
        end
    end

    def price_sale
        @@price.map{|x| x[:item]}.map(&:downcase)
    end
    
    def get_item_price(item)
        @@price.select{|x| x[:item].downcase == item.downcase}.first
    end

    def build_item_price(item, item_discounted_price)
        {name: item[0], quantity: item[1], price: item_discounted_price}
    end

end