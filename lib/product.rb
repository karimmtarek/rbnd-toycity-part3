class Product
  attr_reader :title, :price
  attr_accessor :stock

  @@products = []

  def initialize(args = {})
    @title = args[:title]
    @price = args[:price]
    @stock = args[:stock]

    add_to_products
  end

  def self.find_by_title(title)
    all.find { |product| product.title == title }
  end

  def self.all
    @@products
  end

  def self.in_stock
    all.select(&:in_stock?)
  end

  def in_stock?
    stock > 0
  end

  def update_product_inventory
    self.stock -= 1
  end

  private

  def add_to_products
    @@products.each do |product|
      raise DuplicateProductError.new "'#{title}' already exists." if product.title == title
    end

    @@products << self
  end
end
