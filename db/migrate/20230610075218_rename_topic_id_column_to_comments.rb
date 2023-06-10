class RenameTopicIdColumnToComments < ActiveRecord::Migration[6.1]
  def change
    rename_column :comments, :topic_id, :book_id
  end
end
