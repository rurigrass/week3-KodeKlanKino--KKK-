require('pry')
require_relative('models/ticket')
require_relative('models/film')
require_relative('models/customer')

Customer.delete_all()
Film.delete_all()
Ticket.delete_all()


customer1 = Customer.new({ "name" => "Joe", "fund" => 10 })
customer1.save()
customer2 = Customer.new({ "name" => "Ewan", "fund" => 15 })
customer2.save()
customer3 = Customer.new({ "name" => "Paul", "fund" => 20 })
customer3.save()

film1 = Film.new({ "title" => "Star Wars", "price" => 10 })
film1.save()
film2 = Film.new({ "title" => "Titanic", "price" => 5 })
film2.save
film3 = Film.new({ "title" => "Lord of the Rings", "price" => 7 })
film3.save

ticket1 = Ticket.new({ "customer_id" => customer1.id, "film_id" => film3.id })
ticket1.save()
ticket2 = Ticket.new({ "customer_id" => customer2.id, "film_id" => film2.id })
ticket2.save()
ticket3 = Ticket.new({ "customer_id" => customer3.id, "film_id" => film1.id })
ticket3.save()


binding.pry
nil
