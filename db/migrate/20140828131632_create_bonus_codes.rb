class CreateBonusCodes < ActiveRecord::Migration
  def change
    create_table :bonus_codes do |t|
      t.string :code, length: 6
      t.boolean :voided, default: false
      t.string :download_token, length: 16
      t.datetime :download_token_expiration
      t.integer :downloads, default: 0
      
      t.timestamps
    end
    
    add_index :bonus_codes, [:code, :download_token]
  end
end
