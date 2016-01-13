class Transaction
  attr_reader :customer, :product, :id
  @@transaction = []

  def initialize(customer, product)
    raise OutOfStockError.new "'#{product.title}' is out of stock." unless product.in_stock?

    @customer = customer
    @product = product
    @id = @@transaction.length + 1
    @product.update_product_inventory
    @@transaction << self
  end

  def self.find(id)
    all.find { |transaction| transaction.id == id }
  end

  def self.all
    @@transaction
  end
end
