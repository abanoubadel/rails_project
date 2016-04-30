# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



15.times do |i|
  ItemsOrder.create(user_id: rand(1..3),
                    item_id: rand(1..2),
                    order_id: rand(1..3))
end