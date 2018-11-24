class AddIsConfirmedToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :is_confirmed, :boolean
    add_column :users, :confirmation_token, :string
  end
end
