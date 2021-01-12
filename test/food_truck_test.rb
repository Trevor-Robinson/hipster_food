require 'minitest/autorun'
require 'minitest/pride'
require './lib/food_truck'
require './lib/item'

class FoodTruckTest < Minitest::Test
  def setup
    @item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    @item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
    @food_truck = FoodTruck.new("Rocky Mountain Pies")
  end
  def test_it_exists_and_has_attributes
    assert_instance_of FoodTruck, @food_truck
    assert_equal "Rocky Mountain Pies", @food_truck.name
    assert_equal ({}), @food_truck.inventory
  end

  def test_when_inventory_is_empty_stock_returns_0
    assert_equal 0, @food_truck.check_stock(@item1)
  end

  def test_stock_adds_item_to_inventory
    @food_truck.stock(@item1, 30)
    # require 'pry' ;binding.pry
    assert_equal ({@item1 => 30}), @food_truck.inventory
    @food_truck.stock(@item1, 25)
    assert_equal ({@item1 => 55}), @food_truck.inventory
    @food_truck.stock(@item2, 12)
    assert_equal ({@item1 => 55, @item2 => 12}), @food_truck.inventory
  end
  def test_it_can_calculate_potential_revenue
    @food_truck.stock(@item1, 10)
    @food_truck.stock(@item2, 20)
    assert_equal 87.50, @food_truck.potential_revenue
  end
end
