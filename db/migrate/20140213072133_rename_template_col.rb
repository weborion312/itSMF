class RenameTemplateCol < ActiveRecord::Migration
  def change

    rename_column :articles, :template_id, :designed_template_id
    rename_column :events, :template_id, :designed_template_id
  end
end
