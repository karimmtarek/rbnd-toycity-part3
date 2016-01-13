class Product
  attr_reader :title, :price, :stock

  @@products = []

  def initialize(args = {})
    @title = args[:title]
    @price = args[:price]
    @stock = args[:stock]
    @@products << self
  end

  def self.all
    @@products
  end
end
