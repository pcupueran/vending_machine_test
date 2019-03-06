require_relative "vending_machine"
require "test/unit"

class TestVendingMachine < Test::Unit::TestCase
  def setup
    products = { 
      lily: { name: 'lily', price: 100, quantity: 10 }, 
      anemone: { name: 'anemone', price: 200, quantity: 5 } , 
      daisy: { name: 'daisy', price: 300, quantity: 4 }
    }

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

    @vending_machine = VendingMachine.new(products, change)
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
    products = { 
      lily:{ name: 'lily', price: 100 }, 
      anemone: { name: 'anemone', price: 200 }
    }
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

  def test_refill_with_exiting_and_new_products
    products = { 
      lily:{ name: 'lily', quantity: 5 }, 
      anemone: { name: 'anemone', quantity: 3 },
      rose: { name: 'rose', price: 400, quantity: 5 }
    }
    @vending_machine.refill(products)
    assert_equal(15, @vending_machine.products[:lily][:quantity])    
    assert_equal(8, @vending_machine.products[:anemone][:quantity])    
    assert_equal(5, @vending_machine.products[:rose][:quantity])    
    assert_equal(400, @vending_machine.products[:rose][:price])    
  end

  def test_not_enough_space_for_products
    products = { 
      lily:{ name: 'lily', quantity: 10 }, 
      anemone: { name: 'anemone', quantity: 30 }
    }

    assert_equal("There isn't enough space for all the products.", @vending_machine.refill(products))
  end

  def test_add_internal_change
    change = { 
      '1p' => 20, 
      '2p' => 20, 
      '5p' =>5
    }
    @vending_machine.add_internal_change(change)
    assert_equal(40, @vending_machine.internal_change['1p'])
    assert_equal(50, @vending_machine.internal_change['2p'])
    assert_equal(25, @vending_machine.internal_change['5p'])
  end
end