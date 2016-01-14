class Transaction
  attr_reader :customer, :product, :id, :purchased_at
  @@transaction = []

  def initialize(customer, product)
    raise OutOfStockError.new "'#{product.title}' is out of stock." unless product.in_stock?

    @customer = customer
    @product = product
    @id = @@transaction.length + 1
    @product.update_product_inventory(:-)
    @purchased_at = Time.now
    @@transaction << self
  end

  def self.find(id)
    all.find { |transaction| transaction.id == id }
  end

  def self.where(customer:)
    all
      .select { |transaction| transaction.customer.name == customer }
      .map(&:to_s)
  end

  def self.delete(id)
    if find(id)
      transaction = find(id)
      all.delete(transaction)
      transaction.product.update_product_inventory(:+)
    else
      raise NoRecoredFound.new "Transaction with id: #{id} doesn't exists."
    end
  end

  def self.all
    @@transaction
  end

  def to_s
    "#{id}: #{customer.name} bought #{product.title} on [#{purchased_at}]"
  end
end
