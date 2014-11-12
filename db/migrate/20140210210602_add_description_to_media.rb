class AddDescriptionToMedia < ActiveRecord::Migration
  def change
    add_column :media, :description, :text
  end
end
