class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title
      t.string :browser_title
      t.string :browser_url
      t.text :content
      t.string :locale
      t.integer :status
      t.date :publish_date
      t.integer :template_id

      t.timestamps
    end
  end
end
