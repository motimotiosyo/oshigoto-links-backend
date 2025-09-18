class CreateOccupations < ActiveRecord::Migration[7.2]
  def change
    create_table :occupations do |t|
      t.string :name

      t.timestamps
    end
    add_index :occupations, :name
  end
end
