class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :account_name, limit: 50, null: false
      t.string :email, limit: 255, null: false
      t.string :encrypted_password, limit: 255, null: false

      t.timestamps null: false, default: -> { 'CURRENT_TIMESTAMP' }
    end

    add_index :users, :email, unique: true
  end
end
