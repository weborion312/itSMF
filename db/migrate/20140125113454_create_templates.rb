class CreateTemplates < ActiveRecord::Migration
  def change
    create_table :templates do |t|
      t.string :name
      t.string :item_file_name
      t.string :item_content_type
      t.integer :item_file_size
      t.integer :status

      t.timestamps
    end
  end
end
