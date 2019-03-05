class VendingMachine
  attr_accessor :products, :selected_product, :inserted_amount
  
  PRODUCTS = ['lily', 'anemone', 'daisy']
  COST = 300

  def initialize
    @products = PRODUCTS
  end

  def select_product(name)
    @selected_product = @products.find { |product|  product == name }
    @selected_product ?  @selected_product : "Opps. There isn't the product you've selected"
  end

  def insert_money(money)
    @inserted_money = money
  end

  def verify_amount
    @inserted_money == 300
  end

  def return_product
    return "Please select a product" unless @selected_product
    verify_amount ? @selected_product : "The amount inserted is incorrect"
  end
end


