class AddRoleToUser < ActiveRecord::Migration
  def change
    add_column :users, :role_id, :integer
    add_column :users, :postion, :string
  end
end
