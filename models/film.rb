require_relative('../db/sql_runner')

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize(option)
    @id = option["id"].to_i if option["id"]
    @title = option ["title"]
    @price = option ["price"]
  end

  def save()
    sql = "INSERT INTO films (title, price) VALUES ($1, $2) RETURNING id"
    values = [@title, @price]
    film = SqlRunner.run(sql, values).first
    @id = film["id"].to_i
  end

  def update()
   sql = "UPDATE films SET (title, price) = ($1, $2) WHERE id = $3"
   values = [@title, @price, @id]
   SqlRunner.run(sql, values)
  end

  def customers()
  sql = "SELECT customers.* FROM customers
         INNER JOIN tickets ON
         tickets.customer_id = customers.id
         WHERE tickets.film_id = $1"
  values = [@id]
  customer_hashes = SqlRunner.run(sql, values)
  customers = customer_hashes.map { |customer_hash|
  Customer.new( customer_hash )}
  return customers
  end

  ##Class methods

  def self.map_items(film)
  result = film.map { |film| Film.new(film) }
  return result
  end

  def self.all()
  sql = "SELECT * FROM films"
  film = SqlRunner.run(sql)
  return Film.map_items(film)
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end



end
