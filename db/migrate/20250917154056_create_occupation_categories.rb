class CreateOccupationCategories < ActiveRecord::Migration[7.2]
  def change
    create_table :occupation_categories do |t|
      t.references :occupation, null: false, foreign_key: true
      t.string  :name, null: false
      t.string  :code, null: false
      t.integer :position, default: 0, null: false
      t.timestamps
    end
    add_index :occupation_categories, [:occupation_id, :code], unique: true, name: "idx_occucat_occupation_code"
    add_index :occupation_categories, [:occupation_id, :position]
  end
end
