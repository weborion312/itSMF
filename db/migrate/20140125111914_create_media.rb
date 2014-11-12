class CreateMedia < ActiveRecord::Migration
  def change
    create_table :media do |t|
      t.string :title
      t.integer :media_type
      t.string :item_file_name
      t.string :item_content_type
      t.integer :item_file_size
      t.text :redirect_url
      t.integer :status
      t.boolean :redirect_url_on
      t.integer :template_id

      t.timestamps
    end
  end
end
