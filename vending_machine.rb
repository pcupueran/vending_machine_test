class VendingMachine
  attr_accessor :products, :chosen_product, :inserted_amount, :change, :insufficient_amount, :internal_change
  
  PRODUCTS = [{ name: 'lily', price: 100 }, { name: 'anemone', price: 200 } , { name: 'daisy', price: 300 }]

  def initialize(products=PRODUCTS, change={})
    @products = products
    @internal_change = change
  end

  def select_product(name)
    @chosen_product = @products.find { |product|  product[:name] == name }
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
