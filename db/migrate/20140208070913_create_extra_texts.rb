class CreateExtraTexts < ActiveRecord::Migration
  def change
    create_table :extra_texts do |t|
      t.integer :page_id
      t.text :content

      t.timestamps
    end
  end
end
