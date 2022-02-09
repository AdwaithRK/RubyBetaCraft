require_relative "miscellaneous"

class CalculatePrice

    include Miscellaneous

    def initialize()
        @total_price = 0.0
        @total_discounted_price = 0.0
        @item_total_real_price = 0.0
        @item_discounted_price = 0.0
        @items = ""
        @item_list = []
    end

    def collect_data
        print "Please enter all the items purchased separated by a comma\n"
        @items = gets
    end

    def calculate_price
        get_price(@items)
    end

    def display_price_list
        display_price(@item_list,  @total_price, @total_discounted_price)
    end

    private

    def get_discounted_and_not_discounted_price(item)
        item_price = get_item_price(item[0])
        @item_total_real_price = item_price[:price] * item[1]
        # Here if sale is available we compute the amount of discounted and non discounted quantity
        if(!item_price[:sale]&.empty?)
            item_prices = get_discounted_and_not_discounted_quantity(item_price, item[1])
            #simple addition to find to price with discounted quantity and non discounted quantity
            @item_discounted_price = item_prices[:discounted] * item_price[:sale][:offer_price] + item_prices[:non_discounted] * item_price[:price]
        else
            @item_discounted_price = @item_total_real_price
        end
        #miscellaneous function to give item price in format {name:, quantity:, price:}
        build_item_price(item, @item_discounted_price)
    end

    def get_price(items)
        items = count_items(items)
        #Iterating over items to find price
        items.each do |item|
            item_price = get_discounted_and_not_discounted_price(item)
            # Here total discounted price is price with discount. total_discounted_price = total_price if no discount is available
            @total_discounted_price += @item_discounted_price
            @total_price += @item_total_real_price
            @item_list.push(item_price)
        end
        @item_list
    end
    
    def get_discounted_and_not_discounted_quantity(item_price, item_count)
        discount_item = 0
        offer_count = item_price[:sale][:quantity]
        #Iterative substration to find the number of discounted quantity
        while(offer_count <= item_count)
            item_count = item_count - offer_count 
            discount_item += 1
        end    
        {discounted: discount_item, non_discounted: item_count}
    end
    
end


calculate_price = CalculatePrice. new

calculate_price.collect_data

calculate_price.calculate_price

calculate_price.display_price_list

