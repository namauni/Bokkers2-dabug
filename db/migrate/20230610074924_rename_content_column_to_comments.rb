class RenameContentColumnToComments < ActiveRecord::Migration[6.1]
  def change
    rename_column :comments, :content, :comment
  end
end
