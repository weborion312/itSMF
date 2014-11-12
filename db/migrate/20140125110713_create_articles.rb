class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :content
      t.date :publish_date
      t.integer :author
      t.string :locale
      t.integer :status
      t.string :browser_url
      t.string :browser_title
      t.string :cover_file_name
      t.string :cover_content_type
      t.integer :cover_file_size
      t.integer :template_id

      t.timestamps
    end
  end
end
