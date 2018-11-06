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
