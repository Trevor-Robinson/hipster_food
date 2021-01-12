class FoodTruck
  attr_reader :name,
              :inventory
  def initialize(name)
    @name = name
    @inventory = {}
  end

  def check_stock(item)
    return 0 if !inventory.key?(item)
  end

  def stock(item, amount)
    if inventory.key?(item)
      inventory[item] = (inventory[item] + amount)
    elsif !inventory.key?(item)
      inventory[item] = amount
    end
  end

  def potential_revenue
    @inventory.sum do |item, amount|
      item.price * amount
    end  
  end
end
