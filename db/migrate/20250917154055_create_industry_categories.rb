class CreateIndustryCategories < ActiveRecord::Migration[7.2]
  def change
    create_table :industry_categories do |t|
      t.references :industry, null: false, foreign_key: true
      t.string  :name, null: false
      t.string  :code, null: false
      t.integer :position, default: 0, null: false
      t.timestamps
    end
    add_index :industry_categories, [:industry_id, :code], unique: true, name: "idx_indcat_industry_code"
    add_index :industry_categories, [:industry_id, :position]
  end
end
