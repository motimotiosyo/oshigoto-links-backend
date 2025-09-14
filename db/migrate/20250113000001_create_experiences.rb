class CreateExperiences < ActiveRecord::Migration[7.2]
  def change
    create_table :experiences do |t|
      t.string :title, null: false, limit: 255
      t.text :body, null: false
      t.text :tags, array: true, default: []

      t.timestamps
    end

    add_index :stories, :created_at
    add_index :stories, :updated_at
    add_index :stories, :tags, using: 'gin'
  end
end