class ChangeExperiencesTitleLimit < ActiveRecord::Migration[7.2]
  def change
    change_column :experiences, :title, :string, limit: 120, null: false
  end
end
