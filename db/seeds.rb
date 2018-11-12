# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Deleting Users"
User.delete_all
puts "Deleting Events"
Event.delete_all

addresses = ['686 Museum Rd', '1064 Center Dr', '444 Newell Dr', '1885 Stadium Rd', '330 Newell Dr']
building = ["Reitz Union", "NEB", "CISE", 'WEIL', "TURL" ]
food = ['Pizza', 'Wings', 'Sandwiches', 'Burritos', 'Other']

puts "Create Admin"
User.create(username: "admin", password: "password", email: "admin@example.com")
user = User.find_by(email: "admin@example.com")

puts "Creating Events"
5.times do |n|
  address =  addresses[n] + ", Gainesville, FL US"
  coor = Geocoder.search(address).first.coordinates
  lat = coor[0]
  long = coor[1]

  Event.create(
    org_name: "Org#{n}",
    building_name: building[n],
    room_number: "33#{n}",
    address_line_one: addresses[n],
    food_type: food[n],
    vegan: [true, false].sample,
    vegetarian: [true, false].sample,
    date: Date.today + [1, 2, 3, 4, 5][n].days,
    time: Time.now,
    lat: lat,
    long: long,
    user_id: user.id
  )
end

puts "Done!"
