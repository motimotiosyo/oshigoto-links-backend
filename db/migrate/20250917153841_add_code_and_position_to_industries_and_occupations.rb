class AddCodeAndPositionToIndustriesAndOccupations < ActiveRecord::Migration[7.2]
  def change
    add_column :industries,  :code,     :string
    add_column :industries,  :position, :integer, default: 0, null: false
    add_column :occupations, :code,     :string
    add_column :occupations, :position, :integer, default: 0, null: false

    add_index :industries,  :code, unique: true
    add_index :occupations, :code, unique: true
    add_index :industries,  :position
    add_index :occupations, :position
  end
end

