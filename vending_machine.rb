class VendingMachine
  attr_accessor :products, :chosen_product, :inserted_amount, :change, :insufficient_amount, :internal_change
  SIZE = 50

  def initialize(products={}, change={})
    @products = products
    @internal_change = change
  end

  def select_product(name)
    @chosen_product = @products[name.to_sym]
    @chosen_product ?  @chosen_product[:name] : "Opps. There isn't the product you've selected"
  end

  def insert_money(money)
    @inserted_money = money
  end

  def return_product
    return "Please select a product" unless @chosen_product
    if verify_amount 
      @chosen_product[:name]
    else
      process_transaction
    end
  end

  def space_left
    SIZE - occupied_space
  end

  def occupied_space
    @products.values.inject(0) { |sum, product| sum + product[:quantity] }
  end

  def refill(products)
    if space_left >= products.values.inject(0) { |sum, product| sum + product[:quantity] }
      products.each do |name, attrs|
        if @products[name] 
          @products[name][:quantity] += attrs[:quantity]
        else
          @products[name] = attrs
        end
      end
    else
      "There isn't enough space for all the products."
    end
  end

  private
  def verify_amount
    @inserted_money == @chosen_product[:price]
  end

  def process_transaction
    if @inserted_money > @chosen_product[:price]
      @change = change_to_return
      @chosen_product[:name]
    else
      @insufficient_amount = requested_amount
      "Insufficient funds, please insert #{@insufficient_amount} more"
    end
  end

  def requested_amount
    @chosen_product[:price] - @inserted_money
  end

  def change_to_return
    @inserted_money - @chosen_product[:price]
  end
end
