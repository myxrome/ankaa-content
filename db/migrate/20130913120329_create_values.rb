class CreateValues < ActiveRecord::Migration
  def change
    create_table :values do |t|
      t.integer :category_id
      t.string :source
      t.string :name
      t.string :old_price
      t.string :new_price
      t.string :discount
      t.string :url
      t.boolean :active

      t.timestamps
    end

    add_index :values, [:category_id, :active, :updated_at]
    add_index :values, [:category_id, :source]
  end
end
