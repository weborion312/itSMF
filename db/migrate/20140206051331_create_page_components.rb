class CreatePageComponents < ActiveRecord::Migration
  def change
    create_table :page_components do |t|
      t.integer :page_id
      t.string :component_table

      t.timestamps
    end
  end
end
