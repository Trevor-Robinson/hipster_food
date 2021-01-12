require 'pry'
class Event
  attr_reader :name,
              :food_trucks
  def initialize(name)
    @name = name
    @food_trucks = []
    @date = (Date.today).to_s
  end

  def add_food_truck(food_truck)
    @food_trucks << food_truck
  end

  def food_truck_names
    @food_trucks.map do |food_truck|
      food_truck.name
    end
  end

  def food_trucks_that_sell(item)
    trucks_that_sell = []
    @food_trucks.each do |food_truck|
      food_truck.inventory.each do |inventory_item, amount|
        trucks_that_sell << food_truck if item == inventory_item
      end
    end
    trucks_that_sell.uniq
  end

  def total_inventory
    items_sold = {}
    @food_trucks.each do |food_truck|
      food_truck.inventory.each do |inventory_item, amount|
        if items_sold.key?(inventory_item)
          items_sold[inventory_item] = (items_sold[inventory_item] + amount)
        elsif !items_sold.key?(inventory_item)
          items_sold[inventory_item] = amount
        end
      end
    end
    total_inventory = {}
    items_sold.uniq.each do |item_sold, quantity|
      total_inventory[item_sold] = {quantity: quantity, food_trucks: food_trucks_that_sell(item_sold)}
    end
    total_inventory
  end

  def overstocked_items
    overstocked_items = []
    total_inventory.each do |item, hash|
      overstocked_items << item if hash[:quantity] > 50 && hash[:food_trucks].length > 1
    end
    overstocked_items
  end

  def sorted_name_list
    item_names = []
    total_inventory.each do |item, hash|
      item_names << item.name
    end
    item_names.sort
  end
end
