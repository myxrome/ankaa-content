class CreateValues < ActiveRecord::Migration
  def change
    create_table :values do |t|
      t.integer :category_id
      t.boolean :active
      t.string :source
      t.attachment :thumb
      t.string :file_key
      t.string :name
      t.string :old_price
      t.string :new_price
      t.string :discount
      t.string :url

      t.timestamps
    end

    add_index :values, [:category_id, :active]
    add_index :values, [:category_id, :updated_at]
    add_index :values, [:category_id, :source]
  end
end
