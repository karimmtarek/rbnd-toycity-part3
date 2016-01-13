class Customer
  attr_reader :name

  @@customers = []

  def initialize(args = {})
    @name = args[:name]
    add_to_customers
  end

  def self.find_by_name(name)
    all.find(&:name)
  end

  def self.all
    @@customers
  end

  private

  def add_to_customers
    @@customers.each do |customer|
      raise DuplicateProductError.new "'#{name}' already exists." if customer.name == name
    end

    @@customers << self
  end
end
