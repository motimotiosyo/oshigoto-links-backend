class CreateExperiences < ActiveRecord::Migration[7.2]
  def change
    create_table :experiences do |t|
      t.string :title, null: false, limit: 255
      t.text :body, null: false
      t.text :tags, array: true, default: []

      t.timestamps
    end

    add_index :experiences, :created_at
    add_index :experiences, :updated_at
    add_index :experiences, :tags, using: 'gin'
  end
end