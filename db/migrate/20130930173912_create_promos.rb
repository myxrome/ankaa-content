class CreatePromos < ActiveRecord::Migration
  def change
    create_table :promos do |t|
      t.integer :value_id
      t.integer :order
      t.string :source
      t.attachment :image
      t.string :file_key

      t.timestamps
    end
    add_index :promos, [:value_id, :order]
    add_index :promos, [:value_id, :source]
  end
end
