class AddClickableToMenu < ActiveRecord::Migration
  def change
    add_column :menus, :is_clickable, :boolean
  end
end
