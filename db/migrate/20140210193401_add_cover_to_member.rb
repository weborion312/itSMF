class AddCoverToMember < ActiveRecord::Migration
  def change
    add_column :members, :cover_file_name, :string
    add_column :members, :cover_content_type, :string
    add_column :members, :cover_file_size, :integer
  end
end
