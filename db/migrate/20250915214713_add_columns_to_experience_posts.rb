class AddColumnsToExperiencePosts < ActiveRecord::Migration[7.2]
  def change
    add_column :experience_posts, :user_id, :bigint, null: false
    add_column :experience_posts, :industry_id, :bigint, null: false
    add_column :experience_posts, :occupation_id, :bigint, null: false
    add_column :experience_posts, :status, :string, limit: 16, null: false
    add_column :experience_posts, :published_at, :timestamptz
    add_column :experience_posts, :likes_count, :integer, null: false, default: 0
    add_column :experience_posts, :comments_count, :integer, null: false, default: 0

    # インデックス追加
    add_index :experience_posts, :user_id
    add_index :experience_posts, [ :industry_id, :created_at ]
    add_index :experience_posts, [ :occupation_id, :created_at ]
    add_index :experience_posts, [ :user_id, :created_at ]
  end
end
