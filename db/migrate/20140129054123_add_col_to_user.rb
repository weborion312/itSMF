class AddColToUser < ActiveRecord::Migration
  def change
    add_column :users, :cover_file_name, :string
    add_column :users, :cover_content_type, :string
    add_column :users, :cover_file_size, :integer
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :birthdate, :date
  end
end
