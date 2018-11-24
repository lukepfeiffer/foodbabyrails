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

addresses = [
              'Reitz Union Hotel, Museum Road, Gainesville, FL, USA', 
              'Library West, West University Avenue, Gainesville, FL, USA', 
	      'UF MSL, Newell Drive, Gainesville, FL, USA', 
	      'New Physics Building (NPB), Gale Lemerand Drive, Gainesville, FL, USA', 
	      'Turlington Plaza, Newell Drive, Gainesville, FL, USA'
	    ]
lat = [
	 "29.6462745",     #reitz
	 "29.6514302",	   #Library West
	 "29.6479842",     #Marston
	 "29.6438149",     #NPB
	 "29.6490825"      #Turlington
      ]
long = [
	 "-82.34775339999999",   #reitz
	 "-82.34290020000003",   #Library west
	 "-82.34400219999998",   #Marston
	 "-82.34969619999998",   #NPB
	 "-82.34373529999999",   #Turlington
       ]	
buildings = [
	      "Reitz Union",
	      "Library West",
	      "Marston",
	      "NPB",
	      "Turlington"
            ]

food = ['Pizza', 'Wings', 'Sandwiches', 'Burritos', 'Other']

puts "Create Admin"
User.create(username: "admin", password: "password", email: "admin@ufl.edu", is_confirmed: true)
user = User.find_by(email: "admin@ufl.edu")

puts "Creating Events"
5.times do |n|
  address =  addresses[n]
  latitude = lat[n]
  longitude = long[n]
  building = buildings[n]

  Event.create(
    org_name: "Org#{n}",
    building_name: building,
    room_number: "33#{n}",
    address_line_one: addresses[n],
    food_type: food[n],
    vegan: [true, false].sample,
    vegetarian: [true, false].sample,
    date: Date.today + [1, 2, 3, 4, 5][n].days,
    time: Time.now,
    lat: latitude,
    long: longitude,
    user_id: user.id
  )
end

puts "Done!"
