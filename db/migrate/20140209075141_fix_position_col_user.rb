class FixPositionColUser < ActiveRecord::Migration
  def change
    rename_column :users, :postion, :position
  end
end
