class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.text :content
      t.date :publish_date
      t.datetime :start
      t.datetime :end
      t.string :locale
      t.integer :status
      t.string :browser_title
      t.string :browser_url
      t.string :cover_file_name
      t.string :cover_content_type
      t.integer :cover_file_size
      t.integer :template_id

      t.timestamps
    end
  end
end
