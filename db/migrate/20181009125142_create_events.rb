class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :org_name
      t.string :address_line_one
      t.string :room_number
      t.string :building_name
      t.string :food_type
      t.boolean :vegan
      t.boolean :vegetarian
      t.decimal :lat
      t.decimal :long
      t.date :date
      t.time :time
    end
  end
end
