# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

addresses = ['686 Museum Rd', '1064 Center Dr', '444 Newell Dr', '1885 Stadium Rd', '330 Newell Dr']
food = ['Pizza', 'Wings', 'Sandwiches', 'Burritos', 'Other']

User.create(username: "admin", password: "password", email: "admin@example.com")
user = User.find_by(email: "admin@example.com")

40.times do |n|
  address =  addresses.sample + ", Gainesville, FL 32611 US"
  coor = Geocoder.search(address).first.coordinates
  lat = coor[0]
  long = coor[1]

  Event.create(
    org_name: "Org#{n}",
    building_name: "Building#{n}",
    room_number: "33#{n}",
    address_line_one: addresses.sample,
    food_type: food.sample,
    vegan: [true, false].sample,
    vegetarian: [true, false].sample,
    date: Date.today + [1, 2, 3, 4, 5, 6, -1, -2].sample.days,
    time: Time.now,
    lat: lat,
    long: long,
    user_id: user.id
  )
end
