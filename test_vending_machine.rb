require_relative "vending_machine"
require "test/unit"

class TestVendingMachine < Test::Unit::TestCase
  def setup
    @vending_machine = VendingMachine.new
    @vending_machine.select_product('daisy')
    @vending_machine.insert_money(300)
  end
  
  def test_correct_product
    assert_equal('daisy', @vending_machine.chosen_product[:name])
  end

  def test_correct_amount
    assert_equal(true, @vending_machine.send(:verify_amount))
  end

  def test_return_correct_product
    assert_equal('daisy', @vending_machine.return_product)
  end

  def test_incorrect_product
    @vending_machine.select_product('rose')
    assert_equal(nil, @vending_machine.chosen_product)
  end

  def test_incorrect_amount
    @vending_machine.insert_money(310)
    assert_equal(false, @vending_machine.send(:verify_amount))
  end

  def test_no_product_selected
    @vending_machine.select_product('rose')
    assert_equal('Please select a product', @vending_machine.return_product)
  end

  def test_incorrect_amount_inserted_give_change
    @vending_machine.insert_money(310)
    assert_equal('daisy', @vending_machine.return_product)
    assert_equal(10, @vending_machine.change)
  end

  def test_incorrect_amount_inserted_insufficient_funds
    @vending_machine.insert_money(280)
    assert_equal("Insufficient funds, please insert 20 more", @vending_machine.return_product)
    assert_equal(20, @vending_machine.insufficient_amount)
  end

  def test_initial_products
    products = [{ name: 'lily', price: 100 }, { name: 'anemone', price: 200 }]
    vending_machine = VendingMachine.new(products)
    assert_equal(products, vending_machine.products)
  end

  def test_initial_change
    change = { 
      '1p' => 20, 
      '2p' => 30, 
      '5p' =>20, 
      '10p' => 40, 
      '20p' => 30, 
      '50p' => 40, 
      '£1' => 20, 
      '£2' => 10 
    }

    vending_machine = VendingMachine.new(nil, change)
    assert_equal(change, vending_machine.internal_change)
  end
end