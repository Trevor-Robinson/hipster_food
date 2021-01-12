class Item
  attr_reader :name,
              :price
  def initialize(info)
    @name = info[:name]
    @price = info[:price].sub('$','').to_f
  end
end
