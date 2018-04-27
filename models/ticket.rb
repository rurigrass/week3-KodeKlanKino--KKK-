require_relative('../db/sql_runner')

class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id

  def initialize(option)
    @id = option["id"].to_i if option["id"]
    @customer_id = option["customer_id"].to_i
    @film_id = option["film_id"].to_i
  end

  def save()
    sql = "INSERT INTO tickets (customer_id, film_id) VALUES ($1, $2) RETURNING id"
    values = [@customer_id, @film_id]
    ticket = SqlRunner.run(sql, values).first
    @id = ticket["id"].to_i
  end

  def update()
   sql = "UPDATE tickets SET (customer_id, film_id) = ($1, $2) WHERE id = $3"
   values = [@customer_id, @film_id, @id]
   SqlRunner.run(sql, values)
  end

  def customer()
    sql = "SELECT * FROM customers WHERE id = $1"
    values = [@customer_id]
    customer_hash = SqlRunner.run(sql, values).first()
    return Customer.new(customer_hash)
  end

  def film()
    sql = "SELECT * FROM films WHERE id = $1"
    values = [@film_id]
    film_hash = SqlRunner.run(sql, values).first()
    return Film.new(film_hash)
  end

#Class methods

  def self.map_items(ticket_data)
    result = ticket_data.map { |ticket| Ticket.new(ticket) }
    return result
  end

  def self.all()
    sql = "SELECT * FROM tickets"
    ticket = SqlRunner.run(sql)
    return Ticket.map_items(ticket)
  end

  def self.delete_all()
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end


end
