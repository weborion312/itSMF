class AddColToMenu < ActiveRecord::Migration
  def change
    add_column :menus, :parent_id, :integer
  end
end
