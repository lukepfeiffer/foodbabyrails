Fabricator(:event) do
  org_name "Org"
  address_line_one "686 Museum Rd"
  room_number "E2120"
  building_name "Reitz Union"
  food_type "Pizza"
  vegan false
  vegetarian false
  date Date.today
  time Time.now
  lat 29.644920
  long -82.357193
end

Fabricator(:wings_event, from: :event) do
  food_type "Wings"
  room_number "E1111"
end

Fabricator(:past_event, from: :event) do
  date Date.yesterday - 1.day
  time Time.now - 1.day
end
