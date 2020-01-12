class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.text :text
      t.references :room, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :show_user_id
      t.timestamps
    end
  end
end
