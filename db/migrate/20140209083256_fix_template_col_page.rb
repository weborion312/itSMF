class FixTemplateColPage < ActiveRecord::Migration
  def change
    rename_column :pages, :template_id, :designed_template_id
  end
end
