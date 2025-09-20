class AddCategoryRefsToExperiencePosts < ActiveRecord::Migration[7.2]
  def change
    add_reference :experience_posts, :industry_category, null: true, foreign_key: true
    add_reference :experience_posts, :occupation_category, null: true, foreign_key: true
  end
end
