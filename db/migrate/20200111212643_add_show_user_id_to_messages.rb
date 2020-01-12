class AddShowUserIdToMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :show_user, :string
    add_index :messages, :show_user
  end
end
