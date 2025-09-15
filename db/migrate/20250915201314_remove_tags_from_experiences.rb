class RemoveTagsFromExperiences < ActiveRecord::Migration[7.2]
  def change
    remove_column :experiences, :tags, :text
  end
end
