class CreatePromos < ActiveRecord::Migration
  def change
    create_table :promos do |t|
      t.integer :value_id
      t.string :source
      t.attachment :image
      t.integer :order

      t.timestamps
    end
    add_index :promos, [:value_id, :order]
    add_index :promos, [:value_id, :source]
  end
end
