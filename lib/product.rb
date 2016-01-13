class Product
  attr_reader :title, :price, :stock

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

  private

  def add_to_products
    @@products.each do |product|
      raise DuplicateProductError.new "'#{title}' already exists." if product.title == title
    end

    @@products << self
  end
end
