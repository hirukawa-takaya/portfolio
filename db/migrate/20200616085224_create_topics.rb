class CreateTopics < ActiveRecord::Migration[5.1]
  def change
    create_table :topics do |t|
      t.integer :user_id
      t.text :description
      t.string :image_path

      t.timestamps
    end
  end
end
