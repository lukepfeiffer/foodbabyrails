class AddIsConfirmedToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :is_confirmed, :boolean
  end
end
