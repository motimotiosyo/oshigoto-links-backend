class CreateIndustries < ActiveRecord::Migration[7.2]
  def change
    create_table :industries do |t|
      t.string :name

      t.timestamps
    end
    add_index :industries, :name
  end
end
