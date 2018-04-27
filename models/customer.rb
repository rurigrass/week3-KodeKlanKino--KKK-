require_relative('../db/sql_runner')

class Customer

  attr_reader :id
  attr_accessor :name, :fund

  def initialize(option)
    @id = option["id"].to_i if option["id"]
    @name = option["name"]
    @fund = option["fund"]
  end

  def save()
    sql = "INSERT INTO customers (name, fund) VALUES ($1, $2) RETURNING id"
    values = [@name, @fund]
    customer = SqlRunner.run(sql, values).first
    @id = customer["id"].to_i
  end

  def update()
   sql = "UPDATE customers SET (name, fund) = ($1, $2) WHERE id = $3"
   values = [@name, @fund, @id]
   SqlRunner.run(sql, values)
  end

  def films()
  sql = "SELECT films.* FROM films
         INNER JOIN tickets ON
         tickets.film_id = films.id
         WHERE tickets.customer_id = $1"
  values = [@id]
  film_hashes = SqlRunner.run(sql, values)
  films = film_hashes.map { |film_hash|
  Film.new( film_hash )}
  return films
  end

#Class methods

  def self.map_items(customer)
  result = customer.map { |customer| Customer.new(customer) }
  return result
  end

  def self.all()
  sql = "SELECT * FROM customers"
  customer = SqlRunner.run(sql)
  return Customer.map_items(customer)
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

end
