class RenameExperiencesToExperiencePosts < ActiveRecord::Migration[7.2]
  def change
    rename_table :experiences, :experience_posts
  end
end
