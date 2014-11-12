class RenameTemplateTable < ActiveRecord::Migration
  def change
    rename_table :templates, :designed_templates
  end
end
