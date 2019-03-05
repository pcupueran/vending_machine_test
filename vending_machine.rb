class VendingMachine
  attr_accessor :products, :chosen_product, :inserted_amount
  
  PRODUCTS = [{ name: 'lily', price: 100 }, { name: 'anemone', price: 200 } , { name: 'daisy', price: 300 }]

  def initialize
    @products = PRODUCTS
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
    verify_amount ? @chosen_product[:name] : "The amount inserted is incorrect"
  end

  private
  def verify_amount
    @inserted_money == @chosen_product[:price]
  end
end
