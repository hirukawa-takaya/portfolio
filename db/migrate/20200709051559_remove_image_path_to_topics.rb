class RemoveImagePathToTopics < ActiveRecord::Migration[5.2]
  def change
    remove_column :topics, :image_path, :string
  end
end
