class Transaction
  attr_reader :customer, :product, :id
  @@transaction = []

  def initialize(customer, product)
    @customer = customer
    @product = product
    @id = @@transaction.length + 1
    @product.update_product_inventory
    @@transaction << self
  end
end
