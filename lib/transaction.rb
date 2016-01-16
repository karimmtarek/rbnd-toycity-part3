class Transaction
  attr_reader :customer, :product, :id, :purchased_at
  @@transaction = []

  def initialize(customer, product)
    return puts "OutOfStockError: '#{product.title}' is out of stock." unless product.in_stock?

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
      .map(&:human_readable)
  end

  def self.delete(id)
    if find(id)
      transaction = find(id)
      all.delete(transaction)
      transaction.product.update_product_inventory(:+)
    else
      return puts  "NoRecoredFound: Transaction with id: #{id} doesn't exists."
    end
  end

  def self.all
    @@transaction
  end

  def human_readable
    "#{id}: #{customer.name} bought #{product.title} on [#{purchased_at}]"
  end
end
